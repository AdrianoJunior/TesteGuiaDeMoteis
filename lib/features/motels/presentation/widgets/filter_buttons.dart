import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ['Filtros', 'Com Desconto', 'Disponíveis'].map((text) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(text),
            ),
          );
        }).toList(),
      ),
    );
  }
}
