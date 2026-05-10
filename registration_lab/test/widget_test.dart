import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_lab/main.dart'; // Ensure this matches your project name

void main() {
  testWidgets('Registration form validation and success test', (WidgetTester tester) async {
    // 1. Load the app
    await tester.pumpWidget(const RegistrationApp());

    // 2. Define our finders
    final nameField = find.widgetWithText(TextFormField, 'Full Name');
    final emailField = find.widgetWithText(TextFormField, 'Email');
    final passwordField = find.widgetWithText(TextFormField, 'Password');
    final confirmField = find.widgetWithText(TextFormField, 'Confirm Password');
    final registerButton = find.widgetWithText(ElevatedButton, 'Register');

    // 3. Test Validation: Try to submit empty form
    await tester.tap(registerButton);
    await tester.pump(); // Rebuild to show error messages

    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter an email'), findsOneWidget);

    // 4. Fill in the form
    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'john@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.enterText(confirmField, 'password123');

    // 5. Submit the form
    await tester.tap(registerButton);
    await tester.pumpAndSettle(); // Wait for the Dialog animation to finish

    // 6. Verify success dialog appears
    expect(find.text('Registration Successful'), findsOneWidget);
    expect(find.text('Welcome, John Doe!'), findsOneWidget);

    // 7. Close the dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Registration Successful'), findsNothing);
  });

  testWidgets('Password mismatch validation test', (WidgetTester tester) async {
    await tester.pumpWidget(const RegistrationApp());

    // Fill passwords that don't match
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '123456');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), '654321');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pump();

    // Check for error message
    expect(find.text('Passwords do not match'), findsOneWidget);
  });
}