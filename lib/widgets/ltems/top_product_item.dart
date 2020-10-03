import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/screens/add_to_cart_screen.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';

class TopProductItem extends StatelessWidget {
  final Product product;
  TopProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddToCartScreen(
              product: product,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(right: size.width * 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Container(
          width: size.width * 0.45,
          // height: size.height * 0.30,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: FancyShimmerImage(
                  imageUrl: product.imagePath,
                  height: size.height * 0.25,
                  width: size.width * 0.45,
                  boxFit: BoxFit.cover,
                  shimmerBaseColor: Colors.grey[300],
                  shimmerHighlightColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ShowMoreText(
                          product.name,
                          maxLength: 15,
                          showMoreText: '',
                          style: TextStyle(
                            fontSize: 14,
                            color: CColors.activeCatColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ShowMoreText(
                          product.description,
                          maxLength: 50,
                          showMoreText: '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        // AutoSizeText(
                        //   product.description * 3,
                        //   maxFontSize: 12,
                        //   minFontSize: 12,
                        //   style: TextStyle(fontSize: 12, color: Colors.grey),
                        //   maxLines: 3,
                        //   softWrap: true,
                        //   overflow: TextOverflow.fade,
                        //   textAlign: TextAlign.right,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.grey,
                      endIndent: size.width * 0.40 * 0.1,
                      indent: size.width * 0.40 * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          product.salePrice + " " + trs.translate('rs'),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.account_balance_wallet,
                          color: Colors.green,
                          size: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
