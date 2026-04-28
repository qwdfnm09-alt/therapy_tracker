import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:premarital_match/app.dart';
import 'package:premarital_match/data/local/local_storage_service.dart';
import 'package:premarital_match/presentation/providers/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows splash brand name', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(storage)..initialize(),
        child: const PreMaritalMatchApp(),
      ),
    );

    expect(find.text('PreMarital Match'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
  });
}
