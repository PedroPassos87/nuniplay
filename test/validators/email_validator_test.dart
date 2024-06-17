import 'package:flutter_test/flutter_test.dart';

class EmailValidator {
  String? validate({String? email}) {
    if (email == null || email.isEmpty) {
      //se email é nulo ou vazio -> invalido
      return 'Email ou senha invalidos';
    }

    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); //formataçao do email
    if (!emailRegex.hasMatch(email)) {
      //se email nao estiver no formato -> invalido
      return 'Email ou senha invalidos';
    }

    //se nao cair em nenhum dos erros retorna null
    return null;
  }
}

void main() {
  late EmailValidator
      emailValidator; //late pois se repetira em mais de um teste

  setUp(() {
    //setup é feito antes de qualquer teste, similar ao beforeEach do cypress
    emailValidator = EmailValidator();
  });

  group('validação do email', () {
    test('deve retornar erro caso campo seja nulo', () {
      final result = emailValidator.validate();

      expect(result,
          equals('Email ou senha invalidos')); // o que se espera receber
    });

    test('deve retornar erro caso campo seja vazio', () {
      final result = emailValidator.validate(email: '');

      expect(result,
          equals('Email ou senha invalidos')); // o que se espera receber
    });

    test('deve retornar erro caso campo seja invalido', () {
      final result = emailValidator.validate(email: 'testeemail');

      expect(result,
          equals('Email ou senha invalidos')); // o que se espera receber
    });

    test('deve retornar null caso campo seja valido', () {
      final result = emailValidator.validate(email: 'testeemail@teste.com');

      expect(result, isNull); // o que se espera receber
    });
  });
}
