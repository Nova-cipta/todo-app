import 'package:flutter/material.dart';
import 'package:todo_app/feature/home/page/home_page.dart';
import 'package:todo_app/feature/login/page/login_page.dart';

Route<Object?> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginPage()
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => HomePage(name: settings.arguments.toString())
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Route Not Found")
          )
        )
      );
  }
}