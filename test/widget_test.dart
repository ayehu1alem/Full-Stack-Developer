import 'package:flutter_test/flutter_test.dart';
import 'package:ayehu_portfolio/main.dart';

void main() {
  testWidgets('portfolio displays headline and key sections', (tester) async {
    await tester.pumpWidget(const AlemayehuPortfolioApp());

    expect(find.textContaining('Building digital'), findsOneWidget);
    expect(find.text('WHAT I BRING'), findsOneWidget);
    expect(find.text('SELECTED WORK'), findsOneWidget);
  });
}
