import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/filter/filter_bloc.dart';
import '../bloc/filter/filter_event.dart';
import '../bloc/filter/filter_state.dart';

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            children: [
              _buildFilterButton(
                context,
                label: "Filtros",
                icon: Icons.tune,
                isSelected: state.isPanelOpen,
                onPressed: () => context.read<FilterBloc>().add(ToggleFilterPanel()),
              ),
              _buildFilterButton(
                context,
                label: "Com Desconto",
                isSelected: state.onlyDiscounts,
                onPressed: () => context.read<FilterBloc>().add(ToggleDiscountFilter()),
              ),
              ...state.allFeatures.map((feature) => _buildFilterButton(
                context,
                label: feature,
                isSelected: state.selectedFeatures.contains(feature),
                onPressed: () => context.read<FilterBloc>().add(UpdateSelectedFeatures(feature)),
              )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterButton(
      BuildContext context, {
        required String label,
        bool isSelected = false,
        VoidCallback? onPressed,
        IconData? icon,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.red : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.black),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
