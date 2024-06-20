import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lab5/main.dart' as app;

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("full app test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      //phone login page test
      final phoneFormField = find.byKey(const Key("phone1"));
      final phoneCheckBox = find.byType(Checkbox).first;
      final loginButton = find.byType(ElevatedButton).first;

      await tester.enterText(phoneFormField, "1234567890");
      await tester.tap(phoneCheckBox);
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      //otp page test
      final otpFormField = find.byKey(const Key("otp"));
      final otpButton = find.byType(ElevatedButton).first;

      await tester.enterText(otpFormField, "123456");
      await tester.pumpAndSettle();
      await tester.tap(otpButton);
      await tester.pumpAndSettle();

      //nav button test
      final personIcon = find.byKey(const Key("person_icon"));
      final homeIcon = find.byKey(const Key("home_icon"));
      final settingsIcon = find.byKey(const Key("settings_icon"));
      final factory1 = find.byKey(const Key("factory1"));
      final factory2 = find.byKey(const Key("factory2"));

      await tester.tap(homeIcon);
      await tester.pumpAndSettle();
      await tester.tap(factory1);
      await tester.pumpAndSettle();
      await tester.tap(factory2);
      await tester.pumpAndSettle();
      await tester.tap(settingsIcon);
      await tester.pumpAndSettle();
      await tester.tap(factory1);
      await tester.pumpAndSettle();
      await tester.tap(factory2);
      await tester.pumpAndSettle();
      await tester.tap(personIcon);
      await tester.pumpAndSettle();
      await tester.tap(factory1);
      await tester.pumpAndSettle();
      await tester.tap(factory2);
      await tester.pumpAndSettle();

      //home page test
      final addButton = find.byKey(const Key("add_button"));

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      final nameFormField = find.byKey(const Key("name"));
      final phone2FormField = find.byKey(const Key("phone2"));
      final submitButton = find.byType(ElevatedButton).first;
      final backButton = find.byIcon(Icons.arrow_back);

      await tester.enterText(nameFormField, "Test");
      await tester.enterText(phone2FormField, "1234567890");
      await tester.pumpAndSettle();
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      await tester.tap(backButton);
      await tester.pumpAndSettle();
    });
  });
}
