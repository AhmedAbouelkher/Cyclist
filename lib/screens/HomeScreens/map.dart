import 'package:cyclist/GoeLocation/models.dart';
import 'package:cyclist/screens/add_new_lafa.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:cyclist/GoeLocation/geo_locator.dart';

class HalaLafaTap extends StatefulWidget {
  HalaLafaTap({Key key}) : super(key: key);

  @override
  _HalaLafaTapState createState() => _HalaLafaTapState();
}

class _HalaLafaTapState extends State<HalaLafaTap> {
  Location _location;
  CLocation _currentLocation;
  @override
  void initState() {
    _location = Location();
    _location.getLocation().then((value) {
      setState(() => _currentLocation = value.toLocation());
      print(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final trs = AppTranslations.of(context);
    if (_currentLocation == null) {
      return AdaptiveProgessIndicator();
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.mapMarkerAlt, color: CColors.darkGreenAccent),
              SizedBox(width: 10),
              Text(trs.translate("yala_lafa"), style: TextStyle(color: CColors.boldBlack, fontSize: 18)),
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
                    ),
                  ));
            },
            icon: Icon(Icons.add),
            label: Text(
              trs.translate("add_new_lafa"),
              style: TextStyle(
                  // fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
