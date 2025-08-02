import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetsUtil {
  static buildMaterialAppWidgetTest({
    required Widget child,
    required WidgetTester tester,
  }) {
    const baseColor = Color.fromARGB(255, 236, 185, 57);
    _setupDeviceConstraintsForSnapshotTests(tester);

    return MaterialApp(
      home: child,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: baseColor,
        ),
        useMaterial3: true,
      ),
    );
  }

  static _setupDeviceConstraintsForSnapshotTests(WidgetTester tester) {
    tester.view.physicalSize = const Size(300, 600);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
    });
  }
}
