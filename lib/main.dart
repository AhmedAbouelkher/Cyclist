import 'package:cyclist/blocs/Provider/login_returen_provider.dart';
import 'package:cyclist/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:cyclist/repos/cart_contents_provider.dart';
import 'package:cyclist/repos/lang_repo.dart';
import 'package:cyclist/screens/splash_screen.dart';
// import 'package:cyclist/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations_delegate.dart';
import 'package:cyclist/utils/locales/appliction.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartItemsProvider(),
        )
      ],
      child: Provider(
        create: (context) => LoginReturn(),
        child: BlocProvider(
          create: (_) => HomeScreenBloc(),
          child: Directionality(
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
              title: "Bicycle",
              theme: ThemeData(fontFamily: 'Cairo', accentColor: CColors.appBarColorOpacity),
              home: SplashScreen(),
              // home: PaymentScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
