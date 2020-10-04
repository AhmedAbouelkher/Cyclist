// import 'package:cyclist/blocs/home_screen_bloc/home_screen_bloc.dart';
// import 'package:cyclist/models/responses/user_orders_response.dart';
// import 'package:cyclist/repos/auth_repo.dart';
// import 'package:cyclist/repos/orders_repo.dart';
// import 'package:cyclist/screens/Order_details/order_details_stepper.dart';
// import 'package:cyclist/screens/auth/signin_screen.dart';
// import 'package:cyclist/utils/colors.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:cyclist/widgets/buttons/custom_main_button.dart';
// import 'package:cyclist/widgets/ltems/order_item.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:cyclist/widgets/center_err.dart';
// import 'package:cyclist/widgets/center_loading.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//! DISABLED
// class MyOrdersTab extends StatefulWidget {
//   @override
//   _MyOrdersTabState createState() => _MyOrdersTabState();
// }

// class _MyOrdersTabState extends State<MyOrdersTab> {
//   UserOrdersResponse _currentOldResponse;
//   UserOrdersResponse _currentNewResponse;
//   List<Order> _oldOrders;
//   List<Order> _newOrders;
//   String errMsg;
//   bool isLoggedIn;
//   OrdersRepo _ordersRepo;

//   @override
//   void initState() {
//     _ordersRepo = OrdersRepo();
//     AuthRepo().isLoggedIn().then((val) {
//       setState(() {
//         isLoggedIn = val;
//       });
//     });

//     feedMeMoreOrdersNEW();
//     feedMeMoreOrdersOLD();

//     super.initState();
//   }

//   void feedMeMoreOrdersOLD() async {
//     _ordersRepo
//         .getUserOrders(
//       nexPageUrl: _currentOldResponse == null ? null : _currentOldResponse.nextPageUrl,
//       onlyOld: true,
//     )
//         .then((response) {
//       _currentOldResponse = response;
//       _oldOrders = [];
//       _setState(() => _oldOrders.addAll(response.orders));
//     }).catchError((err) {
//       _setState(() => errMsg = err.toString());
//       print(err);
//     });
//   }

//   void feedMeMoreOrdersNEW() async {
//     _ordersRepo.getUserOrders(nexPageUrl: _currentNewResponse == null ? null : _currentNewResponse.nextPageUrl).then((response) {
//       _currentNewResponse = response;
//       _newOrders = [];
//       _setState(() => _newOrders.addAll(response.orders));
//     }).catchError((err) {
//       _setState(() {
//         errMsg = err.toString();
//       });
//       print(err);
//     });
//   }

//   _setState(VoidCallback state) {
//     if (mounted) setState(state);
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppTranslations trs = AppTranslations.of(context);
//     final Size size = MediaQuery.of(context).size;
//     if (isLoggedIn == null) return SizedBox(width: 1);
//     if (!isLoggedIn)
//       return SingInScreen(
//         whereBefore: MyOrdersTab(),
//       );
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
//                 trs.translate('orders'),
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

//     if (_newOrders == null || _oldOrders == null) return CenterLoading();

//     return SafeArea(
//       child: Column(
//         children: <Widget>[
//           StanderedAppBar(
//             appBarType: AppBarType.transparent,
//             centerChild: Text(
//               trs.translate('orders'),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 15,
//               ),
//             ),
//             trailing: IconButton(
//               padding: const EdgeInsets.only(left: 8, right: 8),
//               icon: Icon(
//                 Icons.menu,
//                 color: Colors.white,
//                 size: size.aspectRatio * 60,
//               ),
//               onPressed: () {
//                 BlocProvider.of<HomeScreenBloc>(context).add(OpenDrawer());
//               },
//             ),
//           ),
//           OrdersBody(
//             oldOrders: _oldOrders,
//             newOrders: _newOrders,
//             response: [_currentNewResponse, _currentOldResponse],
//             onEdgeReach: (orderType) {
//               switch (orderType) {
//                 case OrderType.old:
//                   feedMeMoreOrdersOLD();
//                   break;
//                 default:
//                   feedMeMoreOrdersNEW();
//                   break;
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// enum OrderType { current, old }

// class OrdersBody extends StatefulWidget {
//   final List<Order> oldOrders;
//   final List<Order> newOrders;
//   final void Function(OrderType) onEdgeReach;
//   final List<UserOrdersResponse> response;
//   const OrdersBody({
//     Key key,
//     this.oldOrders,
//     this.newOrders,
//     this.onEdgeReach,
//     this.response,
//   }) : super(key: key);

//   @override
//   _OrdersBodyState createState() => _OrdersBodyState();
// }

// class _OrdersBodyState extends State<OrdersBody> {
//   int _currentIndex = 0;
//   bool oldIsEmpty;
//   bool newIsEmpty;
//   @override
//   void initState() {
//     oldIsEmpty = widget.oldOrders.length == 0;
//     newIsEmpty = widget.newOrders.length == 0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final AppTranslations trs = AppTranslations.of(context);

//     return Expanded(
//       child: Column(
//         children: <Widget>[
//           OrdersToggle(
//             onTapChange: (index) {
//               setState(() => _currentIndex = index);
//               print(index);
//             },
//           ),
//           Expanded(
//             child: Visibility(
//               visible: _currentIndex == 0,
//               replacement: _buildOrdersList(
//                 widget.newOrders,
//                 OrderType.current,
//                 newIsEmpty,
//                 trs: trs,
//               ),
//               child: _buildOrdersList(
//                 widget.oldOrders,
//                 OrderType.old,
//                 oldIsEmpty,
//                 trs: trs,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrdersList(
//     List<Order> list,
//     OrderType orderType,
//     bool isEmpty, {
//     AppTranslations trs,
//   }) {
//     if (isEmpty) {
//       return CenterErr(
//         icon: FontAwesomeIcons.heartBroken,
//         msg: trs.translate("empty_order_return"),
//       );
//     }
//     return ListView.builder(
//       itemCount: list.length,
//       itemBuilder: (context, index) {
//         final size = MediaQuery.of(context).size;
//         if (index == list.length && widget.response[_currentIndex].nextPageUrl != null) {
//           if (widget.onEdgeReach != null) widget.onEdgeReach(orderType);
//         }
//         // if (list[index].products.first.imagePath == null) return Container();
//         if (list[index].products.isEmpty) {
//           return Container(
//             height: size.height * 0.2,
//             width: size.width,
//             margin: EdgeInsets.symmetric(
//               horizontal: 10,
//               vertical: 8,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 0),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 "Error\nPlease insure entering all mock data deatials\nOrder ID #${list[index].id}",
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           );
//         }
//         return OrderItem(
//           order: list[index],
//           onClick: () {
//             print("widget.order.statusIndex: ${list[index].statusIndex}");
//             print("widget.order.status: ${list[index].status}");
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => OrderProgressDetails(
//                   order: list[index],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class OrdersToggle extends StatefulWidget {
//   final void Function(int tapIndex) onTapChange;
//   final int index;
//   const OrdersToggle({Key key, this.onTapChange, this.index}) : super(key: key);
//   @override
//   _OrdersToggleState createState() => _OrdersToggleState();
// }

// class _OrdersToggleState extends State<OrdersToggle> {
//   int _currentTabIndex = 0;
//   List<String> labels;

//   @override
//   void initState() {
//     if (widget.index != null) _currentTabIndex = widget.index;
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(OrdersToggle oldWidget) {
//     if (widget.index != oldWidget.index) _currentTabIndex = widget.index;
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppTranslations trs = AppTranslations.of(context);
//     labels = [
//       trs.translate("old_orders"),
//       trs.translate("new_orders"),
//     ];
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.only(
//         top: size.height * 0.03,
//         bottom: size.height * 0.02,
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: List.generate(2, (index) {
//             final bool _isSelected = index == _currentTabIndex;
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: CustomMainButton(
//                 text: labels[index],
//                 borderRaduis: 25,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.width * 0.07,
//                   vertical: 5,
//                 ),
//                 bgColor: _isSelected ? CColors.darkBlue : CColors.darkBlue.withAlpha(100),
//                 onTap: () {
//                   if (_currentTabIndex == index) return;
//                   setState(() => _currentTabIndex = index);
//                   if (widget.onTapChange != null) widget.onTapChange(_currentTabIndex);
//                 },
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
