import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie_booking_app/main.dart';

void main() {
  testWidgets('Home screen shows movie list', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieBookingApp());

    expect(find.text('Now Showing'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}
