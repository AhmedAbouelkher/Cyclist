import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';

class SmallProductItem extends StatelessWidget {
  final Product product;
  final Function(Product) onTap;
  final Function onFavStatusChanged;
  SmallProductItem({this.product, this.onTap, this.onFavStatusChanged});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);

    return InkWell(
      onTap: () => onTap(product),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        elevation: 3,
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.02,
        ),
        child: Container(
          width: size.width * 0.30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: FancyShimmerImage(
                  imageUrl: product.imagePath,
                  width: size.width * 0.3,
                  height: size.height * 0.11,
                  boxFit: BoxFit.cover,
                  shimmerBaseColor: Colors.grey[300],
                  shimmerHighlightColor: Colors.grey[100],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.007,
                    horizontal: size.width * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ShowMoreText(
                          product.name,
                          maxLength: 25,
                          showMoreText: '',
                          style: TextStyle(
                            fontSize: 10,
                            // color: CColors.activeCatColor,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            product.salePrice + " " + trs.translate('rs'),
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          Icon(
                            Icons.account_balance_wallet,
                            size: 15,
                            color: Colors.green,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SmallProductHorizontalItem extends StatelessWidget {
  final Product product;
  final Function(Product) onTap;
  final Function onFavStatusChanged;
  SmallProductHorizontalItem({this.product, this.onTap, this.onFavStatusChanged});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);

    return InkWell(
      onTap: () => onTap(product),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.01,
        ),
        child: Container(
          width: size.width * 0.30,
          height: size.height * 0.13,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                child: FancyShimmerImage(
                  imageUrl: product.imagePath,
                  width: size.width * 0.3,
                  height: size.height * 0.05,
                  boxFit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  shimmerBaseColor: Colors.grey[300],
                  shimmerHighlightColor: Colors.grey[100],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.007,
                    horizontal: size.width * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 12,
                            // color: CColors.activeCatColor,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Spacer(),
                          Text(
                            product.salePrice + " " + trs.translate('rs'),
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.account_balance_wallet,
                            size: 18,
                            color: Colors.green,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
