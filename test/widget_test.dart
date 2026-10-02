import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rodham_kinya_karani_portfolio/main.dart';

void main() {
  testWidgets('portfolio renders its main sections and contact details', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final theme = Theme.of(tester.element(find.byType(Scaffold)));
    expect(theme.scaffoldBackgroundColor, const Color(0xFFFAF7F2));
    expect(theme.colorScheme.primary, const Color(0xFF70513D));

    expect(find.text('Rodham Kinya Karani').first, findsOneWidget);
    expect(
      find.text('United Nations Environment Programme (UNEP)'),
      findsOneWidget,
    );
    expect(find.text('Bachelor of Laws (LLB)'), findsOneWidget);
    expect(find.text('Legal research'), findsOneWidget);
    expect(find.text('rodhamkarani@gmail.com'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('mobile navigation opens and scrolls to a portfolio section', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open navigation'));
    await tester.pumpAndSettle();
    expect(find.text('Experience'), findsOneWidget);

    await tester.tap(find.text('Experience'));
    await tester.pumpAndSettle();
    expect(find.text('Judicial Attachment, Mediation Desk'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
