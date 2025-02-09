import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/features/motels/data/models/suite_model.dart';

void main() {
  final json = {
    "nome": "Suíte Marselha Sexy",
    "qtd": 1,
    "exibirQtdDisponiveis": true,
    "fotos": ["https://cdn.guiademoteis.com.br/Images/moteis/3148-Motel-Le-Nid/suites/17418-Marselha-Sexy/fotos/64838168-0e40-4087-bc99-445ee4a0754b-suites.jpg"],
    "itens": [{"nome": "TV a cabo"}, {"nome": "som AM/FM"}],
    "categoriaItens": [{"nome": "Frigobar", "icone": "https://cdn.guiademoteis.com.br/Images/itens-suites/frigobar-04-09-2018-12-14.png"}],
    "periodos": [{"tempoFormatado": "3 horas", "valorTotal": 129.0}]
  };

  test('should correctly map real JSON to SuiteModel', () {
    final suite = SuiteModel.fromJson(json);

    expect(suite.name, "Suíte Marselha Sexy");
    expect(suite.photos.length, greaterThan(0));
    expect(suite.features.first, "TV a cabo");
    expect(suite.pricing.first.formattedTime, "3 horas");
    expect(suite.pricing.first.totalValue, 129.0);
  });
}
