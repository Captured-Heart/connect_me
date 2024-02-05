import 'dart:math';

import 'package:connect_me/app.dart';
import 'package:connect_me/src/utils/create_app_widet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final newProfileScreen = find.byType(NewProfileScreen);
  testWidgets('text on appBar_title', (widgetTester) async {
    await widgetTester.pumpWidget(
        createAppRoot(child: const DefaultTabController(length: 3, child: NewProfileScreen())));

await widgetTester.pump();
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('Check for the new profile page', (widgetTester) async {
    await widgetTester.pumpWidget(createAppRoot(child: const NewProfileScreen()));

    expect(newProfileScreen, findsWidgets);
  });
}


