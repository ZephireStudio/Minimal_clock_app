import 'package:flutter/material.dart';
import 'package:minimal_clock/services/theme_provider.dart';
import 'package:provider/provider.dart';

class Buttons extends StatefulWidget {
  final Color? color;
  final void Function()? onTap;

  const Buttons({super.key, required this.color, required this.onTap});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isDark = context.read<ThemeProvider>().themeData.brightness == Brightness.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    _isDark = themeProvider.themeData.brightness == Brightness.dark;

    return Switch.adaptive(
      value: _isDark,
      onChanged: (bool value) {
        setState(() {
          _isDark = value;
        });
        themeProvider.toggle();
      },
      activeColor: widget.color,
      activeTrackColor: widget.color?.withOpacity(0.5),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.withOpacity(0.5),
    );
  }
}