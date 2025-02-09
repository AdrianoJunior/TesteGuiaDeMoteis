/// Define um contrato para classes que implementam chamadas HTTP.
abstract class ApiClient {
  /// Realiza uma requisição HTTP do tipo GET para a URL fornecida.
  /// Retorna um `Future<dynamic>`, permitindo que a implementação
  /// decida como processar e retornar os dados.
  Future<dynamic> get(String url);
}
