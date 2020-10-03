// import 'package:cyclist/blocs/Provider/login_returen_provider.dart';
// import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
// import 'package:cyclist/widgets/buttons/custom_main_button.dart';
// import 'package:cyclist/screens/auth/active_code_screen.dart';
// import 'package:cyclist/utils/alert_manager.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:cyclist/widgets/text_feilds/custom_text_feild.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:cyclist/repos/auth_repo.dart';
// import 'package:cyclist/utils/images.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SingInScreen extends StatefulWidget {
//   final bool showIndependentAppbar;
//   final Widget whereBefore;
//   const SingInScreen({
//     Key key,
//     this.showIndependentAppbar = false,
//     this.whereBefore,
//   }) : super(key: key);
//   @override
//   _SingInScreenState createState() => _SingInScreenState();
// }

// class _SingInScreenState extends State<SingInScreen> {
//   TextEditingController controller = TextEditingController();
//   bool _isLoading = false;
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     Provider.of<LoginReturn>(context, listen: false).setCurrentScreen = widget.whereBefore;
//     super.initState();
//   }

//   void handleLogin({BuildContext context}) async {
//     final AppTranslations trs = AppTranslations.of(context);

//     if (controller.text.trim().length == 0) {
//       alertWithErr(context: context, msg: trs.translate('phone_cant_be_empty'));
//       return;
//     }
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       String code = await AuthRepo().sendSmsWithCode(phoneNo: controller.text.trim());
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => ActiveCodeScreen(
//             tempCode: code,
//             phoneNo: controller.text.trim(),
//           ),
//         ),
//       );
//     } catch (e) {
//       alertWithErr(context: context, msg: trs.translate("there_is_an_error"));
//     } finally {
//       setState(() => _isLoading = false);
//       if (widget.showIndependentAppbar) {
//         Navigator.pop(context);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final AppTranslations trs = AppTranslations.of(context);
//     return ModalProgressHUD(
//       inAsyncCall: _isLoading,
//       progressIndicator: AdaptiveProgessIndicator(),
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: StanderedAppBar(),
//           body: SafeArea(
//             child: Container(
//               height: size.height,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: <Widget>[
//                     Stack(
//                       fit: StackFit.passthrough,
//                       children: <Widget>[
//                         Image.asset(
//                           login_banner,
//                           width: size.width,
//                           height: size.height * 0.55,
//                           fit: BoxFit.fill,
//                         ),
//                         // SizedBox(
//                         //   width: size.width,
//                         //   height: size.height * 0.55,
//                         //   child: SvgPicture.asset(
//                         //     loginBannerSVG,
//                         //     fit: BoxFit.fill,
//                         //   ),
//                         // ),
//                         Positioned(
//                           top: size.height * 0.05,
//                           left: size.width * 0.05,
//                           child: Image.asset(white_logo),
//                         ),
//                         Positioned(
//                           left: 0,
//                           right: 0,
//                           top: 0,
//                           child: widget.showIndependentAppbar
//                               ? StanderedAppBar(
//                                   appBarType: AppBarType.transparent,
//                                 )
//                               : Container(),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(
//                         left: size.width * 0.08,
//                         right: size.width * 0.08,
//                         top: size.height * 0.045,
//                         bottom: size.height * (0.045 / 3),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.baseline,
//                         textBaseline: TextBaseline.alphabetic,
//                         children: <Widget>[
//                           Expanded(
//                             child: CustomTextFeild(
//                               icon: Icons.phone_android,
//                               controller: controller,
//                               text: trs.translate('stc_number'),
//                               inputType: TextInputType.phone,
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(right: size.width * 0.04),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text("966+  "),
//                                 Image.asset(
//                                   kas_flag,
//                                   fit: BoxFit.fill,
//                                   height: size.height * 0.03,
//                                   width: size.width * 0.06,
//                                 ),
//                                 SizedBox(height: size.height * 0.10)
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     CustomMainButton(
//                       borderRaduis: 25,
//                       height: size.height * 0.060,
//                       width: size.width * 0.75,
//                       onTap: () => handleLogin(context: context),
//                       text: trs.translate('login'),
//                     ),
//                     SizedBox(height: size.height * 0.02),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: size.width * 0.12,
//                       ),
//                       child: RichText(
//                         textAlign: TextAlign.center,
//                         text: TextSpan(
//                           text: "${trs.translate("sing_in_text1")}",
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: Colors.black54,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: "\t${trs.translate("sing_in_underLine_text1")}\t",
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.black54,
//                                 decoration: TextDecoration.underline,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                             TextSpan(
//                               text: "\t${trs.translate("sing_in_text2")}\t",
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                             TextSpan(
//                               text: trs.translate("sing_in_underLine_text2"),
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.black54,
//                                 decoration: TextDecoration.underline,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
