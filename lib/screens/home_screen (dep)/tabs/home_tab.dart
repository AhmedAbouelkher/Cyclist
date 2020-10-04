import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyclist/models/responses/cats_response.dart';
import 'package:cyclist/models/responses/home_response.dart';
import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/repos/cart_contents_provider.dart';
import 'package:cyclist/repos/home_repo.dart';
import 'package:cyclist/screens/add_to_cart_screen.dart';
import 'package:cyclist/screens/cat_products.dart';
import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:cyclist/widgets/center_err.dart';
import 'package:cyclist/widgets/category_item.dart';
import 'package:cyclist/widgets/home_app_bar.dart';
import 'package:cyclist/widgets/ltems/small_product_item.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeResponse homeResponse;
  CatsResponse cats;
  SerachProductsResponse allProducts;
  String err;
  HomeRepo repo = HomeRepo();
  Widget slider;
  AppTranslations trs;
  @override
  void initState() {
    slider = AdaptiveProgessIndicator();

    repo.getSlides().then((value) {
      _setState(() => homeResponse = value);
    }).catchError((err) {
      _setState(() => err = err.toString());
    });
    repo.searchInProducts(keyword: "").then((value) {
      _setState(() => allProducts = value);
    }).catchError((err) {
      _setState(() => err = err.toString());
    });

    repo.getCategories().then((value) {
      _setState(() {
        cats = value;
        cats.categories = [
          Category(
            name: trs.translate('all'),
          ),
          ...cats.categories
        ];
      });
    }).catchError((err) {
      _setState(() => err = err.toString());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<CartItemsProvider>(context, listen: false).getCarCount();
    super.didChangeDependencies();
  }

  _setState(VoidCallback state) {
    if (mounted) setState(state);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    trs = AppTranslations.of(context);
    // print("Aspect Ratio: ${size.aspectRatio.toStringAsFixed(3)}");
    // print("Hieght: ${size.height}");
    // print("width: ${size.width}");
    //big 0.462
    //small 0.562
    // final bool isSmallScreen = size.aspectRatio > 0.462;
    if (err != null) {
      return CenterErr(msg: err, icon: Icons.wifi_lock);
    }
    if (homeResponse == null || cats == null || allProducts == null) {
      return AdaptiveProgessIndicator();
    }

    Widget slider = HomeSlider(homeResponse: homeResponse, size: size);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.3,
                      width: size.width,
                      child: slider,
                    ),
                    Positioned(
                      top: size.height * 0.005,
                      child: HomeAppBar(),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  height: size.height * 0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: cats.categories.length,
                    itemBuilder: (_, index) {
                      final cat = cats.categories[index];
                      return CategoryCircle(
                        isSlected: index == 0,
                        cat: cat,
                        onClick: () {
                          if (index == 0) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CatProducts(
                                category: cat,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: size.width * 0.05,
                  ),
                  child: Text(
                    trs.translate("our_product"),
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: size.width / size.height * 1.28,
                  ),
                  itemCount: allProducts.products.data.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return SmallProductItem(
                      product: allProducts.products.data[index],
                      onTap: (Product product) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddToCartScreen(product: product),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeSlider extends StatefulWidget {
  const HomeSlider({
    Key key,
    @required this.homeResponse,
    @required this.size,
  }) : super(key: key);

  final HomeResponse homeResponse;
  final Size size;

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _current = 0;

  _setState(VoidCallback state) {
    if (mounted) setState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider.builder(
          options: CarouselOptions(
            height: widget.size.height * 0.35,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _setState(() => _current = index);
            },
          ),
          itemCount: widget.homeResponse.sliders.length,
          itemBuilder: (_, index) {
            final slide = widget.homeResponse.sliders[index];
            return FancyShimmerImage(
              imageUrl: slide.imagePath,
              width: widget.size.width,
              shimmerBaseColor: Colors.grey[300],
              shimmerHighlightColor: Colors.grey[100],
              boxFit: BoxFit.fill,
            );
          },
        ),
        Align(
          alignment: Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.homeResponse.sliders.map((slide) {
              int index = widget.homeResponse.sliders.indexOf(slide);
              bool isSelected = _current == index;
              return Container(
                width: isSelected ? 8.5 : 6.0,
                height: isSelected ? 8.5 : 6.0,
                // height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
