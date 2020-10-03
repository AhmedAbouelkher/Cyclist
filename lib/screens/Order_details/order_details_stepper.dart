// import 'package:cyclist/models/responses/user_orders_response.dart';
// import 'package:cyclist/utils/images.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:cyclist/widgets/Orders/order_widgets.dart';
// import 'package:cyclist/widgets/order_ratting_dialog.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

//! DESIABELED

// class OrderProgressDetails extends StatefulWidget {
//   final Order order;
//   OrderProgressDetails({Key key, this.order}) : super(key: key);

//   @override
//   _OrderProgressDetailsState createState() => _OrderProgressDetailsState();
// }

// class _OrderProgressDetailsState extends State<OrderProgressDetails> {
//   // final List<String> _imagePathsInStepperOrder = [
//   //   "assets/step_one.png",
//   //   "assets/step_tow.png",
//   //   "assets/step_three.png",
//   //   "assets/step_three.png"
//   // ];
//   final List<String> _imagePathsInStepperOrderSVGs = [
//     orderStageIllustation1SVG,
//     orderStageIllustation2SVG,
//     orderStageIllustation3SVG,
//     orderStageIllustation3SVG,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     AppTranslations trs = AppTranslations.of(context);
//     Size size = MediaQuery.of(context).size;
//     // final _statusTitle = [
//     //   trs.translate("processing_order"),
//     //   trs.translate("order_accepted"),
//     //   trs.translate("be_ready_to_recive_your_order"),
//     // ];
//     return Scaffold(
//       appBar: StanderedAppBar(),
//       body: SafeArea(
//         child: SizedBox.fromSize(
//           size: size,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 StanderedAppBar(
//                   appBarType: AppBarType.transparent,
//                   centerChild: Text(
//                     trs.translate("order_details"),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Text(
//                     trs.translate("thanks_for_useing"),
//                     style: TextStyle(
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   endIndent: 25,
//                   indent: 25,
//                 ),
//                 SizedBox(
//                   width: size.width * 0.9,
//                   height: size.height * 0.30,
//                   child: SvgPicture.asset(
//                     _imagePathsInStepperOrderSVGs[widget.order.statusIndex],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text(
//                     widget.order.status,
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 CStepper(
//                   initailIndex: widget.order.statusIndex,
//                   onTapToRate: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => OrderRatingDialog(
//                           order: widget.order,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 GestureDetector(
//                   onTap: _showDialog,
//                   child: OrderBriefDetails(
//                     order: widget.order,
//                   ),
//                 ),
//                 // Spacer(),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Divider(
//                   endIndent: 25,
//                   indent: 25,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         trs.translate("total"),
//                         style: TextStyle(
//                           fontSize: 17,
//                         ),
//                       ),
//                       Text(
//                         widget.order.totalPrice + " " + trs.translate('rs'),
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _showDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return OrderDetailsDialog(
//           order: widget.order,
//         );
//       },
//     );
//   }
// }
