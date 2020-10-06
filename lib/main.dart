import 'package:cyclist/Controllers/repositories/lang_repo.dart';
import 'package:cyclist/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations_delegate.dart';
import 'package:cyclist/utils/locales/appliction.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: CColors.statusBarClolor));
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  static Map<int, Color> color = {
    50: Color.fromRGBO(46, 139, 162, .1),
    100: Color.fromRGBO(46, 139, 162, .2),
    300: Color.fromRGBO(46, 139, 162, .4),
    200: Color.fromRGBO(46, 139, 162, .3),
    400: Color.fromRGBO(46, 139, 162, .5),
    500: Color.fromRGBO(46, 139, 162, .6),
    600: Color.fromRGBO(46, 139, 162, .7),
    700: Color.fromRGBO(46, 139, 162, .8),
    800: Color.fromRGBO(46, 139, 162, .9),
    900: Color.fromRGBO(46, 139, 162, 1),
  };
  final MaterialColor primarySwatch = MaterialColor(0xFF2E8BA2, color);

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  void initState() {
    application.onLocaleChanged = onLocaleChange;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: Locale('ar', 'ar'));
    // HomeRepo().storeOrDestoryFav(prodId: 7);
//    print('started');
//    OrdersRepo().storDummyOrder().then((value) => print(value)).catchError((err)=>print(err.toString()));

    LangRepo().getLocaleCode().then((code) {
      setState(() {
        _newLocaleDelegate = AppTranslationsDelegate(newLocale: Locale(code, code));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // PushNotificationService().initialise();
    // print(_newLocaleDelegate.newLocale.languageCode);
    // if (todos.length > 0) print(' you still have more todos');
    // HomeRepo().storeOrDestoryFav(prodId: 7);
    return Directionality(
      textDirection: _newLocaleDelegate.newLocale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: application.supportedLocales(),
        // builder: DevicePreview.appBuilder,
        localizationsDelegates: [
          _newLocaleDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _newLocaleDelegate.newLocale,
        title: "Cyclist",
        theme: ThemeData(
          fontFamily: 'Cairo',
          primaryColor: CColors.darkGreen,
          accentColor: CColors.darkGreenAccent,
          primarySwatch: primarySwatch,
          accentColorBrightness: Brightness.dark,
          cursorColor: CColors.darkGreen,
          brightness: Brightness.light,
          accentIconTheme: IconThemeData(
            color: CColors.lightGreen,
          ),
          appBarTheme: AppBarTheme.of(context).copyWith(
            brightness: Brightness.dark,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        home: SplashScreen(),
        // home: PaymentScreen(),
      ),
    );
  }
}
