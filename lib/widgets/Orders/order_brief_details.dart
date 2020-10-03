import 'package:cyclist/models/responses/user_orders_response.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/order_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';

class OrderBriefDetails extends StatelessWidget {
  final Order order;

  const OrderBriefDetails({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppTranslations trs = AppTranslations.of(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 4,
        child: Column(
          children: <Widget>[
            Header(
              title: trs.translate("order_details"),
              margin: const EdgeInsets.all(0),
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: size.width * 0.03,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.09,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        order.products.first.name + " ...",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(order.products.length.toString()),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  endIndent: 30,
                  indent: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: size.width * 0.03,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: ShowMoreText(
                          order.address,
                          maxLength: 80,
                          style: TextStyle(fontSize: 12),
                          showMoreText: '',
                          showMoreStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
