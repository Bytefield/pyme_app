import 'package:flutter/material.dart';
import 'package:pyme_app/screen_controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(context) {
    return const ScreenController();
  }
}
