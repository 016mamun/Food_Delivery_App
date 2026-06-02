import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FoodDeliveryApp()));
    await tester.pump();
    expect(find.text('Food Delivery'), findsOneWidget);
  });
}
