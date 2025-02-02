import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_monday/firebase_options.dart';
import 'package:todo_c13_monday/providers/my_provider.dart';
import 'package:todo_c13_monday/providers/user_provider.dart';
import 'package:todo_c13_monday/screens/add_events/add_events.dart';
import 'package:todo_c13_monday/screens/forget_password.dart';
import 'package:todo_c13_monday/screens/home/home.dart';
import 'package:todo_c13_monday/screens/intro_screen.dart';
import 'package:todo_c13_monday/screens/login.dart';
import 'package:todo_c13_monday/screens/register.dart';
import 'package:todo_c13_monday/theme/base_theme.dart';
import 'package:todo_c13_monday/theme/dark_theme.dart';
import 'package:todo_c13_monday/theme/lgiht_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);

    return true;
  };
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provier = Provider.of<MyProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    BaseTheme theme = LightTheme();
    BaseTheme darkTheme = DarkTheme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme.themeData,
      darkTheme: darkTheme.themeData,
      themeMode: provier.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: userProvider.firebaseUser != null
          ? HomeScreen.routeName
          : IntroductionScreen.routeName,
      routes: {
        IntroductionScreen.routeName: (context) => const IntroductionScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddEventsScreen.routeName: (context) => AddEventsScreen(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
      },
    );
  }
}
