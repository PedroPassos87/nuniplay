// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uniplay/pages/home_page.dart';
import 'package:uniplay/pages/login_page.dart';

void main() {
  group('teste dos campos de texto', () {
    testWidgets('campo de email aparece na tela', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: LoginPage(
            onTap: () {},
          ),
        ),
      );

      final emailKey = find.byKey(Key('email_key')); //achar widget
      expect(emailKey,
          findsOneWidget); //verifica se apenas uma widget como email esta na tela
    });

    testWidgets('campo de senha aparece na tela', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: LoginPage(
            onTap: () {},
          ),
        ),
      );

      final passwordKey = find.byKey(Key('senha_key')); //achar widget
      expect(passwordKey,
          findsOneWidget); //verifica se apenas uma widget como email esta na tela
    });
  });

  group(
    'teste do botao sign in',
    () {
      group(
        'teste do botão de sign in',
        () {
          testWidgets('botão de sign in aparece na tela',
              (WidgetTester tester) async {
            await tester.pumpWidget(
              MaterialApp(
                home: LoginPage(
                  onTap: () {},
                ),
              ),
            );

            final signInButton = find
                .byKey(Key('sign_in_button')); // encontrar o widget do botão
            expect(signInButton,
                findsOneWidget); // verificar se apenas um botão de sign in está na tela
          });

          testWidgets('inserir dados corretos', (widgetTester) async {
            await widgetTester.pumpWidget(
              MaterialApp(
                home: LoginPage(
                  onTap: () {},
                ),
              ),
            );

            final emailField = find.byKey(Key('email_key')); //achar widget
            expect(emailField,
                findsOneWidget); //verifica se apenas uma widget como email esta na tela

            await widgetTester.tap(emailField); //tocou no campo
            await widgetTester.pumpAndSettle(); //esperar animaçoes

            await widgetTester.enterText(emailField, "peagacarreira@gmail.com");
            await widgetTester.pumpAndSettle();

            final passwordField = find.byKey(Key('senha_key')); //achar widget

            await widgetTester.tap(passwordField); //tocou no campo
            await widgetTester.pumpAndSettle(); //esperar animaçoes

            await widgetTester.enterText(passwordField, "bilbo123");
            await widgetTester.pumpAndSettle();

            final signInButton = find.byKey(Key('sign_in_button'));
            await widgetTester.press(signInButton);

            expect(find.text('Sign in'), findsOneWidget);
          });
        },
      );
    },
  );
}
