import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/route/route.dart';
import 'package:todo_app/core/util/color.dart';
import 'package:todo_app/core/util/injection.dart';
import 'package:todo_app/feature/login/page/login_page.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await init();
    locator.isReady<SharedPreferences>().then((value) {
      locator.isReady<Database>().then((value) {
        runApp(MyApp());
      });
    });
  } on Exception catch (e) {
    log("message : $e", name: "main()");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
          useMaterial3: false,
        ).copyWith(
          scaffoldBackgroundColor: secondaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
            foregroundColor: secondaryColor,
            iconSize: 30,
            shape: CircleBorder(),
          ),
          cardTheme: CardThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10.0)
            ),
            color: surfaceColor
          )
        ),
        onGenerateRoute: generateRoute,
        initialRoute: LoginPage.routeName,
      ),
    );
  }
}
