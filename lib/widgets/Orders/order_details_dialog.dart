import 'package:cyclist/models/responses/user_orders_response.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/buttons/custom_main_button.dart';
import 'package:cyclist/widgets/order_details_header.dart';
import 'package:flutter/material.dart';

class OrderDetailsDialog extends StatelessWidget {
  final Order order;
  const OrderDetailsDialog({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTranslations trs = AppTranslations.of(context);
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.035,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(trs.translate('order_details')),
                  Text(
                    "#" + order.id.toString(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.035,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Header(
                      title: trs.translate("the_demand"),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: order.products.length,
                        itemBuilder: (context, index) {
                          final item = order.products[index];
                          final itemName = trs.currentLanguage == 'ar' ? item.nameAr : item.nameEn;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(itemName),
                            ],
                          );
                        },
                      ),
                    ),
                    Header(title: trs.translate("addres")),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Text(
                              order.address,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Header(
                      title: trs.translate("total"),
                      leading: order.totalPrice + " ${trs.translate('rs')}",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: size.width * 0.20,
                      ),
                      child: CustomMainButton(
                        borderRaduis: 25,
                        height: 35,
                        textSize: 14,
                        onTap: () => Navigator.pop(context),
                        text: trs.translate("close"),
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
}
