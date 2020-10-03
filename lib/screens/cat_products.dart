import 'package:cyclist/models/responses/cats_response.dart';
import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/models/responses/show_cat_products.dart';
import 'package:cyclist/repos/home_repo.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:cyclist/widgets/center_loading.dart';
import 'package:cyclist/widgets/ltems/small_product_item.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add_to_cart_screen.dart';

class CatProducts extends StatefulWidget {
  final Category category;
  CatProducts({
    this.category,
  });

  @override
  _CatProductsState createState() => _CatProductsState();
}

class _CatProductsState extends State<CatProducts> {
  String errMsg;
  ShowCatProducts _response;
  // ignore: unused_field
  List<Product> _products;
  bool _isLoading = true;
  HomeRepo _repo;
  @override
  void initState() {
    _products = [];
    _repo = HomeRepo();
    _repo.showCatProducts(catId: widget.category.id).then((value) {
      setState(() {
        _isLoading = false;
        _response = value;
        _products = _response.products.data;
      });
    }).catchError((onError) {
      print(errMsg);
      setState(() {
        _isLoading = false;
        errMsg = onError;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);

    if (_isLoading) return _buildDummyScaffold(body: CenterLoading());

    if (errMsg != null || _response == null)
      _buildDummyScaffold(
        body: CenterErr(
          icon: FontAwesomeIcons.wifi,
          msg: errMsg,
        ),
      );

    if (_response.products.data.length == 0)
      return _buildDummyScaffold(
        body: CenterErr(
          icon: FontAwesomeIcons.cartPlus,
          msg: trs.translate('no_products'),
        ),
      );

    return Scaffold(
      appBar: StanderedAppBar(),
      body: Column(
        children: <Widget>[
          StanderedAppBar(
            appBarType: AppBarType.transparent,
            centerChild: Text(
              widget.category.name,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _response.products.data.length,
              itemBuilder: (context, index) {
                return SmallProductHorizontalItem(
                  product: _response.products.data[index],
                  onTap: (Product product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddToCartScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _buildDummyScaffold({Widget body}) {
    Scaffold _scaffold = Scaffold(
      appBar: StanderedAppBar(),
      body: Column(
        children: <Widget>[
          StanderedAppBar(
            appBarType: AppBarType.transparent,
            centerChild: Text(
              widget.category.name,
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
    return _scaffold;
  }
}
