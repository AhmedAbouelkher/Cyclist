import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cyclist/GoeLocation/models.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/constants.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/map_style_picker.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:platform_date_picker/platform_date_picker.dart';
import 'package:cyclist/GoeLocation/geo_locator.dart';
import 'package:cyclist/utils/extensions.dart';

class AddNewLafa extends StatefulWidget {
  final CLocation currentUserLocation;

  const AddNewLafa({Key key, this.currentUserLocation}) : super(key: key);
  @override
  _AddNewLafaState createState() => _AddNewLafaState();
}

class _AddNewLafaState extends State<AddNewLafa> {
  GoogleMapController _controller;
  MapType _mapType = MapType.normal;

  int _currentIndex = 0;
  List<Marker> _markers = [];
  List<Circle> _circles = [];
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints;
  PolylineResultExtended _polylineResultExtended;
  BitmapDescriptor pinLocationIcon;
  String _startTime;
  String _endTime;
  DateTime _date;
  final _sizeFactor = 0.9;
  PageController _pageController;
  final int globalIconsWidth = 60;
  double _totalDistance;
  int _totalTime;
  CLocation _startLocation;
  CLocation _endLocation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.75,
    );
    _startTime = TimeOfDay.now().formatTimeOfDay;
    _endTime = TimeOfDay.now().formatTimeOfDay;
    _date = DateTime.now();
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
  }

  Future<void> _toggleViews({bool finish = false}) async {
    if (finish) {
      if (_currentIndex == 2) {
        _currentIndex = 1;
        return _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      } else if (_currentIndex == 1) {
        _currentIndex = 2;
        return _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    }
    if (_currentIndex == 1) {
      _currentIndex = 0;
      return _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    } else if (_currentIndex == 0) {
      _currentIndex = 1;
      return _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    }
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
      body: SafeArea(
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
            Expanded(
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
                    onTap: (position) async {
                      final int _stageIndex = _pageController.page.toInt();
                      bool _isFinishLine = false;
                      if (_stageIndex == 2) return;
                      polylines?.clear();
                      polylineCoordinates?.clear();
                      bool _createPolyLines;
                      Marker _lastMarker;
                      if (_stageIndex == 0) {
                        if (_markers.length >= 2) {
                          _lastMarker = _markers.last;
                          _markers?.clear();
                          _createPolyLines = true;
                        } else {
                          _markers?.clear();
                        }
                        _startLocation = position.toLocation();
                        _isFinishLine = false;
                      } else if (_stageIndex == 1) {
                        if (_markers.length != 1) {
                          _markers.removeLast();
                        }
                        _createPolyLines = true;
                        _endLocation = position.toLocation();
                        _isFinishLine = true;
                      }
                      BitmapDescriptor _icon;
                      if (_isFinishLine) {
                        _icon = await getMarker(Constants.finishPin, width: globalIconsWidth);
                      } else {
                        _icon = await getMarker(Constants.startPin, width: globalIconsWidth);
                      }
                      _markers?.add(
                        Marker(
                            markerId: MarkerId(position.toString()),
                            position: position,
                            draggable: true,
                            icon: _icon,
                            onDragEnd: (newPosition) async {
                              final _canRedrawPolylines = _startLocation != null && _endLocation != null;
                              if (_canRedrawPolylines) {
                                if (_stageIndex == 0) {
                                  _startLocation = newPosition.toLocation();
                                } else if (_stageIndex == 1) {
                                  _endLocation = newPosition.toLocation();
                                }
                                _createPolyLines = false;
                                polylines?.clear();
                                polylineCoordinates?.clear();
                                await _createPolylines(
                                  _startLocation.toPosition(),
                                  _endLocation.toPosition(),
                                );
                                setState(() {});
                              }
                            }),
                      );
                      if (_lastMarker != null) _markers?.add(_lastMarker);
                      setState(() {});
                      if (_createPolyLines ?? false) {
                        await _createPolylines(
                          _startLocation.toPosition(),
                          _endLocation.toPosition(),
                        );
                        setState(() {});
                      }
                      // _controller.animateCamera(CameraUpdate.newLatLng(position));
                    },
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
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        constraints: BoxConstraints(maxHeight: 80 * 0.70),
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 0,
              color: _markers.length < 1 ? CColors.boldBlackAccent : CColors.darkGreenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: IgnorePointer(
                ignoring: _markers.length < 1,
                child: InkWell(
                  onTap: () {
                    _toggleViews();
                  },
                  child: Center(
                    child: Text(
                      _markers.length < 1 ? trs.translate("choose_start_line") : trs.translate("edit_choose_start_line"),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 0,
              color: _markers.length < 2 ? CColors.boldBlackAccent : CColors.darkGreenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0.9, 0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidArrowAltCircleRight,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _toggleViews();
                        },
                      ),
                    ),
                    // Align(alignment: Alignment(0.6, 0), child: Container(color: Colors.white, width: 0.5, height: 24)),
                    Center(
                      child: InkWell(
                        onTap: () {
                          _toggleViews(finish: true);
                        },
                        child: Text(
                          _markers.length < 2 ? trs.translate("choose_finish_line") : trs.translate("edit_choose_finish_line"),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 0,
              color: CColors.darkGreenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0.9, 0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidArrowAltCircleRight,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _toggleViews(finish: true);
                        },
                      ),
                    ),
                    // Align(alignment: Alignment(0.55, 0), child: Container(color: Colors.white, width: 0.5, height: 24)),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            trs.translate("add_lafa"),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(FontAwesomeIcons.plus, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                Text(trs.translate("add_new_lafa"), style: TextStyle(color: CColors.boldBlack, fontSize: 18)),
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
          InkWell(
            onTap: () async {
              DateTime date = await PlatformDatePicker.showDate(
                context: context,
                firstDate: DateTime(DateTime.now().year - 2),
                initialDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 2),
              );
              if (date != null) {
                setState(() => _date = date);
              }
            },
            child: Card(
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
                InkWell(
                  onTap: () async {
                    TimeOfDay temp = await PlatformDatePicker.showTime(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    if (temp != null) {
                      setState(() => _startTime = temp.formatTimeOfDay);
                    }
                  },
                  child: Card(
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
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(trs.translate("end_time")),
                SizedBox(width: 5),
                InkWell(
                  onTap: () async {
                    TimeOfDay temp = await PlatformDatePicker.showTime(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    if (temp != null) {
                      setState(() => _endTime = temp.formatTimeOfDay);
                    }
                  },
                  child: Card(
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

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }
}
