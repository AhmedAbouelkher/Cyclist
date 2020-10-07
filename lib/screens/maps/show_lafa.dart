import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cyclist/GoeLocation/models.dart';
import 'package:cyclist/models/Rides/rides_response.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/constants.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/map_style_picker.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cyclist/GoeLocation/geo_locator.dart';
import 'package:cyclist/utils/extensions.dart';

class ShowLafa extends StatefulWidget {
  final CLocation currentUserLocation;
  final Ride ride;
  final VoidCallback onChange;

  const ShowLafa({Key key, this.currentUserLocation, this.onChange, this.ride}) : super(key: key);
  @override
  _ShowLafaState createState() => _ShowLafaState();
}

class _ShowLafaState extends State<ShowLafa> {
  bool _isLoading = false;
  GoogleMapController _controller;
  MapType _mapType = MapType.normal;
  List<Marker> _markers = [];
  List<Circle> _circles = [];
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints;
  PolylineResultExtended _polylineResultExtended;
  BitmapDescriptor pinLocationIcon;
  final _sizeFactor = 0.9;

  final int globalIconsWidth = 60;

  double _totalDistance;
  int _totalTime;
  /*
  Post Data
  */
  String _startTime;
  String _endTime;
  DateTime _date;
  CLocation _startLocation;
  CLocation _endLocation;

  @override
  void initState() {
    super.initState();
    _startTime = widget.ride.startAt;
    _endTime = widget.ride.endAt;
    _date = widget.ride.date;
    _circles?.add(
      Circle(
        circleId: CircleId("home_circle"),
        radius: 80,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: widget.currentUserLocation.toLatLng(),
        fillColor: Colors.blue.withAlpha(40),
        strokeWidth: 1,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _configerMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final trs = AppTranslations.of(context);
    var cameraPosition = CameraPosition(
      zoom: 15.0,
      target: widget.currentUserLocation.toLatLng(),
    );
    return Scaffold(
      appBar: StanderedAppBar(),
      body: ModalProgressHUD(
        dismissible: true,
        inAsyncCall: _isLoading,
        progressIndicator: AdaptiveProgessIndicator(),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(context, size, trs),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.clock, size: 18),
                    SizedBox(width: 10),
                    Text(
                      trs.translate("time"),
                      style: TextStyle(fontSize: 17 * _sizeFactor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              _addTime(trs, context),
              SizedBox(height: 5),
              Divider(endIndent: 20, indent: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.calendarAlt, size: 18),
                    SizedBox(width: 10),
                    Text(
                      trs.translate("date"),
                      style: TextStyle(fontSize: 17 * _sizeFactor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              _addDate(trs, context),
              SizedBox(height: 20),
              _buildMap(cameraPosition, trs, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap(CameraPosition cameraPosition, AppTranslations trs, BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          GoogleMap(
            tiltGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: Set.from(_markers),
            circles: Set.from(_circles),
            polylines: Set.from(polylines.values),
            mapType: _mapType,
            onMapCreated: (controller) => _controller = controller,
            initialCameraPosition: cameraPosition,
          ),
          _buildMapControlles(trs, context),
          if (_totalDistance != null) ...[
            Align(
              alignment: Alignment(-.95, -.95),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(FontAwesomeIcons.biking, color: CColors.darkGreenAccent, size: 17),
                          SizedBox(width: 5),
                          Text(
                            _totalDistance.getDistance,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(FontAwesomeIcons.clock, color: CColors.darkGreenAccent, size: 17),
                          SizedBox(width: 5),
                          Text(
                            "${(_totalTime / 60).toStringAsFixed(0)} min",
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Align _buildMapControlles(AppTranslations trs, BuildContext context) {
    return Align(
      alignment: Alignment(trs.isArabic ? 0.9 : -0.9, -0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipOval(
            child: Material(
              color: CColors.darkGreenAccent, // button color
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChooseMapStyle(
                                mapType: _mapType,
                                onChanged: (value) {
                                  print(value);
                                  setState(() => _mapType = value);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Icon(
                    FontAwesomeIcons.layerGroup,
                    color: CColors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          ClipOval(
            child: Material(
              color: CColors.darkGreenAccent,
              child: InkWell(
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Icon(
                    FontAwesomeIcons.plus,
                    color: CColors.lightGreen,
                    size: 15,
                  ),
                ),
                onTap: () => _controller.animateCamera(
                  CameraUpdate.zoomIn(),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ClipOval(
            child: Material(
              color: CColors.darkGreenAccent, // button color
              child: InkWell(
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Icon(
                    FontAwesomeIcons.minus,
                    color: CColors.lightGreen,
                    size: 15,
                  ),
                ),
                onTap: () => _controller.animateCamera(
                  CameraUpdate.zoomOut(),
                ),
              ),
            ),
          ),
          SizedBox(height: 150),
          ClipOval(
            child: Material(
              color: CColors.darkGreenAccent,
              elevation: 3,
              child: InkWell(
                onTap: () => _controller.animateCamera(CameraUpdate.newLatLngZoom(widget.currentUserLocation.toLatLng(), 16)),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: FaIcon(
                      Icons.my_location,
                      color: CColors.lightGreen,
                      // size: 17,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildHeader(BuildContext context, Size size, AppTranslations trs) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: CColors.darkGreenAccent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: LangReversed(
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: size.aspectRatio * 50,
                            color: Colors.white,
                          ),
                        ),
                        replacment: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: size.aspectRatio * 50,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.biking, color: CColors.darkGreenAccent),
                SizedBox(width: 10),
                Text(trs.translate("lafa_number") + "\t#${widget.ride.id}\t", style: TextStyle(color: CColors.boldBlack, fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addDate(AppTranslations trs, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * _sizeFactor),
      child: Row(
        children: [
          Text(trs.translate("date_day")),
          SizedBox(width: 5),
          Card(
            elevation: 2,
            color: CColors.darkWhite,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15 * _sizeFactor),
              child: Center(
                child: Text(
                  _date.dayMonthYearNonUSFormate,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 17 * _sizeFactor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addTime(AppTranslations trs, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * _sizeFactor),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(trs.translate("start_time")),
                SizedBox(width: 5),
                Card(
                  elevation: 2,
                  color: CColors.darkWhite,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15 * _sizeFactor),
                    child: Center(
                      child: Text(
                        _startTime,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 17 * _sizeFactor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(trs.translate("end_time")),
                SizedBox(width: 5),
                Card(
                  elevation: 2,
                  color: CColors.darkWhite,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15 * _sizeFactor),
                    child: Center(
                      child: Text(
                        _endTime,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 17 * _sizeFactor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _createPolylines(Position start, Position destination) async {
    final trs = AppTranslations.of(context);
    polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.apiKey,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.walking,
      langCode: trs.locale.languageCode,
    );

    if (result.points.isNotEmpty) {
      _polylineResultExtended = result.polylineResultExtended;
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      _totalDistance = _polylineResultExtended.routes.first.legs.first.distance.value.toDouble();
      _totalTime = _polylineResultExtended.routes.first.legs.first.duration.value;
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: CColors.darkGreenAccent,
      points: polylineCoordinates,
      width: 3,
      startCap: Cap.buttCap,
      endCap: Cap.roundCap,
    );
    polylines[id] = polyline;
  }

  Future<void> _fitMarkers(CLocation startCoordinates, CLocation destinationCoordinates) async {
    final LatLng offerLatLng = LatLng(
      destinationCoordinates.lat,
      destinationCoordinates.lang,
    );

    LatLngBounds bound;
    if (offerLatLng.latitude > startCoordinates.lat && offerLatLng.longitude > startCoordinates.lang) {
      bound = LatLngBounds(southwest: startCoordinates.toLatLng(), northeast: offerLatLng);
    } else if (offerLatLng.longitude > startCoordinates.lang) {
      bound = LatLngBounds(
        southwest: LatLng(offerLatLng.latitude, startCoordinates.lang),
        northeast: LatLng(startCoordinates.lat, offerLatLng.longitude),
      );
    } else if (offerLatLng.latitude > startCoordinates.lat) {
      bound = LatLngBounds(
        southwest: LatLng(startCoordinates.lat, offerLatLng.longitude),
        northeast: LatLng(offerLatLng.latitude, startCoordinates.lang),
      );
    } else {
      bound = LatLngBounds(southwest: offerLatLng, northeast: startCoordinates.toLatLng());
    }

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 80);
    return await _controller.animateCamera(u2);
  }

  ///  Function to Convert image path to ` BitmapDescriptor` to can use it for icon in map.
  /// `Width` is an `int` datatype
  Future<BitmapDescriptor> getMarker(String path, {int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    final _data = (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    return BitmapDescriptor.fromBytes(_data);
  }

  void _configerMap() async {
    final trs = AppTranslations.of(context);
    _startLocation = widget.ride.startLocation.toLocation();
    _endLocation = widget.ride.finishLocation.toLocation();
    final _startIcon = await getMarker(Constants.startPin, width: globalIconsWidth);
    _markers?.add(
      Marker(
        markerId: MarkerId(Random().nextInt(6536261).toString()),
        position: _startLocation.toLatLng(),
        draggable: false,
        icon: _startIcon,
        infoWindow: InfoWindow(
          title: trs.translate("start_line"),
          snippet: widget.ride.addressStart,
        ),
      ),
    );
    final _finishIcon = await getMarker(Constants.finishPin, width: globalIconsWidth);
    _markers?.add(
      Marker(
        markerId: MarkerId(Random().nextInt(6536261).toString()),
        position: _endLocation.toLatLng(),
        draggable: false,
        icon: _finishIcon,
        infoWindow: InfoWindow(
          title: trs.translate("finish_line"),
          snippet: widget.ride.addressFinish,
        ),
      ),
    );
    await _createPolylines(
      _startLocation.toPosition(),
      _endLocation.toPosition(),
    );

    setState(() {});
    _fitMarkers(_startLocation, _endLocation);
  }
}
