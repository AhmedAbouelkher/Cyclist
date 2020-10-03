import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/repos/cart_contents_provider.dart';
import 'package:cyclist/repos/cart_repo.dart';
import 'package:cyclist/screens/Order_details/order_details_checkout.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:cyclist/widgets/buttons/custom_main_button.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:cyclist/widgets/ltems/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final _cartRepo = CartRepo();
  List<Product> _cartItems = [];
  int quantity = 0;
  double price = 0;

  void checkCartCoast() async {
    price = 0;
    quantity = 0;
    _cartItems.forEach((product) {
      price += product.getTotalPrice;
      quantity += product.quantity;
    });
  }

  _setState(VoidCallback state) {
    if (mounted) setState(state);
  }

  @override
  void didChangeDependencies() {
    Provider.of<CartItemsProvider>(context, listen: false).getCarCount();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppTranslations trs = AppTranslations.of(context);
    final Size size = MediaQuery.of(context).size;

    _cartRepo.getCartItems().then((value) {
      if (_cartItems.length != value.length) {
        _setState(() {
          _cartItems = value;
          checkCartCoast();
        });
      }
    });

    if (_cartItems == null) {
      return Scaffold(
        appBar: StanderedAppBar(),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: StanderedAppBar(
                  appBarType: AppBarType.transparent,
                  leading: Container(),
                ),
              ),
              Positioned(
                top: (size.height * 0.05) + 10,
                left: 0,
                right: 20,
                child: Text(trs.translate('cart')),
              ),
              Positioned(
                top: (size.height * 0.05) + (10 + 30),
                left: 0,
                right: 0,
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.2,
                ),
              ),
              AdaptiveProgessIndicator(),
            ],
          ),
        ),
      );
    }

    if (_cartItems.length == 0) {
      return Scaffold(
        appBar: StanderedAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              StanderedAppBar(
                appBarType: AppBarType.transparent,
                centerChild: Text(
                  trs.translate('cart'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
                leading: Container(),
                trailing: Container(),
              ),
              Expanded(
                child: Center(
                  child: CenterErr(
                    icon: FontAwesomeIcons.cartPlus,
                    msg: trs.translate('empty_cart'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: StanderedAppBar(),
      persistentFooterButtons: <Widget>[
        Container(
          height: size.height * 0.10,
          width: size.width,
          decoration: BoxDecoration(),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        trs.translate("total"),
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        price.toString() + " " + trs.translate("rs"),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: 5),
                  child: CustomMainButton(
                    borderRaduis: 20,
                    height: 80 * size.aspectRatio,
                    textSize: 14,
                    padding: const EdgeInsets.symmetric(horizontal: 20 * 0.8),
                    text: trs.translate("submit_order"),
                    onTap: () async {
                      // CartRepo().clearCart();
                      // setState(() {});
                      // return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderCheckout(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StanderedAppBar(
              appBarType: AppBarType.transparent,
              centerChild: Text(
                trs.translate('cart'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              leading: Container(),
              trailing: Container(),
            ),
            Expanded(
              child: Container(
                width: size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cartItems.length,
                  itemBuilder: (_, int index) {
                    return CartItemWidget(
                      product: _cartItems[index],
                      onDelete: () async {
                        _cartItems = await _cartRepo.deleteItemFromTheCart(itemToDelete: _cartItems[index]);
                        _setState(() {});
                        Provider.of<CartItemsProvider>(context, listen: false).getCarCount();
                      },
                      onChanged: (qty) async {
                        print("CHANGED $qty");
                        _cartRepo.getCartItems().then((value) {
                          _setState(() {
                            _cartItems = value;
                            checkCartCoast();
                          });
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
