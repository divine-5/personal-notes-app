import 'package:flutter_test/flutter_test.dart';
import 'package:personal_notes_app/main.dart';

void main() {
  testWidgets('Personal Notes app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const PersonalNotesApp());

    expect(find.text('Welcome Back'), findsOneWidget);
  });
}