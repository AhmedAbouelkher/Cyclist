// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:cyclist/repos/cart_repo.dart';
// import 'package:cyclist/screens/sucess.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// enum PaylinkError { FAILED, PASSED_FAILED }

// class PaymentScreen extends StatefulWidget {
//   final String paymentUrl;

//   const PaymentScreen({Key key, this.paymentUrl}) : super(key: key);

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   WebViewController _controller;
//   final CartRepo _cartRepo = CartRepo();

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     // final AppTranslations trs = AppTranslations.of(context);
//     return Scaffold(
//       appBar: StanderedAppBar(),
//       body: Column(
//         children: <Widget>[
//           StanderedAppBar(
//             appBarType: AppBarType.transparent,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 size: size.aspectRatio * 50,
//               ),
//               color: Colors.white,
//               onPressed: () => Navigator.pop(context),
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     size: size.aspectRatio * 40,
//                   ),
//                   color: Colors.white,
//                   onPressed: () async {
//                     if (await _controller.canGoBack()) {
//                       _controller.goBack();
//                     }
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     FontAwesomeIcons.redoAlt,
//                     size: size.aspectRatio * 35,
//                   ),
//                   color: Colors.white,
//                   onPressed: () async {
//                     _controller.reload();
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_forward_ios,
//                     size: size.aspectRatio * 40,
//                   ),
//                   color: Colors.white,
//                   onPressed: () async {
//                     if (await _controller.canGoForward()) {
//                       _controller.goForward();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: WebView(
//               onPageFinished: (url) async {
//                 if (url.contains("payment")) {
//                   if (url.contains("payment=1")) {
//                     await _cartRepo.clearCart();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ApplicationSubmitted(),
//                       ),
//                     );
//                   } else {
//                     Navigator.of(context).pop(PaylinkError.FAILED);
//                   }
//                 }
//               },
//               javascriptMode: JavascriptMode.unrestricted,
//               initialUrl: widget.paymentUrl,
//               // initialUrl: "https://www.mazajasly.com/ar",
//               onWebViewCreated: (controller) {
//                 _controller = controller;
//                 print("Created");
//               },
//               onWebResourceError: (error) {
//                 print(error);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
