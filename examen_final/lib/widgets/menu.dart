import 'package:flutter/material.dart';
import 'package:examen_final/screen/screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ExpansionTile(
            title: Text('Administrador'),
            children: [
              ListTile(
                title: Text('Proveedores'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListProductScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('Categorias'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListCategoryScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('Productos'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListProductScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
