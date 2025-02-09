import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_state.dart';
import 'package:guia_moteis/features/motels/presentation/widgets/filter_buttons.dart';
import 'package:guia_moteis/features/motels/presentation/widgets/motel_view.dart';
import 'package:guia_moteis/features/motels/presentation/widgets/location_selector.dart';

/// Página responsável por exibir a lista de motéis com filtros e carregamento dinâmico usando BLoC.
class MotelListPage extends StatelessWidget {
  const MotelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Fundo branco com bordas arredondadas na parte superior
          Positioned.fill(
            top: 80, // Posicionamento abaixo do seletor de localização
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ),

          Column(
            children: [
              const LocationSelector(),
              // Componente para seleção de localização (mock)
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    FilterButtons(), // Botões de filtro da listagem (não implementado, apenas mock)
                    Expanded(
                      child: BlocBuilder<MotelBloc, MotelState>(
                        builder: (context, state) {
                          if (state is MotelLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is MotelLoaded) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 80),
                              // Espaço para o botão do Mapa
                              itemCount: state.motels.length,
                              itemBuilder: (context, index) {
                                // Exibe cada motel
                                return MotelView(motel: state.motels[index]);
                              },
                            );
                          } else if (state is MotelError) {
                            return Center(child: Text(state.message));
                          }
                          return const Center(
                              child: Text('Nenhum dado encontrado'));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Botão flutuante "Mapa"
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: const Offset(0, 2)),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: InkWell(
                  onTap: () {
                    // Ação ao clicar no botão (ainda não implementada)
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.map, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'Mapa',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói a AppBar com botões para selecionar o dia da visita ao motel.
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.red,
      title: Row(
        children: [
          _buildRoundedButton(Icons.flash_on, 'Ir Agora', isActive: true),
          const SizedBox(width: 10),
          _buildRoundedButton(Icons.calendar_today, 'Ir Outro Dia'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildRoundedButton(IconData icon, String text,
      {bool isActive = false}) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: isActive ? Colors.red : Colors.grey),
      label: Text(
        text,
        style: TextStyle(color: isActive ? Colors.red : Colors.grey),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
