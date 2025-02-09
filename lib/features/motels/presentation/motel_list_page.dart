import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_state.dart';
import 'package:guia_moteis/features/motels/presentation/widgets/filter_buttons.dart';
import 'package:guia_moteis/features/motels/presentation/widgets/motel_view.dart';
import 'package:guia_moteis/features/motels/presentation/widgets/location_selector.dart';

class MotelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent, // Background behind the main content
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // White Rounded Body Background
          Positioned.fill(
            top: 80, // Adjusts the start position below the LocationSelector
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20), // Rounded top effect
                ),
              ),
            ),
          ),

          Column(
            children: [
              const LocationSelector(),
              Expanded(
                child: Column(
                  children: [
                    FilterButtons(),
                    Expanded(
                      child: BlocBuilder<MotelBloc, MotelState>(
                        builder: (context, state) {
                          if (state is MotelLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is MotelLoaded) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 80),
                              // Leaves space for floating button
                              itemCount: state.motels.length,
                              itemBuilder: (context, index) {
                                return MotelView(motel: state.motels[index]);
                              },
                            );
                          } else if (state is MotelError) {
                            return Center(child: Text(state.message));
                          } else {
                            return const Center(
                                child: Text('Nenhum dado encontrado'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Floating "Mapa" Button
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.transparent, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.map, size: 20, color: Colors.red),
                      const SizedBox(width: 8),
                      const Text(
                        'Mapa',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
