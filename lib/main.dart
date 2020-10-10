import 'package:after_layout/after_layout.dart';
import 'package:cyclist/Controllers/blocs/Categories/categories_bloc.dart';
import 'package:cyclist/Controllers/blocs/MakeRide/makeride_bloc.dart';
import 'package:cyclist/Controllers/blocs/Posts/posts_bloc.dart';
import 'package:cyclist/Controllers/blocs/Rides/rides_bloc.dart';
import 'package:cyclist/Controllers/repositories/home/repository.dart';
import 'package:cyclist/Controllers/repositories/lang_repo.dart';
import 'package:cyclist/Controllers/repositories/push_notifications.dart';
import 'package:cyclist/screens/splash_screen.dart';
import 'package:cyclist/utils/shared_perfs_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations_delegate.dart';
import 'package:cyclist/utils/locales/appliction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceUtils.init();
  runApp(DevicePreview(enabled: false, builder: (context) => MyApp()));
  Bloc.observer = SimpleBlocObserver();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;
  HomeRepo _homeRepo;

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
    _homeRepo = HomeRepo();
    application.onLocaleChanged = onLocaleChange;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: Locale('ar', 'ar'));

    LangRepo().getLocaleCode().then((code) {
      setState(() {
        _newLocaleDelegate = AppTranslationsDelegate(newLocale: Locale(code, code));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RidesBloc(homeRepo: _homeRepo)..add(LoadRides(key: UniqueKey()))),
        BlocProvider(create: (context) => CategoriesBloc(homeRepo: _homeRepo)..add(LoadCategories())),
        BlocProvider(create: (context) => MakerideBloc(homeRepo: _homeRepo)),
        BlocProvider(create: (context) => PostsBloc(homeRepo: _homeRepo)),
      ],
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
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () async {
      try {
        await PushNotificationService.instance.initialise();
        final _mobileToken = await PushNotificationService.instance.getToken();
        _homeRepo.sendMobileToken(mobileToken: _mobileToken).catchError((e) {
          print("ERROR WHILE SENDING DRVICE Token ID $e");
        });
      } catch (e) {
        print("#Error While Getting Notifications Permission $e");
      }
    });
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    debugPrint('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    debugPrint('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}
