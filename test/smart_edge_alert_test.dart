import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_edge_alert/smart_edge_alert.dart';

void main() {
  testWidgets('SmartEdgeAlert displays correctly at the top',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Home Page')),
        ),
      ),
    );

    SmartEdgeAlert.show(
      tester.element(find.text('Home Page')),
      title: 'Top Alert',
      description: 'This is a top alert',
      gravity: SmartEdgeAlert.top,
    );

    await tester.pump(); // Trigger overlay
    expect(find.text('Top Alert'), findsOneWidget);
    expect(find.text('This is a top alert'), findsOneWidget);
  });

  testWidgets('SmartEdgeAlert displays correctly at the bottom',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Home Page')),
        ),
      ),
    );

    SmartEdgeAlert.show(
      tester.element(find.text('Home Page')),
      title: 'Bottom Alert',
      description: 'This is a bottom alert',
      gravity: SmartEdgeAlert.bottom,
    );

    await tester.pump(); // Trigger overlay
    expect(find.text('Bottom Alert'), findsOneWidget);
    expect(find.text('This is a bottom alert'), findsOneWidget);
  });

  testWidgets('SmartEdgeAlert dismisses after duration',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Home Page')),
        ),
      ),
    );

    SmartEdgeAlert.show(
      tester.element(find.text('Home Page')),
      title: 'Auto Dismiss',
      duration: SmartEdgeAlert.lengthShort,
    );

    await tester.pump();
    expect(find.text('Auto Dismiss'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2)); // Wait for dismiss
    await tester.pump(const Duration(milliseconds: 800)); // Animate out
    expect(find.text('Auto Dismiss'), findsNothing);
  });

  testWidgets('SmartEdgeAlert close button works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Home Page')),
        ),
      ),
    );

    SmartEdgeAlert.show(
      tester.element(find.text('Home Page')),
      title: 'Closable Alert',
    );

    await tester.pump();
    expect(find.text('Closable Alert'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.text('Closable Alert'), findsNothing);
  });
}
