import 'package:minimal_clock/components/drawer.dart';
import 'package:minimal_clock/pages/other_themes/defaulttheme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ColorScheme.of(context).background,
      // ),
      drawer: AppDrawer(),

      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: Builder(builder: (context)=> IconButton(onPressed: () =>Scaffold.of(context).openDrawer(), icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface,)))),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Time Display
                  const StaticTimeDisplay()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}