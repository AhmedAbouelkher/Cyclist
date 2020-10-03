import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// ignore: unused_import
import 'package:location/location.dart';
import 'package:cyclist/models/coupon_model.dart';
import 'package:cyclist/models/responses/home_response.dart';
import 'package:cyclist/repos/cart_repo.dart';
import 'package:cyclist/repos/home_repo.dart';
import 'package:cyclist/models/responses/search_in_products_response.dart' as getR;
import 'package:cyclist/repos/orders_repo.dart' as orderR;
import 'package:cyclist/screens/Order_details/final_checkout.dart';
import 'package:cyclist/models/responses/Checkout/order_post_request.dart' as orderR;
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/keys.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/PlacePicker/place_picker.dart';
import 'package:cyclist/widgets/dialogs/pick_copuon_dialog.dart';
import 'package:cyclist/widgets/order_details_header.dart';
import 'package:cyclist/widgets/payment_method.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:cyclist/widgets/buttons/custom_main_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class OrderCheckout extends StatefulWidget {
  @override
  _OrderCheckoutState createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends State<OrderCheckout> {
  Coupon _currentCopoun;
  HomeRepo _homeRepo;
  bool isloading = false;
  String _placeName;
  double lat;
  double lang;
  List<City> _cities;
  double _shippingFees;
  String _paymentMethod;
  List<getR.Product> _cartItems = [];
  double _totalPrice;
  double _totalWieght;
  City _neighborhood;
  City _city;

  @override
  void initState() {
    _homeRepo = HomeRepo();
    CartRepo().getCartItems().then((value) {
      if (_cartItems.length != value.length) {
        setState(() {
          _cartItems = value;
          checkCartCost();
          checkCartTotalWieght();
        });
      }
    });
    _homeRepo.getCities().then((value) {
      setState(() => _cities = value);
    }).catchError((e) => print(e));
    super.initState();
  }

  void checkCartCost() async {
    _totalPrice = 0;
    _cartItems.forEach((item) {
      _totalPrice += item.getTotalPrice;
    });
  }

  void checkCartTotalWieght() async {
    _totalWieght = 0;
    _cartItems.forEach((item) {
      _totalWieght += item.getTotalWieght;
      // _totalWieght += (item.quantity * double.parse(item.weight));
    });
  }

  double get totalCost {
    if (_shippingFees != null) {
      return _shippingFees + _totalPrice;
    }
    return null;
  }

  /*
    $weight = $cart->totalWeight;
      $price = 45;
      if($weight > 15){
          $price += ($weight - 15) * 3;
        }
    $total_price = $cart->totalPrice + $price;
  */

  double get shippingFeesIfNotSupportedCity {
    double price = 45.0;
    if (_totalWieght > 15) {
      price += (_totalWieght - 15) * 3;
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    // ignore: unused_local_variable
    final isArabic = trs.currentLanguage == 'ar';
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: AdaptiveProgessIndicator(),
      child: Scaffold(
        appBar: StanderedAppBar(),
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   print(await Location().hasPermission());
        // }),
        persistentFooterButtons: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: CustomMainButton(
              borderRaduis: 25,
              height: 45,
              width: size.width,
              textSize: 14,
              onTap: () => _handleCheckout(trs),
              text: trs.translate("continue"),
            ),
          ),
        ],
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(bottom: 30),
            children: <Widget>[
              StanderedAppBar(
                appBarType: AppBarType.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(trs.translate('order_details')),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.035, vertical: size.height * 0.01),
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
                          itemCount: _cartItems.length,
                          itemBuilder: (context, index) {
                            final item = _cartItems[index];
                            final itemName = trs.currentLanguage == 'ar' ? item.nameAr : item.nameEn;
                            return SizedBox(
                              width: size.width * 0.95,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(item.quantity.toString()),
                                  SizedBox(width: 20),
                                  Expanded(
                                      child: Text(
                                    itemName,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "${item.getTotalPrice.toString()} ${trs.translate("rs")}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () => _handleAddress(trs, context),
                        child: Column(
                          children: <Widget>[
                            Header(
                              title: trs.translate("addres"),
                              leading: trs.translate("edit"),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: size.width * 0.02,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      _placeName == null ? Icons.add : Icons.location_on,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _placeName ?? trs.translate("choose_address"),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: _placeName == null ? Colors.blue : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Header(title: trs.translate("payment_method")),
                      Container(
                        alignment: trs.currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          vertical: size.width * 0.02,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            PaymentOptionsRow(
                              onChoose: (paymentMethods) {
                                print(paymentMethods);
                                switch (paymentMethods) {
                                  case PaymentMethods.cash:
                                    _paymentMethod = "paiement_when_recieving";
                                    break;
                                  case PaymentMethods.payLink:
                                    _paymentMethod = "paylink";
                                    break;
                                }
                              },
                            ),
                            Visibility(
                              visible: _currentCopoun != null,
                              child: Text(_currentCopoun == null ? '' : _currentCopoun.value + "%"),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PickCouponDialog(onSubbmited: (Coupon copoun) {
                                      setState(() => _currentCopoun = copoun);
                                    });
                                  },
                                );
                              },
                              child: Text(
                                '+   ${trs.translate("add_the_discount_coupon")}',
                                style: TextStyle(color: CColors.activeCatColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                        ),
                        child: Divider(),
                      ),
                      Container(
                        alignment: trs.currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          vertical: size.width * 0.02,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              trs.translate("total_shipping_fees"),
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                _shippingFees != null ? "$_shippingFees ${trs.translate("rs")}" : trs.translate("not_determined"),
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: trs.currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          vertical: size.width * 0.01,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              trs.translate("cost"),
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "$_totalPrice ${trs.translate("rs")}",
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Header(
                        title: trs.translate("total"),
                        leading: totalCost != null ? "$totalCost ${trs.translate("rs")}" : trs.translate("not_determined"),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAddress(AppTranslations trs, BuildContext context) async {
    var _location = await Location().getLocation();
    print(_location.toString());

    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          Widget body = SafeArea(
            child: PlacePicker(
              Keys.googleApiKey,
              local: trs.locale.languageCode,
              trs: trs,
              displayLocation: LatLng(lat ?? (_location?.latitude ?? 24.774265), lang ?? (_location?.longitude ?? 46.738586)),
            ),
          );
          return Scaffold(
            appBar: StanderedAppBar(),
            body: body,
          );
        },
      ),
    );

    print(result?.formattedAddress);

    if (result == null) {
      print('null result');
    } else {
      // if (result.latLng.latitude == (_location?.latitude ?? 24.774265) &&
      //     result.latLng.longitude == (_location?.longitude ?? 46.738586)) return;

      lat = result?.latLng?.latitude;
      lang = result?.latLng?.longitude;
      _placeName = result?.formattedAddress;
      print(result.toString());
      final distrect = result.subLocalityLevel1.name.toLowerCase();
      String neighborhood;
      String city;
      if (distrect.contains("riyadh") || distrect.contains("رياض")) {
        neighborhood = result.subLocalityLevel2.name.toLowerCase();
        city = distrect;
      } else {
        neighborhood = distrect;
        city = result.administrativeAreaLevel2.name.toLowerCase();
      }
      try {
        _city = _cities.firstWhere((item) => item.name.toLowerCase() == city);
        _neighborhood = _city.neighborhoods.firstWhere((item) => item.name.toLowerCase() == neighborhood);
        print(_neighborhood.name);
        print(_neighborhood.price);
        setState(() => _shippingFees = double.parse(_neighborhood.price));
      } catch (e) {
        if (e.toString() == "Bad state: No element") {
          setState(() {
            _shippingFees = shippingFeesIfNotSupportedCity;
          });
        }
      }
    }
  }

  void _handleCheckout(AppTranslations trs) async {
    if (_shippingFees == null || _placeName == null) {
      await showPlatformDialog<void>(
        context: context,
        builder: (context) {
          return PlatformAlertDialog(
            title: Text(
              trs.translate("data_isn't_enough"),
              style: TextStyle(color: Colors.red),
            ),
            content: Text(trs.translate("enter_location_data")),
            actions: <Widget>[
              PlatformDialogAction(
                child: PlatformText(trs.translate("ok")),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        },
      );
      return;
    }
    final orderR.PostOrder _order = orderR.PostOrder(
      cityId: _city?.id,
      neighborhoodId: _neighborhood?.id,
      typePayment: _paymentMethod,
      sale: double?.parse(_currentCopoun?.value ?? "0.0"),
      totalWeight: _totalWieght,
      totalPrice: totalCost,
      address: _placeName,
      latitude: lat,
      longitude: lang,
      products: _cartItems
          .map((product) => orderR.Product(
                productId: product.id,
                color: product?.colors?.first,
                quantity: product.quantity,
              ))
          .toList(),
    );
    print(_order.toJson());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalCheckout(
          order: _order,
        ),
      ),
    );
  }
}
