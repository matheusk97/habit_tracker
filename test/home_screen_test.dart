import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/views/home_screen.dart';
import 'package:habit_tracker/providers/habit_provider.dart';
import 'package:habit_tracker/models/habit_model.dart';

void main() {
  testWidgets('deve adicionar um novo hábito', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HabitProvider()),
        ],
        child: MaterialApp(
          home: HomeScreen(userName: '1'),
        ),
      ),
    );

    // Verifica o estado inicial
    expect(find.text('Hábitos Pendentes (0)'), findsOneWidget);
    expect(find.text('Hábitos Completos (0)'), findsOneWidget);

    // Clica no botão +
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Preenche os dados do novo hábito
    await tester.enterText(find.byType(TextField).first, 'Test Hábito');
    await tester.enterText(find.byType(TextField).last, 'Test Descrição');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    // Verifica se o novo hábito foi adicionado
    expect(find.text('Test Hábito'), findsOneWidget);
    expect(find.text('Test Descrição'), findsOneWidget);
    expect(find.text('Hábitos Pendentes (1)'), findsOneWidget);
  });
}