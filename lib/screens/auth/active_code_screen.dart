// import 'package:cyclist/models/responses/confirm_code_response.dart';
// import 'package:cyclist/repos/auth_repo.dart';
// import 'package:cyclist/screens/home_screen/home_screen.dart';
// import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
// import 'package:cyclist/widgets/buttons/custom_main_button.dart';
// import 'package:cyclist/screens/auth/sign_up_screen.dart';
// import 'package:cyclist/utils/alert_manager.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// class ActiveCodeScreen extends StatefulWidget {
//   final String phoneNo;
//   final String tempCode;

//   ActiveCodeScreen({this.phoneNo, this.tempCode});

//   @override
//   _ActiveCodeScreenState createState() => _ActiveCodeScreenState();
// }

// class _ActiveCodeScreenState extends State<ActiveCodeScreen> {
//   BorderSide _borderSide = new BorderSide(width: 1.5, color: Colors.black26);
//   int seceonds = 60;

//   Future<void> _confirmCode({BuildContext context, String code, AppTranslations trs}) async {
//     _setState(() => _isLoading = true);
//     try {
//       ConfirmCodeResponse response = await AuthRepo().checkCode(
//         code: code,
//         phoneNo: widget.phoneNo,
//       );

//       // ok
//       if (response.user.name == null) {
//         // this is new user go to sign up
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return SignUpScreen(
//                 response: response,
//               );
//             },
//           ),
//         );
//       } else {
//         // update user with already data
//         //        loginWithAlreadyUser(user: response.user, token: response.accessToken);
//         // Navigator.pop(context);
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return HomeScreen();
//             },
//           ),
//           (route) => false,
//         );
//       }
//     } catch (e) {
//       alertWithErr(msg: trs.translate("invalid_code"), context: context);
//     } finally {
//       _setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _sendCodeAgain({BuildContext context, AppTranslations trs}) async {
//     _setState(() {
//       _isLoading = true;
//     });
//     final r = await AuthRepo().sendSmsWithCode(phoneNo: widget.phoneNo);
//     if (r != null) {
//       // sucess go to await active
//       _setState(() {
//         _isLoading = false;
//         seceonds = 60;
//       });
//       timeMachine();
//     } else {
//       _setState(() {
//         _isLoading = false;
//         alertWithErr(msg: trs.translate("there_is_an_error"), context: context);
//       });
//     }
//   }

//   bool _isLoading = false;
//   final TextEditingController _codeCont = TextEditingController();
//   void timeMachine() async {
//     while (true) {
//       if (seceonds > 0) {
//         await Future.delayed(Duration(seconds: 1));
//         _setState(() {
//           seceonds--;
//         });
//       } else {
//         _setState(() {});
//         break;
//       }
//     }
//   }

//   //  void loginWithAlreadyUser({User user, String token}) async {
// //    try {
// //      bool isOk = await AuthRepo().updateUser(
// //          phone: user.phone,
// //          name: user.name,
// //          email: user.email,
// //          address: user.address,
// //           gender: user.gender,
// //          );
// //      if (isOk) {
// //        Navigator.pop(context);
// //      } else {
// //        _setState(() {
// //          _isLoading = false;
// //        });
// //      }
// //    } catch (e) {
// //      print(e);
// //    }
// //  }

//   @override
//   void initState() {
//     timeMachine();
//     print(widget.tempCode);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _codeCont?.dispose();
//     super.dispose();
//   }

//   _setState(VoidCallback state) {
//     if (mounted) setState(state);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final AppTranslations trs = AppTranslations.of(context);

//     return ModalProgressHUD(
//       inAsyncCall: _isLoading,
//       progressIndicator: AdaptiveProgessIndicator(),
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: StanderedAppBar(),
//           /*
//           appBar: AppBar(
//             centerTitle: true,
//             backgroundColor: appBarColor,
//             elevation: 0,
//             title: Text(
//               trs.translate('active_login_code'),
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           */
//           body: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 StanderedAppBar(
//                   appBarType: AppBarType.transparent,
//                   centerChild: Text(
//                     trs.translate('active_login_code'),
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.05),
//                 Center(
//                   child: Container(
//                     height: 50,
//                     width: size.width - 50,
//                     margin: EdgeInsets.only(top: 10, bottom: 10),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         top: _borderSide,
//                         bottom: _borderSide,
//                         left: _borderSide,
//                         right: _borderSide,
//                       ),
//                     ),
//                     child: TextField(
//                       controller: _codeCont,
//                       onChanged: (code) async {
//                         if (code.length == 5) {
//                           await _confirmCode(
//                             context: context,
//                             code: code,
//                             trs: trs,
//                           );
//                         }
//                       },
//                       style: const TextStyle(
//                         color: Colors.black,
//                       ),
//                       // keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: trs.translate('login_code'),
//                         contentPadding: EdgeInsets.only(right: 10),
//                         hintStyle: const TextStyle(
//                           color: Colors.black45,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.03),
//                 CustomMainButton(
//                   text: trs.translate('log_in'),
//                   height: size.height * 0.060,
//                   width: size.width * 0.75,
//                   onTap: () async {
//                     _setState(() => _isLoading = true);
//                     await _confirmCode(code: _codeCont.text, context: context);
//                   },
//                 ),
//                 SizedBox(height: size.height * 0.03),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 25),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       trs.translate('did_not_recive_the_code'),
//                       style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.01),
//                 Visibility(
//                   visible: seceonds != 0,
//                   maintainAnimation: false,
//                   maintainState: false,
//                   maintainSize: false,
//                   maintainSemantics: false,
//                   maintainInteractivity: false,
//                   child: Text(
//                     trs.translate('you_can_try_again_in') + "  $seceonds " + trs.translate('seceond'),
//                     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.01),
//                 Visibility(
//                   visible: seceonds == 0,
//                   child: CustomMainButton(
//                     outline: true,
//                     text: trs.translate('send_code_again'),
//                     height: size.height * (0.060 / 1.0),
//                     width: size.width * (0.75 / 1.5),
//                     onTap: () {
//                       _sendCodeAgain(
//                         context: context,
//                         trs: trs,
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Divider(
//                     thickness: 0.5,
//                     color: Colors.grey,
//                     endIndent: size.width * 0.1,
//                     indent: size.width * 0.1,
//                   ),
//                 ),
//                 Text(
//                   widget.tempCode,
//                   style: TextStyle(fontSize: 40),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
