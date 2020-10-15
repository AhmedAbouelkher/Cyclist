import 'dart:async';
import 'package:cyclist/Controllers/blocs/Rides/rides_bloc.dart';
import 'package:cyclist/Services/GoeLocation/geo_locator.dart';
import 'package:cyclist/Services/GoeLocation/models.dart';
import 'package:cyclist/models/Rides/rides_response.dart';
import 'package:cyclist/screens/maps/add_new_lafa.dart';
import 'package:cyclist/screens/maps/show_lafa.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cyclist/utils/extensions.dart';
import 'package:location/location.dart';

class HalaLafaTap extends StatefulWidget {
  HalaLafaTap({Key key}) : super(key: key);

  @override
  _HalaLafaTapState createState() => _HalaLafaTapState();
}

class _HalaLafaTapState extends State<HalaLafaTap> {
  Location _location;
  CLocation _currentLocation;
  ScrollController _scrollController;
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController()..addListener(_onScroll);
    _location = Location.instance;
    _location.getLocation().then((value) {
      setState(() => _currentLocation = value.toLocation());
      print(value.toString());
    });

    super.initState();
  }

  bool _block = false;
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 10) {
      if (_block) return;
      _block = true;
      print("#LOAD MORE DATA");
      BlocProvider.of<RidesBloc>(context).add(LoadRides(key: UniqueKey()));
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final trs = AppTranslations.of(context);

    if (_currentLocation == null) {
      return AdaptiveProgessIndicator();
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.mapMarkerAlt, color: CColors.darkGreenAccent),
              SizedBox(width: 10),
              Text(trs.translate("yala_lafa"), style: TextStyle(color: CColors.boldBlack, fontSize: 18 * .8)),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: FlatButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                platformPageRoute(
                  context: context,
                  builder: (context) => AddNewLafa(
                    currentUserLocation: _currentLocation,
                    onChange: () {
                      BlocProvider.of<RidesBloc>(context).add(LoadRides(key: UniqueKey(), status: "refresh"));
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.add),
            label: Text(
              trs.translate("add_new_lafa"),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<RidesBloc>(context).add(LoadRides(key: UniqueKey(), status: "swipe-refresh"));
              return _refreshCompleter.future;
            },
            child: BlocConsumer<RidesBloc, RidesState>(
              listener: (context, state) {
                if (state is LoadingRides || state is RidesInitial) {
                  _block = true;
                } else if (state is LoadingRidesFailed) {
                  _block = false;
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                } else if (state is LoadingRidesCompleted) {
                  _block = false;
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                }
              },
              builder: (context, state) {
                if (state is LoadingRides || state is RidesInitial) {
                  return AdaptiveProgessIndicator();
                } else if (state is LoadingRidesFailed) {
                  print(state.message);
                  return CenterError(
                    margin: EdgeInsets.only(top: 100),
                    mainAxisAlignment: MainAxisAlignment.start,
                    icon: FontAwesomeIcons.heartBroken,
                    message: trs.translate("rating_error"),
                    buttomText: trs.translate("refresh"),
                    onReload: () async {
                      BlocProvider.of<RidesBloc>(context).add(LoadRides(key: UniqueKey(), status: "refresh"));
                    },
                  );
                } else if (state is LoadingRidesCompleted) {
                  final List<Ride> rides = state.rides;
                  if (rides.isEmpty) {
                    return CenterError(
                      margin: EdgeInsets.only(top: 100),
                      mainAxisAlignment: MainAxisAlignment.start,
                      icon: FontAwesomeIcons.heartBroken,
                      message: trs.translate("no_rides"),
                      buttomText: trs.translate("add_new_lafa"),
                      onReload: () async {
                        Navigator.push(
                          context,
                          platformPageRoute(
                            context: context,
                            builder: (context) => AddNewLafa(
                              currentUserLocation: _currentLocation,
                              onChange: () {
                                BlocProvider.of<RidesBloc>(context).add(LoadRides(key: UniqueKey(), status: "refresh"));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return AnimationLimiter(
                    child: ListView.separated(
                      padding: EdgeInsets.only(bottom: size.height * 0.05),
                      itemCount: !state.hasNextPage ? rides.length : rides.length + 1,
                      controller: _scrollController,
                      separatorBuilder: (context, index) => Container(),
                      itemBuilder: (context, index) {
                        if (index >= rides.length)
                          return AdaptiveProgessIndicator();
                        else {
                          final ride = rides[index];
                          String _distance = "0.0 Km";
                          if (_currentLocation != null) {
                            _distance = LocationServices.calculateDistance(
                              oldLocation: _currentLocation,
                              newLocation: ride.startLocation.toLocation(),
                            ).getDistance;
                          }
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: -100.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: CColors.darkGreenAccent, width: 1.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CColors.darkGreenAccent.withAlpha(30),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        platformPageRoute(
                                          context: context,
                                          builder: (context) => ShowLafa(
                                            currentUserLocation: _currentLocation,
                                            ride: ride,
                                            onChange: () {},
                                          ),
                                        ),
                                      );
                                    },
                                    // leading: CircleAvatar(backgroundImage: AssetImage("assets/MapStyle/satellite_mode.png")),
                                    title: Text(
                                      trs.translate("lafa_number") + "\t#${ride.id}\t",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    subtitle: _buildLafaBody(trs, ride),
                                    trailing: _buildLafaTrialing(_distance),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
                return AdaptiveProgessIndicator();
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLafaTrialing(String _distance) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(_distance, textDirection: TextDirection.ltr, style: TextStyle(color: CColors.boldBlack, fontSize: 14 * .7)),
        SizedBox(width: 4),
        Icon(FontAwesomeIcons.locationArrow, color: CColors.darkGreen, size: 15 * .7)
      ],
    );
  }

  Widget _buildLafaBody(AppTranslations trs, Ride ride) {
    String _distance = LocationServices.calculateDistance(
      oldLocation: ride.startLocation.toLocation(),
      newLocation: ride.finishLocation.toLocation(),
    ).getDistance;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.clock,
              size: 14 * .8,
              color: CColors.darkGreenAccent,
            ),
            SizedBox(width: 10),
            Text(
              trs.translate("start_time") + ":\t",
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * 0.8,
              ),
            ),
            Text(
              ride.startAt,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * 0.8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.clock,
              size: 14 * .8,
              color: CColors.darkGreenAccent,
            ),
            SizedBox(width: 10),
            Text(
              trs.translate("end_time") + ":\t",
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * 0.8,
              ),
            ),
            Text(
              ride.endAt,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * 0.8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.calendarAlt,
              size: 14 * .8,
              color: CColors.darkGreenAccent,
            ),
            SizedBox(width: 10),
            Text(
              trs.translate("date_day") + ":\t",
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * 0.8,
              ),
            ),
            Text(
              ride.date.dayMonthYearNonUSFormate,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * 0.8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.biking,
              size: 14 * .8,
              color: CColors.darkGreenAccent,
            ),
            SizedBox(width: 10),
            Text(
              trs.translate("ride_distance") + ":\t",
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * .8,
              ),
            ),
            Text(
              _distance,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: CColors.boldBlackAccent,
                fontSize: 12 * .8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
