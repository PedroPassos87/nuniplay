import 'package:flutter_test/flutter_test.dart';

class SenhaValidator {
  String? validate({String? senha}) {
    if (senha == null || senha.isEmpty) {
      //se email é nulo ou vazio -> invalido
      return 'Email ou senha invalidos';
    }
    if (senha.length < 5) {
      //se email é nulo ou vazio -> invalido
      return 'Email ou senha invalidos';
    }

    //se nao cair em nenhum dos erros retorna null
    return null;
  }
}

void main() {
  late SenhaValidator
      senhaValidator; //late pois se repetira em mais de um teste

  setUp(() {
    //setup é feito antes de qualquer teste, similar ao beforeEach do cypress
    senhaValidator = SenhaValidator();
  });

  group('validação da senha', () {
    test('deve retornar erro caso campo seja nulo', () {
      final result = senhaValidator.validate();

      expect(result,
          equals('Email ou senha invalidos')); // o que se espera receber
    });

    test('deve retornar erro caso campo seja vazio', () {
      final result = senhaValidator.validate(senha: '');

      expect(result,
          equals('Email ou senha invalidos')); // o que se espera receber
    });

    test('deve retornar erro caso campo seja invalido (menor que 5 caracteres)',
        () {
      final result = senhaValidator.validate(senha: '123');

      expect(result,
          equals('Email ou senha invalidos')); // o que se espera receber
    });

    test('deve retornar null caso campo seja valido', () {
      final result = senhaValidator.validate(senha: 'senhaboa');

      expect(result, isNull); // o que se espera receber
    });
  });
}
