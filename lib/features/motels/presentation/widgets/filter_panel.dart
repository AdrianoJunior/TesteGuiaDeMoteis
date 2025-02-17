import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_event.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_state.dart';

class FilterPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        bool isButtonEnabled = state.selectedFeatures.isNotEmpty ||
            state.selectedPeriods.isNotEmpty ||
            state.onlyDiscounts ||
            state.onlyAvailable ||
            state.minPrice > 30 ||
            state.maxPrice < 2030;

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: state.isPanelOpen ? 0 : -MediaQuery.of(context).size.height,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, -2)),
              ],
            ),
            child: DraggableScrollableSheet(
              expand: true,
              initialChildSize: 0.90,
              minChildSize: 0.5,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              context.read<FilterBloc>().add(ToggleFilterPanel());
                            },
                            child: const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text("Faixa de Preço", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),

                        SfRangeSlider(
                          min: 30.0,
                          max: 2030.0,
                          values: SfRangeValues(state.minPrice.toDouble(), state.maxPrice.toDouble()),
                          interval: 500,
                          stepSize: 1,
                          showLabels: true,
                          showTicks: true,
                          activeColor: Colors.red,
                          inactiveColor: Colors.grey[300],
                          onChanged: (SfRangeValues values) {
                            context.read<FilterBloc>().add(UpdatePriceFilter(
                              minPrice: values.start.round(),
                              maxPrice: values.end.round(),
                            ));
                          },
                        ),
                        SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "R\$ ${state.minPrice}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ ${state.maxPrice}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        const Text("Períodos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            for (String period in state.allPeriods)
                              GestureDetector(
                                onTap: () {
                                  context.read<FilterBloc>().add(UpdateSelectedPeriods(period));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: state.selectedPeriods.contains(period) ? Colors.red : Colors.grey,
                                    ),
                                    color: state.selectedPeriods.contains(period) ? Colors.red : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    period,
                                    style: TextStyle(
                                      color: state.selectedPeriods.contains(period) ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        const Text("Itens da Suíte", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: state.allFeatures.map((feature) {
                            return GestureDetector(
                              onTap: () {
                                context.read<FilterBloc>().add(UpdateSelectedFeatures(feature));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: state.selectedFeatures.contains(feature) ? Colors.red : Colors.grey,
                                  ),
                                  color: state.selectedFeatures.contains(feature) ? Colors.red : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    color: state.selectedFeatures.contains(feature) ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 16),

                        SwitchListTile(
                          value: state.onlyDiscounts,
                          onChanged: (value) {
                            context.read<FilterBloc>().add(ToggleDiscountFilter());
                          },
                          title: const Text("Somente suítes com desconto", style: TextStyle(fontSize: 16)),
                        ),

                        const SizedBox(height: 16),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isButtonEnabled ? Colors.red : Colors.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: isButtonEnabled
                              ? () {
                            context.read<FilterBloc>().add(ApplyFilters(context: context));
                          }
                              : null,
                          child: const Center(
                            child: Text("Verificar Disponibilidade", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
