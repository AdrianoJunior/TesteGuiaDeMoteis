import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/features/motels/data/models/motel_model.dart';

void main() {
  final json = {
    "fantasia": "Motel Le Nid",
    "logo": "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif",
    "bairro": "Chácara Flora - São Paulo",
    "distancia": 28.27,
    "suites": []
  };

  test('Deve mapear JSON corretamente para um MotelModel', () {
    final motel = MotelModel.fromJson(json);

    expect(motel.name, "Motel Le Nid"); // Nome do motel
    expect(motel.logo, "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif"); // Logo do motel
    expect(motel.neighborhood, "Chácara Flora - São Paulo"); // Bairro do motel
    expect(motel.distancia, 28.27); // Distância fornecida pela API
  });
}
