import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/features/motels/data/models/pricing_model.dart';

void main() {
  group('PricingModel', () {
    test('Deve mapear JSON corretamente para PricingModel incluindo desconto', () {
      // JSON de exemplo com desconto aplicado
      final json = {
        "tempoFormatado": "3 horas",
        "valorTotal": 129.0,
        "desconto": {"desconto": 108.0} // Valor total com desconto aplicado
      };

      final pricing = PricingModel.fromJson(json);

      expect(pricing.formattedTime, "3 horas"); // Tempo correto
      expect(pricing.totalValue, 129.0); // Valor total correto
      expect(pricing.discount, 108.0); // Valor final com desconto aplicado
    });

    test('Deve lidar corretamente com JSON sem campo de desconto', () {
      // JSON sem desconto informado
      final json = {
        "tempoFormatado": "2 horas",
        "valorTotal": 99.0
      };

      final pricing = PricingModel.fromJson(json);

      expect(pricing.formattedTime, "2 horas"); // Tempo correto
      expect(pricing.totalValue, 99.0); // Valor total correto
      expect(pricing.discount, isNull); // Se não há desconto, deve ser null
    });

    test('Deve lidar corretamente com JSON contendo valores nulos', () {
      // JSON com valores nulos
      final json = {
        "tempoFormatado": null,
        "valorTotal": null,
        "desconto": null
      };

      final pricing = PricingModel.fromJson(json);

      expect(pricing.formattedTime, ''); // Deve retornar string vazia
      expect(pricing.totalValue, 0.0); // Deve retornar 0.0 para evitar erros
      expect(pricing.discount, isNull); // Deve continuar null
    });
  });
}
