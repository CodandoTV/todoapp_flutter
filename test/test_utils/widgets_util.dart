import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

class WidgetsUtil {
  static Widget buildMaterialAppWidgetTest({
    required Widget child,
    required WidgetTester tester,
  }) {
    TestWidgetsFlutterBinding.ensureInitialized();

    const baseColor = Color.fromARGB(255, 239, 232, 215);

    return MaterialApp(
      home: child,
      themeMode: ThemeMode.dark,
      // Forcing en-US because our unit tests are using english words
      locale: const Locale('en'),
      // Required to load the localizations to avoid null pointer
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: baseColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}
