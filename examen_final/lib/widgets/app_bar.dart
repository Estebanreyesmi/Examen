import 'package:flutter/material.dart';

import 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 72, 75, 80),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              size: 36,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      flexibleSpace: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      ),
    );
  }
}
