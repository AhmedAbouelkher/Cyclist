// import 'dart:io';
// import 'package:cyclist/blocs/home_screen_bloc/home_screen_bloc.dart';
// import 'package:cyclist/models/responses/confirm_code_response.dart';
// import 'package:cyclist/repos/auth_repo.dart';
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
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// class ChangeAccountSettings extends StatefulWidget {
//   @override
//   _ChangeAccountSettingsState createState() => _ChangeAccountSettingsState();
// }

// class _ChangeAccountSettingsState extends State<ChangeAccountSettings> {
//   File _image;
//   String selectedGender;
//   bool _loading;
//   AuthRepo _authRepo;
//   User user;
//   final picker = ImagePicker();
//   TextEditingController nameController;
//   TextEditingController phoneController;
//   TextEditingController emailController;
//   TextEditingController addressController;
//   @override
//   void initState() {
//     _loading = true;
//     selectedGender = "ذكر";
//     _authRepo = AuthRepo();
//     _authRepo.getCurrentUser().then((user) {
//       this.user = user;
//       nameController = TextEditingController(text: user?.name);
//       phoneController = TextEditingController(text: user?.phone);
//       emailController = TextEditingController(text: user?.email);
//       addressController = TextEditingController(text: user?.address);
//       _setState(() => _loading = false);
//     });
//     super.initState();
//   }

//   _setState(VoidCallback state) {
//     if (mounted) setState(state);
//   }

//   @override
//   void dispose() {
//     nameController?.dispose();
//     phoneController?.dispose();
//     emailController?.dispose();
//     addressController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final AppTranslations trs = AppTranslations.of(context);
//     return ModalProgressHUD(
//       inAsyncCall: _loading,
//       progressIndicator: AdaptiveProgessIndicator(),
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: StanderedAppBar(),
//           persistentFooterButtons: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
//               child: CustomMainButton(
//                 height: size.height * 0.065,
//                 width: size.width,
//                 borderRaduis: 30,
//                 onTap: () {
//                   handleUpdateUSer(context: context);
//                 },
//                 text: trs.translate('update'),
//               ),
//             ),
//           ],
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   _buildAppBar(size, context),
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
//                               imageUrl: user?.imagePath,
//                               onImageSubmit: (File _imageFile) async {
//                                 _setState(() => _image = _imageFile);
//                               },
//                             ),
//                             SizedBox(
//                               width: size.width * 0.05,
//                             ),
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
//                         SizedBox(
//                           height: size.height * 0.01,
//                         ),
//                         CustomTextFeild(
//                           controller: nameController,
//                           icon: Icons.account_circle,
//                           text: trs.translate('name'),
//                         ),
//                         CustomTextFeild(controller: emailController, icon: Icons.markunread, text: trs.translate('email')),
//                         CustomTextFeild(controller: addressController, icon: Icons.location_on, text: trs.translate('addres')),
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
//                         SizedBox(height: size.height * 0.015),
//                         GenderPicker(
//                           onChanged: (String gender) {
//                             selectedGender = gender;
//                           },
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

//   Stack _buildAppBar(Size size, BuildContext context) {
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
//             child: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 size: 25,
//               ),
//               color: Colors.white,
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void handleUpdateUSer({BuildContext context}) async {
//     final AppTranslations trs = AppTranslations.of(context);

//     if (nameController.text.trim().length == 0) {
//       alertWithErr(context: context, msg: trs.translate('name_cant_be_empty'));
//       return;
//     }
//     if (emailController.text.trim().length > 0) {
//       bool emailValid = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
//       ).hasMatch(emailController.text.trim());

//       if (!emailValid) {
//         alertWithErr(msg: trs.translate('email_not_valid'), context: context);

//         return;
//       }
//     }

//     if (addressController.text.trim().length == 0) {
//       alertWithErr(context: context, msg: trs.translate('address_cant_be_empty'));
//       return;
//     }
//     try {
//       _setState(() => _loading = true);
//       await AuthRepo().updateUser(
//         phone: user.phone,
//         name: nameController.text.trim(),
//         email: emailController.text.trim(),
//         address: addressController.text.trim(),
//         gender: selectedGender,
//         photo: _image,
//       );
//       alertWithSuccess(context: context, msg: trs.translate('data_updated'));
//       HomeScreenBloc.of(context).add(UserDataChanged());
//       Navigator.pop(context);
//     } catch (e) {
//       alertWithErr(msg: trs.translate("there_is_an_error"), context: context);
//     } finally {
//       _setState(() => _loading = false);
//     }
//   }

//   // ignore: unused_element
//   void _handleAddress(AppTranslations trs, BuildContext context) async {
//     final trs = AppTranslations.of(context);
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//           title: Center(
//             child: Text(
//               trs.translate("info"),
//               style: TextStyle(
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Icon(
//                   FontAwesomeIcons.frown,
//                   size: 40,
//                 ),
//               ),
//               Text(
//                 trs.translate("api_key_error"),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text(trs.translate("close")),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
