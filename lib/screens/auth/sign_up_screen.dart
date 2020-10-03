// import 'dart:io';
// import 'package:cyclist/models/responses/confirm_code_response.dart';
// import 'package:cyclist/repos/auth_repo.dart';
// import 'package:cyclist/screens/home_screen/home_screen.dart';
// import 'package:cyclist/utils/text_styles.dart';
// import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
// import 'package:cyclist/widgets/buttons/custom_main_button.dart';
// import 'package:cyclist/utils/alert_manager.dart';
// import 'package:cyclist/widgets/gender_picker.dart';
// import 'package:cyclist/widgets/image_uploader.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:cyclist/widgets/text_feilds/custom_text_feild.dart';
// import 'package:cyclist/utils/colors.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:flutter/material.dart';
// import 'package:cyclist/utils/images.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// class SignUpScreen extends StatefulWidget {
//   final ConfirmCodeResponse response;
//   SignUpScreen({this.response});
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   File _image;
//   String selectedGender;
//   bool _loading;
//   final picker = ImagePicker();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   @override
//   void initState() {
//     phoneController.text = widget.response.user.phone;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       selectedGender = AppTranslations.of(context).translate('male');
//     });
//     _loading = false;
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     nameController?.dispose();
//     phoneController?.dispose();
//     emailController?.dispose();
//     addressController?.dispose();
//     super.dispose();
//   }

//   _setState(VoidCallback state) {
//     if (mounted) setState(state);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final AppTranslations trs = AppTranslations.of(context);
//     final bool isArabic = trs.currentLanguage == 'ar';
//     return ModalProgressHUD(
//       inAsyncCall: _loading,
//       progressIndicator: AdaptiveProgessIndicator(),
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: StanderedAppBar(),
//           persistentFooterButtons: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(
//                 left: isArabic ? (size.width * 0.5 / 2) : 0,
//                 right: !isArabic ? (size.width * 0.5 / 2) : 0,
//               ),
//               child: CustomMainButton(
//                 height: size.height * 0.05,
//                 width: size.width * 0.5,
//                 textSize: 12,
//                 onTap: () => handleSignUp(context: context),
//                 text: trs.translate('long_in'),
//               ),
//             ),
//           ],
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   _buildAppBar(size, context),
//                   //TODO: sa flag
//                   // Container(
//                   //   height: size.height * 0.14,
//                   //   decoration: BoxDecoration(
//                   //     color: activeCatColor,
//                   //     borderRadius: BorderRadius.only(
//                   //       bottomLeft: Radius.circular(25),
//                   //     ),
//                   //   ),
//                   //   child: Center(
//                   //     child: Image(
//                   //       image: AssetImage(white_logo),
//                   //     ),
//                   //   ),
//                   // ),

//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: size.width * 0.08,
//                       vertical: size.height * 0.045,
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             UserPhotoUpload(
//                               onImageSubmit: (File _imageFile) async {
//                                 _setState(() => _image = _imageFile);
//                               },
//                             ),
//                             SizedBox(width: size.width * 0.05),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   trs.translate('your_profile_pic'),
//                                 ),
//                                 Text(
//                                   trs.translate("mustn't_5 mega"),
//                                   style: kLongInScreentextFieldStyle,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         SizedBox(height: size.height * 0.01),
//                         CustomTextFeild(
//                           controller: nameController,
//                           icon: Icons.account_circle,
//                           text: trs.translate('name'),
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Expanded(
//                               child: CustomTextFeild(
//                                 enabled: false,
//                                 controller: phoneController,
//                                 inputType: TextInputType.phone,
//                                 icon: Icons.phone_android,
//                                 text: trs.translate('stc_number'),
//                               ),
//                             ),
//                             SizedBox(
//                               width: size.width * 0.02,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(right: size.width * 0.04),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text("966+  "),
//                                   Image.asset(
//                                     kas_flag,
//                                     fit: BoxFit.fill,
//                                     height: size.height * 0.03,
//                                     width: size.width * 0.06,
//                                   ),
//                                   // SizedBox(
//                                   //   height: size.height * 0.03,
//                                   //   width: size.width * 0.06,
//                                   //                                     child: SvgPicture.asset(
//                                   //     saFlagSVG,
//                                   //     fit: BoxFit.fill,

//                                   //   ),
//                                   // ),
//                                   SizedBox(height: size.height * 0.10)
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         CustomTextFeild(
//                           controller: emailController,
//                           icon: Icons.markunread,
//                           text: trs.translate('email'),
//                         ),
//                         CustomTextFeild(
//                           controller: addressController,
//                           icon: Icons.location_on,
//                           text: trs.translate('addres'),
//                         ),
//                         SizedBox(
//                           height: size.height * 0.02,
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Text(
//                               trs.translate("gender"),
//                               style: kLongInScreentextStyle,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: size.height * 0.015,
//                         ),
//                         GenderPicker(
//                           onChanged: (String gender) {
//                             selectedGender = gender;
//                           },
//                         ),
//                         SizedBox(
//                           height: size.height * 0.06,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void handleSignUp({BuildContext context}) async {
//     final AppTranslations trs = AppTranslations.of(context);

//     if (nameController.text.trim().length == 0) {
//       alertWithErr(context: context, msg: trs.translate('name_cant_be_empty'));
//       return;
//     }
//     if (emailController.text.trim().length > 0) {
//       bool emailValid =
//           RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text.trim());

//       if (!emailValid) {
//         alertWithErr(msg: trs.translate('email_not_valid'), context: context);

//         return;
//       }
//     }

//     if (addressController.text.trim().length == 0) {
//       alertWithErr(
//         context: context,
//         msg: trs.translate('address_cant_be_empty'),
//       );
//       return;
//     }
//     try {
//       setState(() => _loading = true);
//       await AuthRepo().updateUser(
//         phone: widget.response.user.phone,
//         name: nameController.text.trim(),
//         email: emailController.text.trim(),
//         address: addressController.text.trim(),
//         gender: selectedGender,
//         photo: _image,
//       );
//       // Navigator.pop(context);
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) {
//             return HomeScreen();
//           },
//         ),
//         (route) => false,
//       );
//     } catch (e) {
//       alertWithErr(msg: trs.translate("there_is_an_error"), context: context);
//     } finally {
//       setState(() => _loading = false);
//     }
//   }

//   Widget _buildAppBar(Size size, BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           height: size.height * 0.16,
//           decoration: BoxDecoration(
//             color: CColors.activeCatColor,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//             ),
//           ),
//           child: Center(
//             child: Image(
//               image: AssetImage(white_logo),
//             ),
//           ),
//         ),
//         Align(
//           alignment: AppTranslations.of(context).currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             child: Container(),
//           ),
//         ),
//       ],
//     );
//   }

//   // void _handleAddress(AppTranslations trs, BuildContext context) async {
//   //   final trs = AppTranslations.of(context);
//   //   await showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         shape:
//   //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//   //         title: Center(
//   //           child: Text(
//   //             trs.translate("info"),
//   //             style: TextStyle(
//   //               color: Colors.blue,
//   //             ),
//   //           ),
//   //         ),
//   //         content: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: <Widget>[
//   //             Padding(
//   //               padding: const EdgeInsets.all(10.0),
//   //               child: Icon(
//   //                 FontAwesomeIcons.frown,
//   //                 size: 40,
//   //               ),
//   //             ),
//   //             Text(
//   //               trs.translate("api_key_error"),
//   //               textAlign: TextAlign.center,
//   //             ),
//   //           ],
//   //         ),
//   //         actions: <Widget>[
//   //           FlatButton(
//   //             child: Text(trs.translate("close")),
//   //             onPressed: () => Navigator.pop(context),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// }
