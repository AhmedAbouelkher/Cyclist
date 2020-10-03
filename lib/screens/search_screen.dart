import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/repos/home_repo.dart';
import 'package:cyclist/screens/add_to_cart_screen.dart';
import 'package:cyclist/utils/alert_manager.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:cyclist/widgets/ltems/small_product_item.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SerachProductsResponse _productsResponse;
  TextEditingController _textEditingController;
  List<Product> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      if (_textEditingController?.text?.isEmpty ?? true) {
        _setState(() {
          _products?.clear();
        });
      }
    });
    super.initState();
  }

  _setState(VoidCallback state) {
    if (mounted) setState(state);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: StanderedAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                      ),
                      color: CColors.inActiveIcon,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Opacity(
                            opacity: 0.40,
                            child: Container(
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: CColors.darkBlue,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextField(
                                enabled: false,
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.05,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              controller: _textEditingController,
                              autocorrect: false,
                              autofocus: true,
                              textInputAction: TextInputAction.search,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: trs.translate('search'),
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (value) {
                                _handleSearch(trs);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: CColors.inActiveIcon,
                      ),
                      onPressed: () {
                        _handleSearch(trs);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildBody(trs, size),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSearch(AppTranslations trs) async {
    _setState(() {
      _isLoading = true;
    });
    try {
      final result = await HomeRepo()
          .searchInProducts(keyword: _textEditingController?.text ?? "", nexPageUrl: _productsResponse == null ? null : _productsResponse.products.nextPageUrl);
      _productsResponse = result;
      _setState(() {
        _products = result.products.data;
      });
    } catch (e) {
      alertWithErr(context: context, msg: trs.translate("rating_error"));
      print(e);
    } finally {
      _setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildBody(AppTranslations trs, Size size) {
    if (_isLoading) {
      return AdaptiveProgessIndicator(
        cupetinoRadius: 20,
      );
    }
    if (_products.isEmpty) {
      return Center(
        child: CenterErr(
          icon: Icons.search,
          msg: trs.translate('enter_search_key'),
        ),
      );
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          child: Text(
            trs.translate("search_results"),
            style: TextStyle(color: Colors.pink),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return SmallProductHorizontalItem(
                product: _products[index],
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
        // Expanded(
        //   child: GridView.builder(
        //     shrinkWrap: true,
        //     itemCount: _products.length,
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       childAspectRatio: (size.width / size.height) * 2.2,
        //     ),
        //     itemBuilder: (_, index) {
        //       if (index == _products.length - 1 && _productsResponse.products.nextPageUrl != null) {
        //         _handleSearch(trs);
        //       }
        //       return SmallProductItem(
        //         product: _products[index],
        //         onTap: (_) {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (_) => AddToCartScreen(product: _products[index]),
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
