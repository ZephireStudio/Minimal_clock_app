import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_clock/components/windows_utils.dart';
import 'package:minimal_clock/services/settings_provider.dart';
import 'package:minimal_clock/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> with ChangeNotifier{

  @override
  Widget build(BuildContext context) {

    // provider handle for themes (i.e., dark and light)
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeData.brightness == Brightness.dark;

    // provider handle for always on top
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),

      child: Container(
        width: MediaQuery.of(context).size.width * 0.8.r,
        padding: EdgeInsets.all(20.r),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 20.r,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            Divider(),

            SwitchListTile(
              title: Text(
                "Light/Dark Mode",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              value: isDark,
              onChanged: (bool value) {
                themeProvider.toggle();
              },
            ),

            SwitchListTile(
              title: Text(
                'Always on Top Mode (Only for PC 💻)',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              value: settingsProvider.alwaysontop,
              onChanged: (value){
                settingsProvider.toggleAlwaysOnTop(value);
                setWindowsAlwaysonTop(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
