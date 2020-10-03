import 'package:badges/badges.dart';
import 'package:cyclist/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:cyclist/repos/cart_contents_provider.dart';
import 'package:cyclist/screens/home_screen/tabs/cart_tab.dart';
import 'package:cyclist/screens/home_screen/tabs/home_tab.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/enums.dart';
import 'package:cyclist/utils/keys.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  HomeTabs _selctedTab;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _selctedTab = HomeTabs.home;
    super.initState();
  }

  _setState(VoidCallback state) {
    if (mounted) setState(state);
  }

  @override
  Widget build(BuildContext context) {
    final AppTranslations trs = AppTranslations.of(context);
    final _providerCartCount = Provider.of<CartItemsProvider>(context).cartCount;
    // ignore: close_sinks
    HomeScreenBloc bloc = HomeScreenBloc.of(context);
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is TabChanged) {
          _setState(() {
            _selctedTab = state.tab;
            print(_selctedTab);
            switch (state.tab) {
              case HomeTabs.home:
                _tabController.index = 0;
                _tabController?.animateTo(0);
                break;
              case HomeTabs.cart:
                _tabController.index = 1;
                _tabController?.animateTo(1);
                break;
            }
          });
        } else if (state is OpenDrawerState) {
          _scaffoldKey.currentState.openDrawer();
          print("State: ${trs.currentLanguage}");
        }
      },
      child: Scaffold(
        appBar: StanderedAppBar(),
        key: _scaffoldKey,
        bottomNavigationBar: Directionality(
          textDirection: trs.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: BottomNavigationBar(
            elevation: 1,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Icon(
                  FontAwesomeIcons.home,
                  size: 24,
                  color: CColors.blueStatusColor,
                ),
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: 20,
                  color: CColors.appBarColor,
                ),
                title: Text(
                  trs.translate('home_screen_short'),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: _selctedTab == HomeTabs.home ? CColors.blueStatusColor : CColors.appBarColor,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: Badge(
                  showBadge: _providerCartCount != null,
                  badgeColor: Colors.red,
                  borderRadius: 20,
                  toAnimate: false,
                  padding: EdgeInsets.zero,
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      _providerCartCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  child: Icon(
                    FontAwesomeIcons.cartPlus,
                    size: 24,
                    color: CColors.blueStatusColor,
                  ),
                ),
                icon: Badge(
                  showBadge: _providerCartCount != null,
                  badgeColor: Colors.red,
                  borderRadius: 20,
                  toAnimate: false,
                  padding: EdgeInsets.zero,
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      _providerCartCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  child: Icon(
                    FontAwesomeIcons.cartPlus,
                    size: 20,
                    color: CColors.appBarColor,
                  ),
                ),
                title: Text(
                  trs.translate('cart'),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: _selctedTab == HomeTabs.cart ? CColors.blueStatusColor : CColors.appBarColor,
                  ),
                ),
              ),
            ],
            showUnselectedLabels: true,
            currentIndex: _tabController.index,
            backgroundColor: Colors.white,
            onTap: (index) {
              print(index);
              switch (index) {
                case 0:
                  bloc.add(ChangeTap(tab: HomeTabs.home));
                  break;
                case 1:
                  bloc.add(ChangeTap(tab: HomeTabs.cart));
                  break;
              }
            },
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            HomeTab(),
            CartTab(),
          ],
        ),
      ),
    );
  }
}
