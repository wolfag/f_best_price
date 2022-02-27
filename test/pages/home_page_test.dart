import 'dart:math';

import 'package:f_best_price/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Home page',
    () {
      testWidgets(
        'Show first product name',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: HomePage(),
            ),
          );

          for (var i = 0; i < productList.length; i++) {
            expect(find.text(productList[i].name), findsOneWidget);

            await tester.tap(find.text('Check'));
            await tester.pump();
            await tester.tap(find.text('Next'));
            await tester.pump();
          }

          await tester.tap(find.text('Check'));
          await tester.pump();
          expect(find.text(productList[productList.length - 1].name),
              findsOneWidget);
        },
      );

      testWidgets(
        'Show result after each click',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: HomePage(),
            ),
          );

          expect(find.text('Next'), findsNothing);
          expect(find.byKey(const Key('result')), findsNothing);

          await tester.enterText(find.byKey(const Key('priceInput')), '1');
          await tester.tap(find.text('Check'));
          await tester.pump();

          expect(find.text('Pass'), findsOneWidget);

          await tester.tap(find.text('Next'));
          await tester.pump();

          await tester.enterText(find.byKey(const Key('priceInput')),
              '${productList[1].price + 1}');
          await tester.tap(find.text('Check'));
          await tester.pump();

          expect(find.text('Fail'), findsOneWidget);

          await tester.enterText(find.byKey(const Key('priceInput')), '1');
          await tester.tap(find.text('Check'));
          await tester.pump();

          expect(find.text('Pass'), findsOneWidget);
        },
      );
    },
  );
}
