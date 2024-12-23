import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_monday/providers/my_provider.dart';
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
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
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
      initialRoute: IntroductionScreen.routeName,
      routes: {
        IntroductionScreen.routeName: (context) =>const IntroductionScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RigisterScreen.routeName: (context) => RigisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
      },
    );
  }
}
