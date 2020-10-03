import 'package:cyclist/other/setting_screen.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/Drawer/drawer_items.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return SafeArea(
      child: Drawer(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.02),
        decoration: BoxDecoration(gradient: CColors.gradient),
        child: Column(children: <Widget>[
          // Image(
          //   image: AssetImage(cotton_white_logo_drawer),
          // ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: size.height * 0.06),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       CircleAvatar(
          //         radius: 30,
          //         backgroundImage:
          //             isLoggedIn && (user?.imagePath != null) ? NetworkImage(user.imagePath) : AssetImage(user_avatar),
          //       ),
          //       SizedBox(width: size.width * 0.05),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Text(
          //               user == null ? trs.translate('vistor') : user.name,
          //               style: TextStyle(
          //                 fontSize: 20,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             Visibility(
          //               visible: isLoggedIn,
          //               child: Row(
          //                 children: <Widget>[
          //                   Icon(Icons.location_on, color: Colors.white),
          //                   Text(
          //                     user == null ? '' : user.address,
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // DrawerItems(
          //   icon: Icons.notifications,
          //   onTap: () {
          //     _closeDrawer();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (_) => MyNotifictionsScreen(),
          //       ),
          //     );
          //   },
          //   text: trs.translate("notifications"),
          // ),
          // DividerSize(),
          // DrawerItems(
          //   icon: Icons.restaurant_menu,
          //   onTap: () {
          //     _closeDrawer(context);
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (_) => MyOrdersScreen(),
          //     //   ),
          //     // );
          //     BlocProvider.of<HomeScreenBloc>(context).add(ChangeTap(tab: HomeTabs.orders));
          //   },
          //   text: trs.translate("orders"),
          // ),
          // DividerSize(),
          // DrawerItems(
          //   icon: Icons.favorite_border,
          //   onTap: () {
          //     _closeDrawer();
          //     BlocProvider.of<HomeScreenBloc>(context).add(ChangeTap(tab: HomeTabs.fav));
          //   },
          //   text: trs.translate("favorite"),
          // ),
          // DividerSize(),
          DrawerItems(
            icon: FontAwesomeIcons.cog,
            onTap: () {
              _closeDrawer(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingScreen(),
                ),
              );
            },
            text: trs.translate("settings"),
          ),
          // DividerSize(),
          // Visibility(
          //   visible: isLoggedIn,
          //   child: DrawerItems(
          //     icon: FontAwesomeIcons.signOutAlt,
          //     onTap: () async {
          //       await AuthRepo().signOut();
          //       _setState(() => isLoggedIn = false);
          //     },
          //     text: trs.translate("sign_out"),
          //   ),
          // )
        ]),
      )),
    );
  }

  _closeDrawer(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}

class DividerSize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.7,
        child: Divider(
          color: Colors.white54,
        ),
      ),
    );
  }
}
