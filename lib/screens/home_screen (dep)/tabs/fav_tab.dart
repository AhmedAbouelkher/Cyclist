// import 'package:cyclist/blocs/home_screen_bloc/home_screen_bloc.dart';
// import 'package:cyclist/models/responses/show_cat_products.dart';
// import 'package:cyclist/repos/home_repo.dart';
// import 'package:cyclist/screens/add_to_cart_screen.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:cyclist/widgets/center_err.dart';
// import 'package:cyclist/widgets/center_loading.dart';
// import 'package:cyclist/widgets/ltems/small_product_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//! DISABLED
// class FavTab extends StatefulWidget {
//   @override
//   _FavTabState createState() => _FavTabState();
// }

// class _FavTabState extends State<FavTab> {
//   List<Product> _products;
//   String errMsg;
//   // bool isLoggedIn;

//   _removeItemById(int id) async {
//     print(id);
//     _setState(() {
//       _products.removeWhere((element) => element.id == id);
//       print(_products.length);
//     });
//   }

//   @override
//   void initState() {
//     // AuthRepo().isLoggedIn().then((val) {
//     //   _setState(() {
//     //     isLoggedIn = val;
//     //   });
//     // });

//     HomeRepo().getAllFav().then((response) {
//       _products = [];
//       _setState(() {
//         _products.addAll(response.favorites);
//       });
//     }).catchError((err) {
//       _setState(() {
//         errMsg = err.toString();
//       });
//     });
//     super.initState();
//   }

//   _setState(VoidCallback state) {
//     if (mounted) setState(state);
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppTranslations trs = AppTranslations.of(context);
//     Size size = MediaQuery.of(context).size;
//     // if (isLoggedIn == null) return SizedBox(width: 1);
//     // if (!isLoggedIn)
//     //   return SingInScreen(
//     //     whereBefore: FavTab(),
//     //   );
//     if (errMsg != null) {
//       IconData iconData;
//       if (errMsg == 'لا يوجد اتصال بالانترنت' || errMsg == 'no internet connection') {
//         iconData = Icons.signal_wifi_off;
//       } else {
//         iconData = FontAwesomeIcons.heartBroken;
//       }
//       return SafeArea(
//         child: Column(
//           children: <Widget>[
//             StanderedAppBar(
//               appBarType: AppBarType.transparent,
//               centerChild: Text(
//                 trs.translate('fav'),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 19,
//                 ),
//               ),
//               trailing: IconButton(
//                 padding: const EdgeInsets.only(left: 8, right: 8),
//                 icon: Icon(
//                   Icons.menu,
//                   color: Colors.white,
//                   size: 33,
//                 ),
//                 onPressed: () {
//                   BlocProvider.of<HomeScreenBloc>(context).add(OpenDrawer());
//                 },
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: CenterErr(
//                   icon: iconData,
//                   msg: errMsg,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     if (_products == null) return CenterLoading();
//     if (_products.length == 0) {
//       return Scaffold(
//         appBar: StanderedAppBar(),
//         body: SafeArea(
//           child: Column(
//             children: <Widget>[
//               StanderedAppBar(
//                 appBarType: AppBarType.transparent,
//                 centerChild: Text(
//                   trs.translate('fav'),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                   ),
//                 ),
//                 trailing: IconButton(
//                   padding: const EdgeInsets.only(left: 8, right: 8),
//                   icon: Icon(
//                     Icons.menu,
//                     color: Colors.white,
//                     size: size.aspectRatio * 60,
//                   ),
//                   onPressed: () {
//                     BlocProvider.of<HomeScreenBloc>(context).add(OpenDrawer());
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: CenterErr(
//                     icon: FontAwesomeIcons.cartPlus,
//                     msg: trs.translate('you_have_nothing'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return SafeArea(
//       child: Column(
//         children: <Widget>[
//           StanderedAppBar(
//             appBarType: AppBarType.transparent,
//             centerChild: Text(
//               trs.translate('fav'),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 19,
//               ),
//             ),
//             trailing: IconButton(
//               padding: const EdgeInsets.only(left: 8, right: 8),
//               icon: Icon(
//                 Icons.menu,
//                 color: Colors.white,
//                 size: size.aspectRatio * 55,
//               ),
//               onPressed: () {
//                 BlocProvider.of<HomeScreenBloc>(context).add(OpenDrawer());
//               },
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               shrinkWrap: true,
//               itemCount: _products.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: (size.width / size.height) * 2.2,
//               ),
//               itemBuilder: (_, index) {
//                 return SmallProductItem(
//                   product: _products[index],
//                   onTap: (_) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => AddToCartScreen(product: _products[index]),
//                       ),
//                     );
//                   },
//                   onFavStatusChanged: (int index) {
//                     _removeItemById(index);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
