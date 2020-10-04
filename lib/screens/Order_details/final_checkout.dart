// import 'package:flutter/material.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:cyclist/models/responses/Checkout/order_post_request.dart' as orderR;
// import 'package:cyclist/repos/cart_repo.dart';
// import 'package:cyclist/repos/orders_repo.dart';
// import 'package:cyclist/screens/Order_details/paymant_screen.dart';
// import 'package:cyclist/screens/sucess.dart';
// import 'package:cyclist/utils/alert_manager.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
// import 'package:cyclist/widgets/buttons/custom_main_button.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// class FinalCheckout extends StatefulWidget {
//   final orderR.PostOrder order;
//   FinalCheckout({Key key, this.order}) : super(key: key);

//   @override
//   _FinalCheckoutState createState() => _FinalCheckoutState();
// }

// class _FinalCheckoutState extends State<FinalCheckout> {
//   final _formKey = GlobalKey<FormState>();
//   final _orderRepo = OrdersRepo();
//   bool isloading = false;
//   String _userName;
//   String _phoneNumber;
//   String _note;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final AppTranslations trs = AppTranslations.of(context);
//     final isArabic = trs.currentLanguage == 'ar';
//     return ModalProgressHUD(
//       inAsyncCall: isloading,
//       progressIndicator: AdaptiveProgessIndicator(),
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: StanderedAppBar(),
//           // floatingActionButton: FloatingActionButton(onPressed: () {
//           //   print(_totalWieght);
//           // }),
//           persistentFooterButtons: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
//               child: CustomMainButton(
//                 borderRaduis: 25,
//                 height: 45,
//                 width: size.width,
//                 textSize: 14,
//                 onTap: () {
//                   if (_formKey.currentState.validate()) {
//                     String text = _phoneNumber.trim();
//                     // if (!text.contains("966")) text = "966" + text.trim();
//                     _phoneNumber = text;
//                     _handleCheckout(trs);
//                   }
//                 },
//                 text: trs.translate("receive_order"),
//               ),
//             ),
//           ],
//           body: SafeArea(
//             child: Stack(
//               children: <Widget>[
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   child: StanderedAppBar(
//                     appBarType: AppBarType.transparent,
//                   ),
//                 ),
//                 Positioned(
//                   top: (size.height * 0.05) + 20,
//                   left: isArabic ? 40 : 20,
//                   right: !isArabic ? 40 : 20,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(trs.translate('buyer_details')),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: (size.height * 0.05) + (20 + 30),
//                   left: 0,
//                   right: 0,
//                   child: Divider(
//                     color: Colors.grey,
//                     thickness: 0.2,
//                   ),
//                 ),
//                 Positioned(
//                   top: ((size.height * 0.05) + (20 + 30 + 15)),
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: size.width * 0.035, vertical: size.height * 0.01),
//                     child: SingleChildScrollView(
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             _buildUserNameTextField(size, trs),
//                             SizedBox(height: 20),
//                             _buildPhoneNumberTextField(size, trs),
//                             SizedBox(height: 20),
//                             _buildNoteTextField(size, trs),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserNameTextField(Size size, AppTranslations trs) {
//     return Container(
//       // height: size.height * 0.065,
//       child: Container(
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           borderRadius: BorderRadius.circular(40),
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.grey[200],
//           //     spreadRadius: 1,
//           //     blurRadius: 10,
//           //   ),
//           // ],
//         ),
//         child: TextFormField(
//           keyboardType: TextInputType.text,
//           keyboardAppearance: Brightness.dark,
//           textInputAction: TextInputAction.next,
//           style: TextStyle(
//             fontSize: 13,
//           ),
//           decoration: InputDecoration(
//             labelText: trs.translate("name"),
//             isDense: true,
//             labelStyle: TextStyle(),
//             hintText: trs.translate("name"),
//             errorStyle: TextStyle(
//               color: Colors.red,
//               fontSize: 12,
//             ),
//             prefixIcon: Icon(FontAwesomeIcons.user),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.teal,
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//           onChanged: (value) {
//             _userName = value;
//           },
//           validator: (value) {
//             if (value.isEmpty) {
//               return trs.translate("re_enter_your_name");
//             }
//             return null;
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPhoneNumberTextField(Size size, AppTranslations trs) {
//     return Container(
//       // height: size.height * 0.065,
//       child: Container(
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           borderRadius: BorderRadius.circular(40),
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.grey[200],
//           //     spreadRadius: 1,
//           //     blurRadius: 10,
//           //   ),
//           // ],
//         ),
//         child: TextFormField(
//           keyboardType: TextInputType.number,
//           keyboardAppearance: Brightness.dark,
//           style: TextStyle(
//             fontSize: 13,
//           ),
//           decoration: InputDecoration(
//             labelText: trs.translate("phone_no"),
//             labelStyle: TextStyle(),
//             hintText: "0512345678",
//             errorStyle: TextStyle(
//               color: Colors.red,
//               fontSize: 12,
//             ),
//             prefixIcon: Icon(FontAwesomeIcons.phone),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.teal,
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//           onChanged: (value) {
//             _phoneNumber = value;
//           },
//           validator: (value) {
//             String text = value.trim();
//             final regex = new RegExp(r'/^05[0-9]{8}/');
//             if (regex.hasMatch(text)) {
//               print("PHONE NUMBER ERROR");
//               return trs.translate("please_re_enter_number");
//             } else if (value.isEmpty) {
//               return trs.translate("please_re_enter_number");
//             }
//             return null;
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildNoteTextField(Size size, AppTranslations trs) {
//     return Container(
//       // height: size.height * 0.065,
//       child: Container(
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           borderRadius: BorderRadius.circular(40),
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.grey[200],
//           //     spreadRadius: 1,
//           //     blurRadius: 10,
//           //   ),
//           // ],
//         ),
//         child: TextFormField(
//           keyboardType: TextInputType.multiline,
//           maxLines: 5,
//           keyboardAppearance: Brightness.dark,
//           style: TextStyle(
//             fontSize: 13,
//           ),
//           decoration: InputDecoration(
//             fillColor: Colors.white,
//             labelText: trs.translate("note"),
//             labelStyle: TextStyle(),
//             hintText: trs.translate("write_oreder_note"),
//             errorStyle: TextStyle(
//               color: Colors.red,
//               fontSize: 13,
//             ),
//             prefixIcon: Icon(FontAwesomeIcons.comment),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.teal,
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//           onChanged: (value) {
//             _note = value;
//           },
//           validator: (value) {
//             return null;
//           },
//         ),
//       ),
//     );
//   }

//   void _handleCheckout(AppTranslations trs) async {
//     final CartRepo _cartRepo = CartRepo();
//     try {
//       setState(() => isloading = true);
//       final orderResponse = await _orderRepo.orderCart(
//           order: widget.order.copyWith(
//         phone: _phoneNumber,
//         name: _userName,
//         note: _note,
//       ));
//       if (orderResponse.url.isNotEmpty) {
//         final PaylinkError result = await Navigator.push<PaylinkError>(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PaymentScreen(
//                 paymentUrl: orderResponse.url,
//               ),
//             ));
//         switch (result) {
//           case PaylinkError.FAILED:
//             //*DO SOMTHING
//             await Future.delayed(Duration(milliseconds: 500), () {
//               showPlatformDialog<void>(
//                 context: context,
//                 builder: (context) {
//                   return PlatformAlertDialog(
//                     title: Text(
//                       trs.translate("failed"),
//                       style: TextStyle(color: Colors.red),
//                     ),
//                     content: Text(trs.translate("checkout_failure_dec")),
//                     actions: <Widget>[
//                       PlatformDialogAction(
//                         child: PlatformText(trs.translate("ok")),
//                         onPressed: () {
//                           Navigator.of(context).pop(false);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             });
//             break;
//           default:
//             //*DO SOMTHING 2
//             break;
//         }
//       } else {
//         await _cartRepo.clearCart();
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ApplicationSubmitted(),
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//       alertWithErr(context: context, msg: trs.translate("rating_error"));
//     } finally {
//       setState(() => isloading = false);
//     }
//   }
// }
