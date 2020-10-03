// import 'package:cyclist/models/responses/notifications_response.dart';
// import 'package:cyclist/repos/home_repo.dart';
// import 'package:cyclist/utils/colors.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:cyclist/widgets/center_err.dart';
// import 'package:cyclist/widgets/standered_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shimmer/shimmer.dart';

//! DISABLED
// class AllNotificationsScreen extends StatefulWidget {
//   final Widget prevWidget;

//   const AllNotificationsScreen({Key key, this.prevWidget}) : super(key: key);
//   @override
//   _AllNotificationsScreenState createState() => _AllNotificationsScreenState();
// }

// class _AllNotificationsScreenState extends State<AllNotificationsScreen> {
//   Future<NotificationsResponse> _getNofication;

//   @override
//   void initState() {
//     _getNofication = HomeRepo().getNotifications();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final trs = AppTranslations.of(context);
//     final List<Color> _orderStatusCardTextColor = [
//       CColors.darkBlue,
//       CColors.orderStatusOnItsWay,
//       CColors.blueStatusColor,
//       Colors.green,
//     ];
//     return Scaffold(
//       appBar: StanderedAppBar(),
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             StanderedAppBar(
//               appBarType: AppBarType.transparent,
//               centerChild: Text(
//                 trs.translate('notifications'),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder<NotificationsResponse>(
//                 future: _getNofication,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return _loader(size, _orderStatusCardTextColor);
//                   }
//                   if (snapshot.hasData) {
//                     final data = snapshot.data;
//                     if (data.notifications.isEmpty) {
//                       return CenterErr(
//                         icon: FontAwesomeIcons.bellSlash,
//                         msg: trs.translate("no_notificaion"),
//                       );
//                     } else {
//                       return ListView.builder(
//                         itemCount: data.notifications.length,
//                         itemBuilder: (context, index) {
//                           final itemData = data.notifications[index];
//                           final isDark = index.isEven || index == 0;
//                           return Container(
//                             color: isDark ? Colors.grey[200] : Colors.grey[100],
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 radius: size.aspectRatio * 45,
//                                 child: Center(
//                                   child: Text(
//                                     itemData.notifiableId,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               title: Text(
//                                 itemData.data.body,
//                                 style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               subtitle: Row(
//                                 children: <Widget>[
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 20,
//                                       vertical: 2,
//                                     ),
//                                     margin: const EdgeInsets.only(bottom: 5),
//                                     decoration: BoxDecoration(
//                                       color: _orderStatusCardTextColor[1],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         itemData.updatedAt.dateToString,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                   }
//                   if (snapshot.hasError) {
//                     if (snapshot.error.toString().contains("err")) {
//                       return CenterErr(
//                         icon: FontAwesomeIcons.heartBroken,
//                         msg: trs.translate("unKnown_error"),
//                       );
//                     }
//                   }
//                   return Container();
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _loader(Size size, List<Color> _orderStatusCardTextColor) {
//     return ListView.builder(
//       itemCount: 8,
//       itemBuilder: (context, index) {
//         return Container(
//           color: Colors.grey[50],
//           margin: EdgeInsets.only(bottom: 10),
//           child: ListTile(
//             leading: Shimmer.fromColors(
//               baseColor: Colors.grey[300],
//               highlightColor: Colors.grey[100],
//               child: CircleAvatar(
//                 radius: size.aspectRatio * 45,
//                 child: Shimmer.fromColors(
//                   baseColor: Colors.grey[300],
//                   highlightColor: Colors.grey[100],
//                   child: Center(
//                     child: Text(
//                       "50",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             title: Shimmer.fromColors(
//               baseColor: Colors.grey[300],
//               highlightColor: Colors.grey[100],
//               child: Text(
//                 "itemData.data placeholder",
//                 style: TextStyle(
//                   color: Colors.transparent,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//             subtitle: Row(
//               children: <Widget>[
//                 Shimmer.fromColors(
//                   baseColor: Colors.grey[300],
//                   highlightColor: Colors.grey[100],
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 2,
//                     ),
//                     margin: const EdgeInsets.only(bottom: 5),
//                     decoration: BoxDecoration(
//                       color: _orderStatusCardTextColor[1],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "itemData.upda",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// extension StringToTime on String {
//   String get dateToString {
//     DateTime date = DateTime.parse(this);
//     return "${date.day} - ${date.month} - ${date.year}";
//   }
// }
