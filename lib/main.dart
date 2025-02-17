import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_event.dart';
import 'package:http/http.dart' as http;
import 'features/motels/presentation/pages/motel_list_page.dart';
import 'core/network/http_api_client.dart';

void main() {
  final apiClient = HttpApiClient(client: http.Client());

  final motelRepository = MotelRepository(apiClient: apiClient);

  final getMotelsUseCase = GetMotelsUseCase(motelRepository);

  runApp(MyApp(getMotelsUseCase: getMotelsUseCase));
}

class MyApp extends StatelessWidget {
  final GetMotelsUseCase getMotelsUseCase;

  const MyApp({super.key, required this.getMotelsUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilterBloc>(
          create: (context) => FilterBloc(),
        ),
        BlocProvider<MotelBloc>(
          create: (context) => MotelBloc(
            getMotelsUseCase: getMotelsUseCase,
            filterBloc: context.read<FilterBloc>(),
          )..add(FetchMotels()),
        ),
      ],
      child: MaterialApp(
        title: 'Guia de Motéis',
        home: const MotelListPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xe6ffffff),
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
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
      ),
    );
  }
}
