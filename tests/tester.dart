import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:tableapptest/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Delivery Data', () {
    testWidgets('Get Delivery Data by Time',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byKey(Key('RefreshButton')), findsOneWidget);

      final Finder refreshBtn = find.byKey(Key('RefreshButton'));

      final Finder dateBtn = find.byKey(Key('DateButton'));

      expect(find.text("6 minutes 37 seconds"), findsOneWidget);

      await tester.tap(dateBtn);

      await tester.pumpAndSettle();

      final Finder date = find.text("10");
      await tester.tap(date);

      await tester.pumpAndSettle();

      final Finder submitDateBtn = find.text("OK");
      await tester.tap(submitDateBtn);

      await tester.pumpAndSettle();

      await tester.tap(refreshBtn);
      await tester.pumpAndSettle();
      await Future.delayed(Duration(milliseconds: 1500));

      expect(find.text("6 minutes 37 seconds"), findsNothing);

      expect(find.text("7 minutes 08 seconds"), findsOneWidget);

    });
  });
}