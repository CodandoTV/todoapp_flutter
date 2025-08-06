import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetsUtil {
  static buildMaterialAppWidgetTest({
    required Widget child,
    required WidgetTester tester,
  }) async {
    await _loadFont();

    TestWidgetsFlutterBinding.ensureInitialized();

    const baseColor = Color.fromARGB(255, 239, 232, 215);
    _setupDeviceConstraintsForSnapshotTests(tester);

    return MaterialApp(
      home: child,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: baseColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }

  static _loadFont() async {
    final fonts = [
      'fonts/Roboto-Regular.ttf',
      'fonts/Roboto-SemiBold.ttf',
      'fonts/Roboto-SemiBoldItalic.ttf',
      'fonts/Roboto-Thin.ttf',
      'fonts/Roboto-ThinItalic.ttf',
    ];
    final fontLoader = FontLoader('Roboto');
    for (final font in fonts) {
      final fontData = await rootBundle.load(font);
      fontLoader.addFont(Future.value(fontData));
    }
    await fontLoader.load();
  }

  static _setupDeviceConstraintsForSnapshotTests(WidgetTester tester) {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
    });
  }
}
