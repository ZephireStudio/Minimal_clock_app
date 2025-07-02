import 'package:flutter/material.dart';
import 'package:minimal_clock/pages/settings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.menu_book, size: 60, color: ColorScheme.of(context).onSurface,),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home_filled),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const SettingsDialog(),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Other clock faces'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/other-themes');
                  },
                ),

                ListTile(
                  leading: Icon(Icons.timer),
                  title: Text("StopWatch"),
                  onTap: () {
                    // Navigate to timer
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/Timer');
                  },
                ),

                ListTile(
                  leading: Icon(Icons.hourglass_empty),
                  title: Text("Pomodoro Timer"),
                  onTap: () {
                    // Navigate to timer
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/Pomo');
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}