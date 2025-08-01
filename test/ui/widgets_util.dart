import 'package:flutter/material.dart';

class WidgetsUtil {
  static buildMaterialAppWidgetTest({
    required Widget child,
  }) {
    const baseColor = Color.fromARGB(255, 236, 185, 57);
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: baseColor,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto'),
    );
  }
}
