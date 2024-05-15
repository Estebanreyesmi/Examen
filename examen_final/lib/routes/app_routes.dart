import 'package:examen_final/screen/add_category.dart';
import 'package:examen_final/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:examen_final/screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'list': (BuildContext context) => const ListProductScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'cat': (BuildContext context) => const ListCategoriaScreen(),
    'editcat': (BuildContext context) => AgregarCategoriaScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
