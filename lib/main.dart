import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'package:http/http.dart' as http;
import 'features/motels/presentation/bloc/motel_bloc.dart';
import 'features/motels/presentation/bloc/motel_event.dart';
import 'features/motels/presentation/pages/motel_list_page.dart';
import 'core/network/http_api_client.dart';

void main() {
  // Inicializa o cliente HTTP para realizar requisições à API
  final apiClient = HttpApiClient(client: http.Client());

  // Cria o repositório responsável por intermediar a comunicação com a API
  final motelRepository = MotelRepository(apiClient: apiClient);

  // Define o caso de uso que obtém a lista de motéis do repositório
  final getMotelsUseCase = GetMotelsUseCase(motelRepository);

  // Inicializa o aplicativo com um BlocProvider para gerenciar o estado global do MotelBloc
  runApp(
    BlocProvider(
      create: (_) => MotelBloc(getMotelsUseCase: getMotelsUseCase)..add(FetchMotels()), // Dispara o evento para carregar motéis ao iniciar
      child: MyApp(),
    ),
  );
}

/// Classe principal do aplicativo, configurando o tema e a navegação inicial.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia de Motéis',
      home: MotelListPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xe6ffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
