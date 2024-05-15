import 'package:examen_final/screen/add_category.dart';
import 'package:examen_final/screen/add_proveedores.dart';
import 'package:examen_final/screen/edit_proveedor.dart';
import 'package:examen_final/screen/home_screen.dart';
import 'package:examen_final/screen/list_proveedores.dart';
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
    'addcat': (BuildContext context) => AgregarCategoriaScreen(),
    'editcat': (BuildContext context) => const EditCategoriaScreen(),
    'prov': (BuildContext context) => const ListProveedorScreen(),
    'addprov': (BuildContext context) => AgregarProveedorScreen(),
    'editprov': (BuildContext context) => EditProveedorScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
