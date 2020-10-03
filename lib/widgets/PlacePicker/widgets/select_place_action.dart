import 'package:flutter/material.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';

class SelectPlaceAction extends StatelessWidget {
  final String locationName;
  final VoidCallback onTap;
  final AppTranslations trs;
  final bool isCitySupported;
  final bool isLoading;

  SelectPlaceAction(this.locationName, this.onTap, this.trs, {this.isCitySupported, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: isCitySupported ? (isLoading ? null : onTap) : null,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: isLoading
                    ? SizedBox(
                        height: 60,
                        child: AdaptiveProgessIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: isCitySupported
                            ? <Widget>[
                                Text(locationName, style: TextStyle(fontSize: 16)),
                                Text(trs.translate("pick_location_b"), style: TextStyle(color: Colors.grey, fontSize: 15)),
                              ]
                            : [
                                Text(trs.translate("not_supported"), style: TextStyle(color: Colors.grey, fontSize: 15)),
                                Text(trs.translate("choose_another_location"), style: TextStyle(fontSize: 16, color: Colors.red)),
                              ],
                      ),
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
