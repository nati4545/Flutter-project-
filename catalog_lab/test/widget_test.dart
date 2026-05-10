import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  testWidgets('Catalog displays products and responds to taps', (WidgetTester tester) async {
    await tester.pumpWidget(const CatalogApp());

    expect(find.text('Catalog'), findsOneWidget);

    expect(find.text('Coffee Mug'), findsOneWidget);
    expect(find.text('\$12.99'), findsOneWidget);
    expect(find.text('Notebook'), findsOneWidget);

    await tester.tap(find.text('Coffee Mug'));
    await tester.pump(); 

    expect(find.text('You selected Coffee Mug'), findsOneWidget);

    expect(find.text('Backpack'), findsOneWidget);
    expect(find.text('\$49.99'), findsOneWidget);
  });
}