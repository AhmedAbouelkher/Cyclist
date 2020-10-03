import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/repos/cart_contents_provider.dart';
import 'package:cyclist/repos/cart_repo.dart';
import 'package:cyclist/utils/alert_manager.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartScreen extends StatefulWidget {
  final Product product;
  AddToCartScreen({this.product});
  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  Product _product;
  int quantity = 1;
  CartRepo _cartRepo;

  @override
  void initState() {
    _cartRepo = CartRepo();
    _product = widget.product;
    _product = _product.copyWith(
      quantity: 1,
    );
    super.initState();
  }

  double getTotalPrice() {
    double singlePrice = double.parse(widget.product.salePrice);
    return singlePrice * quantity;
  }

  void _handleOnAddToCart({AppTranslations trs, BuildContext context}) async {
    print(_product.toString());
    // return;
    _cartRepo.addItemToTheCart(product: _product).then((value) async {
      alertWithSuccess(
        context: context,
        msg: trs.translate("added_to_cart"),
      );
      await Provider.of<CartItemsProvider>(context, listen: false).getCarCount();
      Navigator.pop(context);
    }).catchError((onError) {
      alertWithErr(
        context: context,
        msg: trs.translate("err"),
      );
    });
  }

  _setState(VoidCallback state) {
    if (mounted) setState(state);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    final isArabic = trs.currentLanguage == 'ar';
    return Scaffold(
      appBar: StanderedAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    FancyShimmerImage(
                      imageUrl: widget.product.imagePath,
                      width: size.width,
                      height: size.height * 0.295,
                      boxFit: BoxFit.fill,
                      shimmerBaseColor: Colors.grey[300],
                      shimmerHighlightColor: Colors.grey[100],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      width: size.width,
                      height: size.height * 0.15,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 4],
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ).createShader(
                            Rect.fromLTRB(0, -100, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.srcIn,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: StanderedAppBar(
                    appBarType: AppBarType.transparent,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.product.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.product.salePrice + " " + trs.translate('rs'),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 25,
              margin: EdgeInsets.symmetric(vertical: size.height * 0.007),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.07),
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          trs.translate("the_product"),
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: isArabic ? 20 : null,
                    right: isArabic ? null : 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        int.parse(widget.product.stock) < 10
                            ? Text(
                                "${trs.translate("left")} ${widget.product.stock} ${trs.translate("piece_b")}",
                                style: TextStyle(
                                  color: int.parse(widget.product.stock) < 10 ? Colors.red : Colors.black,
                                  fontSize: 12,
                                ),
                              )
                            : Container(),
                        Text(
                          double.parse(widget.product.weight) != 0 ? "${trs.translate("weight")} ${widget.product.weight}" : "",
                          style: TextStyle(
                            color: int.parse(widget.product.stock) < 10 ? Colors.red : Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 25,
              margin: EdgeInsets.only(bottom: size.height * 0.002),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                  horizontal: size.width * 0.07,
                ),
                width: size.width,
                height: size.height * 0.13,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trs.translate("quantity"),
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _setState(() => quantity++);
                            _product = _product.copyWith(
                              quantity: quantity,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: CColors.activeCatColor,
                            radius: 15,
                            child: Icon(Icons.add, size: 15, color: Colors.white),
                          ),
                        ),
                        Text(quantity.toString()),
                        InkWell(
                          onTap: () {
                            if (quantity == 1) return;
                            _setState(() => quantity--);
                            _product = _product.copyWith(
                              quantity: quantity,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: CColors.activeCatColor,
                            radius: 15,
                            child: Icon(
                              Icons.remove,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            widget.product.colors != null
                ? Card(
                    elevation: 25,
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.007),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.06,
                      ),
                      width: size.width,
                      height: size.height * 0.13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            trs.translate("colors"),
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          ColorPicker(
                            colors: widget.product.colors,
                            onChange: (String color) {
                              _product = _product.copyWith(
                                colors: [color],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            // _buildAdditions(size, trs),
            Spacer(),
            InkWell(
              onTap: () => _handleOnAddToCart(context: context, trs: trs),
              child: Container(
                width: size.width,
                height: size.height * 0.065,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.005,
                  horizontal: size.width * 0.06,
                ),
                decoration: BoxDecoration(
                  color: CColors.darkBlueColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.40,
                      child: Text(
                        trs.translate("add_cart"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Text(
                      "${trs.translate("total_b")}  ${getTotalPrice()} ${trs.translate("rs")}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}

typedef ColorPicking = void Function(String colors);

class ColorPicker extends StatefulWidget {
  final List<String> colors;
  final ColorPicking onChange;
  const ColorPicker({
    Key key,
    @required this.colors,
    @required this.onChange,
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.colors?.length ?? 0, (index) {
          final String color = "0xff" + widget.colors[index].substring(1);
          return GestureDetector(
            onTap: () {
              setState(() => _selectedColor = index);
              widget.onChange(widget.colors[index]);
            },
            child: Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Color(int.parse(color)),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _selectedColor == index ? Colors.black : Colors.transparent, width: 2),
              ),
            ),
          );
        }),
      ),
    );
  }
}
