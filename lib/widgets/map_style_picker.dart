import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseMapStyle extends StatefulWidget {
  final MapType mapType;
  final ValueChanged<MapType> onChanged;

  const ChooseMapStyle({
    Key key,
    @required this.mapType,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _ChooseMapStyleState createState() => _ChooseMapStyleState();
}

class _ChooseMapStyleState extends State<ChooseMapStyle> {
  MapType _mapType;

  @override
  void initState() {
    _mapType = widget.mapType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppTranslations trs = AppTranslations.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: _itemWidget(title: trs.translate("satelite"), pathImage: "satellite_mode", mapType: MapType.satellite)),
          SizedBox(width: 16),
          Expanded(child: _itemWidget(title: trs.translate("normal"), pathImage: "default_mode", mapType: MapType.normal)),
          SizedBox(width: 16),
          Expanded(child: _itemWidget(title: trs.translate("hyprid"), pathImage: "light_mode", mapType: MapType.hybrid)),
        ],
      ),
    );
  }

  Widget _itemWidget({String title, String pathImage, MapType mapType}) {
    return Column(
      children: <Widget>[
        Container(
          height: 98,
          width: 107,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() => _mapType = mapType);
                  if (widget.onChanged != null) widget.onChanged(_mapType);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _mapType == mapType ? CColors.darkGreenAccent : Colors.transparent,
                      width: 2,
                    ),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/MapStyle/$pathImage.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(shape: BoxShape.rectangle, color: Color(0xffFAF9F7), borderRadius: BorderRadius.circular(4)),
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.transparent,
                    ),
                    child: Checkbox(
                      activeColor: Colors.transparent,
                      checkColor: Color(0xff123159),
                      value: _mapType == mapType,
                      onChanged: (bool isChecked) {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 10,
              ),
            ))
      ],
    );
  }
}
