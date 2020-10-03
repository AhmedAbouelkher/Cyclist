import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:cyclist/utils/locales/app_translations.dart';

import '../place_picker.dart';
import '../uuid.dart';

/// Place picker widget made with map widget from
/// [google_maps_flutter](https://github.com/flutter/plugins/tree/master/packages/google_maps_flutter)
/// and other API calls to [Google Places API](https://developers.google.com/places/web-service/intro)
///
/// API key provided should have `Maps SDK for Android`, `Maps SDK for iOS`
/// and `Places API`  enabled for it
class PlacePicker extends StatefulWidget {
  /// API key generated from Google Cloud Console. You can get an API key
  /// [here](https://cloud.google.com/maps-platform/)
  final String apiKey;

  /// Location to be displayed when screen is showed. If this is set or not null, the
  /// map does not pan to the user's current location.
  final LatLng displayLocation;

  final String local;
  final AppTranslations trs;

  PlacePicker(this.apiKey, {this.displayLocation, this.local = 'en', this.trs});

  @override
  State<StatefulWidget> createState() => PlacePickerState();
}

/// Place picker state
class PlacePickerState extends State<PlacePicker> {
  final Completer<GoogleMapController> mapController = Completer();

  /// Indicator for the selected location
  final Set<Marker> markers = Set();

  /// Result returned after user completes selection
  LocationResult locationResult;

  /// Overlay to display autocomplete suggestions
  OverlayEntry overlayEntry;

  List<NearbyPlace> nearbyPlaces = List();

  /// Session token required for autocomplete API call
  String sessionToken = Uuid().generateV4();

  GlobalKey appBarKey = GlobalKey();

  bool hasSearchTerm = false;

  String previousSearchTerm = '';

  bool _notSupportedCity = true;

  bool _isLoadingSiteData = false;

  // constructor
  PlacePickerState();

  void onMapCreated(GoogleMapController controller) {
    this.mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
      position: widget.displayLocation ?? LatLng(5.6037, 0.1870),
      markerId: MarkerId("selected-location"),
    ));
  }

  @override
  void dispose() {
    this.overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   key: this.appBarKey,
      //   title: ,
      //   centerTitle: true,
      //   leading: null,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   elevation: 1,
      // ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: widget.displayLocation ?? LatLng(5.6037, 0.1870), zoom: 15),
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: onMapCreated,
                onTap: (latLng) {
                  clearOverlay();
                  moveToLocation(latLng);
                },
                // onCameraMove: (position) {
                //   FocusScope.of(context).unfocus();
                // },
                markers: markers,
              ),
            ),
            // if (!this.hasSearchTerm)
            Positioned.fill(
              top: null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SelectPlaceAction(
                    getLocationName(),
                    () => Navigator.of(context).pop(this.locationResult),
                    widget.trs,
                    isCitySupported: _notSupportedCity,
                    isLoading: _isLoadingSiteData,
                  ),
                  // Divider(height: 8),
                  // Padding(
                  //   child: Text("Nearby Places", style: TextStyle(fontSize: 16)),
                  //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  // ),
                  // Expanded(
                  //   child: ListView(
                  //     children: nearbyPlaces.map((it) => NearbyPlaceItem(it, () => moveToLocation(it.latLng))).toList(),
                  //   ),
                  // ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, -0.95),
              child: SearchInput(
                searchPlace,
                widget.trs,
                key: appBarKey,
              ),
            ),
            Align(
              alignment: Alignment(0.95, -0.8),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).accentColor,
                        elevation: 3,
                        child: InkWell(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => this.mapController.future.then((controller) {
                            controller.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).accentColor,
                        elevation: 3,
                        child: InkWell(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => this.mapController.future.then((controller) {
                            controller.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.95, 0.7),
              child: ClipOval(
                child: Material(
                  color: Theme.of(context).accentColor,
                  elevation: 5,
                  child: InkWell(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => moveToLocation(widget.displayLocation),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    if (this.overlayEntry != null) {
      this.overlayEntry.remove();
      this.overlayEntry = null;
    }
  }

  /// Begins the search process by displaying a "wait" overlay then
  /// proceeds to fetch the autocomplete list. The bottom "dialog"
  /// is hidden so as to give more room and better experience for the
  /// autocomplete list overlay.
  void searchPlace(String place) {
    // on keyboard dismissal, the search was being triggered again
    // this is to cap that.
    if (place == this.previousSearchTerm) {
      return;
    }

    previousSearchTerm = place;

    if (context == null) {
      return;
    }

    clearOverlay();

    setState(() {
      hasSearchTerm = place.length > 0;
    });

    if (place.length < 1) {
      return;
    }

    final RenderBox renderBox = context.findRenderObject();
    final size = renderBox.size;

    final RenderBox appBarBox = this.appBarKey.currentContext.findRenderObject();

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarBox.size.height,
        width: size.width,
        child: Material(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              children: <Widget>[
                SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 3)),
                SizedBox(width: 24),
                Expanded(child: Text(widget.trs.translate("searching"), style: TextStyle(fontSize: 16)))
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(this.overlayEntry);

    autoCompleteSearch(place);
  }

  /// Fetches the place autocomplete list with the query [place].
  void autoCompleteSearch(String place) async {
    try {
      place = place.replaceAll(" ", "+");

      var endpoint = "https://maps.googleapis.com/maps/api/place/autocomplete/json?" +
          "key=${widget.apiKey}&" +
          "input={$place}&sessiontoken=${this.sessionToken}&language=${widget.local}";
      if (this.locationResult != null) {
        endpoint += "&location=${this.locationResult.latLng.latitude}," + "${this.locationResult.latLng.longitude}";
      }

      final response = await http.get(endpoint);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['predictions'] == null) {
        throw Error();
      }

      List<dynamic> predictions = responseJson['predictions'];

      List<RichSuggestion> suggestions = [];

      if (predictions.isEmpty) {
        AutoCompleteItem aci = AutoCompleteItem();
        aci.text = "No result found";
        aci.offset = 0;
        aci.length = 0;

        suggestions.add(RichSuggestion(aci, () {}));
      } else {
        for (dynamic t in predictions) {
          final aci = AutoCompleteItem()
            ..id = t['place_id']
            ..text = t['description']
            ..offset = t['matched_substrings'][0]['offset']
            ..length = t['matched_substrings'][0]['length'];

          suggestions.add(RichSuggestion(aci, () {
            FocusScope.of(context).requestFocus(FocusNode());
            decodeAndSelectPlace(aci.id);
          }));
        }
      }

      displayAutoCompleteSuggestions(suggestions);
    } catch (e) {
      print(e);
    }
  }

  /// To navigate to the selected place from the autocomplete list to the map,
  /// the lat,lng is required. This method fetches the lat,lng of the place and
  /// proceeds to moving the map to that location.
  void decodeAndSelectPlace(String placeId) async {
    clearOverlay();

    try {
      final response =
          await http.get("https://maps.googleapis.com/maps/api/place/details/json?key=${widget.apiKey}" + "&placeid=$placeId&language=${widget.local}");

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['result'] == null) {
        throw Error();
      }

      final location = responseJson['result']['geometry']['location'];
      moveToLocation(LatLng(location['lat'], location['lng']));
    } catch (e) {
      print(e);
    }
  }

  /// Display autocomplete suggestions with the overlay.
  void displayAutoCompleteSuggestions(List<RichSuggestion> suggestions) {
    // final RenderBox renderBox = context.findRenderObject();
    // Size size = renderBox.size;

    final RenderBox appBarBox = this.appBarKey.currentContext.findRenderObject();
    Size size = appBarBox.size;
    Offset renderPosition = appBarBox.localToGlobal(Offset.zero);

    clearOverlay();

    this.overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: renderPosition.dy * 1.95,
          left: renderPosition.dx,
          width: size.width,
          child: Material(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: suggestions,
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(this.overlayEntry);
  }

  /// Utility function to get clean readable name of a location. First checks
  /// for a human-readable name from the nearby list. This helps in the cases
  /// that the user selects from the nearby list (and expects to see that as a
  /// result, instead of road name). If no name is found from the nearby list,
  /// then the road name returned is used instead.
  String getLocationName() {
    if (this.locationResult == null) {
      return widget.trs.translate("error_happended");
    }

    // try {
    //   for (NearbyPlace np in this.nearbyPlaces) {
    //     if (np.latLng == this.locationResult.latLng && np.name != this.locationResult.locality) {
    //       this.locationResult.name = np.name;
    //       return "${np.name}, ${this.locationResult.locality}";
    //     }
    //   }
    // } catch (e) {
    //   print("ERROR $e");
    // }

    return "${this.locationResult.name}, ${this.locationResult.locality}";
  }

  /// Moves the marker to the indicated lat,lng
  void setMarker(LatLng latLng) {
    // markers.clear();
    setState(() {
      markers.clear();
      markers.add(Marker(markerId: MarkerId("selected-location"), position: latLng));
    });
  }

  /// Fetches and updates the nearby places to the provided lat,lng
  void getNearbyPlaces(LatLng latLng) async {
    try {
      final response = await http.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?" +
          "key=${widget.apiKey}&language=${widget.local}&" +
          "location=${latLng.latitude},${latLng.longitude}&radius=150");

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      this.nearbyPlaces.clear();

      for (Map<String, dynamic> item in responseJson['results']) {
        final nearbyPlace = NearbyPlace()
          ..name = item['name']
          ..icon = item['icon']
          ..latLng = LatLng(item['geometry']['location']['lat'], item['geometry']['location']['lng']);

        this.nearbyPlaces.add(nearbyPlace);
      }

      // to update the nearby places
      setState(() {
        // this is to require the result to show
        this.hasSearchTerm = false;
      });
    } catch (e) {
      //
    }
  }

  /// This method gets the human readable name of the location. Mostly appears
  /// to be the road name and the locality.
  void reverseGeocodeLatLng(LatLng latLng) async {
    try {
      setState(() => _isLoadingSiteData = true);
      final response = await http.get("https://maps.googleapis.com/maps/api/geocode/json?" +
          "latlng=${latLng.latitude},${latLng.longitude}&" +
          "key=${widget.apiKey}&language=${widget.local}");

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson["status"] == "REQUEST_DENIED" || (responseJson["results"] as List).isEmpty) {
        print("## ERROR WITH API KEY ##");
        throw Error();
      }

      final result = responseJson['results'][0];

      setState(() {
        // final city = AddressComponent.fromJson(result['address_components'][3]).name.toLowerCase();
        // print(city);
        // if (city.contains("riyadh") || city.contains("رياض")) {
        //   _notSupportedCity = true;
        // } else {
        //   _notSupportedCity = false;
        // }
        _isLoadingSiteData = false;
        this.locationResult = LocationResult()
          ..name = result['address_components'][0]['short_name']
          ..locality = result['address_components'][1]['short_name']
          ..latLng = latLng
          ..formattedAddress = result['formatted_address']
          ..placeId = result['place_id']
          ..postalCode = result['address_components'][7]['short_name']
          ..country = AddressComponent.fromJson(result['address_components'][6])
          ..administrativeAreaLevel1 = AddressComponent.fromJson(result['address_components'][5])
          ..administrativeAreaLevel2 = AddressComponent.fromJson(result['address_components'][4])
          ..city = AddressComponent.fromJson(result['address_components'][3])
          ..subLocalityLevel1 = AddressComponent.fromJson(result['address_components'][2])
          ..subLocalityLevel2 = AddressComponent.fromJson(result['address_components'][1]);
      });
    } catch (e) {
      print(e);
    }
  }

  /// Moves the camera to the provided location and updates other UI features to
  /// match the location.
  void moveToLocation(LatLng latLng) {
    this.mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 15.0)),
      );
    });

    setMarker(latLng);

    try {
      reverseGeocodeLatLng(latLng);
    } catch (e) {
      print("ERROR ${e.toString()}");
    }

    // getNearbyPlaces(latLng);
  }

  void moveToCurrentUserLocation() {
    if (widget.displayLocation != null) {
      moveToLocation(widget.displayLocation);
      return;
    }

    Location().getLocation().then((locationData) {
      LatLng target = LatLng(locationData.latitude, locationData.longitude);
      moveToLocation(target);
    }).catchError((error) {
      // ignore: todo
      // TODO: Handle the exception here
      print(error);
    });
  }
}