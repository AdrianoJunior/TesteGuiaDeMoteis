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

  test('should correctly map real JSON to MotelModel', () {
    final motel = MotelModel.fromJson(json);

    expect(motel.name, "Motel Le Nid");
    expect(motel.logo, "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif");
    expect(motel.neighborhood, "Chácara Flora - São Paulo");
    expect(motel.distancia, 28.27);

  });
}
