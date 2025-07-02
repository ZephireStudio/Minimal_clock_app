import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

void setWindowsAlwaysonTop(bool enable){
  final windowTitle = TEXT("clock_app");
  var hwnd  = FindWindow(nullptr, windowTitle);

  // if (hwnd == 0){
  //   final classname = TEXT('FLUTTER_RUNNER_WIN32_WINDOW');
  //   hwnd = FindWindow(classname, nullptr);
  // }

  if(hwnd != 0){
    // USe final resutl = for debug
    SetWindowPos(
      hwnd,
      enable? HWND_TOPMOST : HWND_NOTOPMOST,
      0,
      0,
      0,
      0,
      SWP_NOMOVE | SWP_NOSIZE,
    );
    
  // F O R  D E B U G  R E A S O N

  //   print('SetWindowPos result: $result');
  //   if(result == 0){
  //     final error = GetLastError();
  //     print('windows Error code: $error');
  // } else {
  //   print('Window Handle not found');
  // }
  }
}