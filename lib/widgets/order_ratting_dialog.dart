// import 'package:cyclist/models/responses/user_orders_response.dart';
// import 'package:cyclist/repos/orders_repo.dart';
// import 'package:cyclist/utils/alert_manager.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
// import 'package:cyclist/widgets/buttons/custom_main_button.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';

//! DISABLED
// class OrderRatingDialog extends StatefulWidget {
//   final Order order;

//   const OrderRatingDialog({Key key, this.order}) : super(key: key);
//   @override
//   _OrderRatingDialogState createState() => _OrderRatingDialogState();
// }

// class _OrderRatingDialogState extends State<OrderRatingDialog> {
//   int _rating = 2;
//   String _comment;
//   bool _isLoading = false;
//   TextEditingController _textEditingController;

//   @override
//   void initState() {
//     _textEditingController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _textEditingController?.dispose();
//     super.dispose();
//   }

//   void _rateOrder(AppTranslations trs) async {
//     _comment = _textEditingController?.text?.trim();
//     _setState(() {
//       _isLoading = true;
//     });
//     try {
//       await OrdersRepo().rateThisOrder(
//         comment: _comment,
//         orderId: widget.order.id,
//         starsCount: _rating,
//       );
//       Navigator.pop(context);
//     } catch (e) {
//       alertWithErr(
//         context: context,
//         msg: trs.translate("rating_error"),
//       );
//       print(e);
//     } finally {
//       _setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   _setState(VoidCallback state) {
//     if (mounted) setState(state);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final AppTranslations trs = AppTranslations.of(context);
//     Widget body = GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       height: size.width * 0.45,
//                       width: size.width * 0.45,
//                       child: Center(
//                         child: Container(
//                           height: size.width * 0.40,
//                           width: size.width * 0.40,
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 spreadRadius: 1,
//                                 blurRadius: 10,
//                               ),
//                             ],
//                           ),
//                           child: SvgPicture.asset(
//                             "assets/logo_cloud.svg",
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: size.height * 0.05),
//                     Text(
//                       trs.translate("thanks_for_useing"),
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     Text(
//                       trs.translate("how_experience"),
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: size.height * 0.015,
//                       ),
//                       child: _isLoading
//                           ? AdaptiveProgessIndicator()
//                           : Directionality(
//                               textDirection: trs.currentLanguage == 'ar' ? TextDirection.ltr : TextDirection.rtl,
//                               child: RatingBar(
//                                 initialRating: 4,
//                                 minRating: 0,
//                                 glow: false,
//                                 direction: Axis.horizontal,
//                                 allowHalfRating: false,
//                                 itemCount: 5,
//                                 itemPadding: const EdgeInsets.symmetric(horizontal: 5),
//                                 itemBuilder: (context, _) {
//                                   const double raduis = 22;
//                                   return SizedBox(
//                                     height: raduis,
//                                     width: raduis,
//                                     child: Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                   );
//                                 },
//                                 onRatingUpdate: (rating) {
//                                   _rating = rating.round();
//                                 },
//                               ),
//                             ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Text(
//                             "\t" + trs.translate("leave_comment"),
//                             style: TextStyle(
//                               fontSize: 13,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextField(
//                             controller: _textEditingController,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: null,
//                             decoration: InputDecoration(
//                               isDense: true,
//                               contentPadding: const EdgeInsets.all(20),
//                               border: OutlineInputBorder(),
//                               hintText: trs.translate("write_comment"),
//                               hintStyle: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 25),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           IgnorePointer(
//                             ignoring: _isLoading,
//                             child: CustomMainButton(
//                               text: trs.translate("evaluation"),
//                               textSize: 13,
//                               height: 50,
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: size.width * 0.15,
//                                 vertical: 5,
//                               ),
//                               onTap: () => _rateOrder(trs),
//                             ),
//                           ),
//                           CustomMainButton(
//                             outline: true,
//                             text: trs.translate("skip"),
//                             textSize: 13,
//                             height: 50,
//                             padding: EdgeInsets.symmetric(
//                               horizontal: size.width * 0.15,
//                               vertical: 5,
//                             ),
//                             onTap: () => Navigator.pop(context),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           StanderedAppBar(
//             appBarType: AppBarType.transparent,
//           ),
//         ],
//       ),
//     );
//     return Scaffold(
//       appBar: StanderedAppBar(),
//       body: SafeArea(child: body),
//     );
//   }
// }
