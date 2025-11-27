import 'package:flutter/material.dart';
import 'package:salary_clean_architecture/presentation/views/main_screen.dart';

class AppRoutes {
  static const home = '/';

  static Map<String, WidgetBuilder> routes = {home: (_) => const MainScreen()};
}
