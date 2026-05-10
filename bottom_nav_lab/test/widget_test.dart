import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bottom_nav_lab/main.dart';

void main() {
  testWidgets('Bottom navigation and screen switching test', (WidgetTester tester) async {
    await tester.pumpWidget(const BottomNavApp());

    expect(find.text('Bottom Navigation Demo'), findsOneWidget);
    expect(find.text('Go to Details'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    expect(find.text('Your favorite items appear here.'), findsOneWidget);
    expect(find.text('Go to Details'), findsNothing);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();

    expect(find.text('Alex Johnson'), findsOneWidget);
    expect(find.text('Flutter Developer'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();

    await tester.tap(find.text('Go to Details'));
    await tester.pumpAndSettle();

    expect(find.text('Details'), findsOneWidget);
    expect(find.text('Go Back'), findsOneWidget);

    await tester.tap(find.text('Go Back'));
    await tester.pumpAndSettle();

    expect(find.text('Go to Details'), findsOneWidget);
  });
}