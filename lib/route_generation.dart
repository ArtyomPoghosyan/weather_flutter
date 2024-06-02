import 'package:flutter/material.dart';
import 'package:wheather/screen/welcome.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (builder) => Welcome());
      default:
        return ErrorRoute();
    }
  }
}

Route ErrorRoute() {
  return MaterialPageRoute(builder: (builder) {
    return Scaffold(
      body: Text("Page not found"),
    );
  });
}
