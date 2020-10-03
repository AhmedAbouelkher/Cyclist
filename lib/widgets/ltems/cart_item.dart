import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:flutter/material.dart';
import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/repos/cart_repo.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/CustomNumberPicker.dart';

class CartItemWidget extends StatefulWidget {
  final void Function(num currentQty) onChanged;
  final VoidCallback onDelete;
  final Product product;
  final int index;
  CartItemWidget({this.product, this.onChanged, this.onDelete, this.index});
  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final _cartRepo = CartRepo();

  @override
  Widget build(BuildContext context) {
    // print("Quantity: ${widget.product.quantity}, ID: ##${widget.product.id}");
    AppTranslations trs = AppTranslations.of(context);
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.02,
      ),
      child: Container(
        height: size.height * 0.16,
        width: size.width,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.05,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FancyShimmerImage(
                    imageUrl: widget.product.imagePath,
                    width: size.width * 0.2 * 0.85,
                    height: size.height * 0.10 * 0.80,
                    boxFit: BoxFit.fill,
                    errorWidget: Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: size.width * 0.04,
                    left: size.width * 0.04,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ShowMoreText(
                        trs.locale.languageCode == 'ar' ? widget.product.nameAr : widget.product.nameEn,
                        maxLength: 25,
                        showMoreText: '',
                        style: TextStyle(
                          fontSize: 14,
                          color: CColors.activeCatColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            trs.translate("quntity"),
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 10),
                          NumperPciker(
                            initialValue: widget.product.quantity,
                            minimum: 1,
                            onMinus: () async {
                              // print("-");
                              // return;
                              final _currentQty = await _cartRepo.itemMinMin(productID: widget.product.id.toString());
                              widget.onChanged(_currentQty);
                            },
                            onPlus: () async {
                              // print("+");
                              // return;
                              final _currentQty = await _cartRepo.itemPlusPlus(productID: widget.product.id.toString());
                              widget.onChanged(_currentQty);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                trs.translate("price"),
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                widget.product.salePrice.toString() + ' ' + trs.translate("rs"),
                                style: TextStyle(color: CColors.activeCatColor, fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(width: size.width * 0.12),
                          Row(
                            children: <Widget>[
                              Text(
                                trs.translate("total_item_price"),
                                style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Text(
                                widget?.product?.getTotalPrice?.toString() ?? "" + ' ' + trs.translate("rs"),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 0,
              left: trs.currentLanguage == 'ar' ? 0 : null,
              right: trs.currentLanguage != 'ar' ? 0 : null,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: widget.onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
