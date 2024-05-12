import 'package:flutter/material.dart';
import 'package:examen_final/widgets/app_bar.dart';
import 'package:examen_final/widgets/menu.dart';
import 'package:examen_final/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Container1(),
          ],
        ),
      ),
    );
  }
}
