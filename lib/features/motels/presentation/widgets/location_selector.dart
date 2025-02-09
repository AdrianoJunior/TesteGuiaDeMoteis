import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({Key? key}) : super(key: key);

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final List<String> locations = ['Zona Norte', 'Zona Sul', 'Zona Leste', 'Zona Oeste'];
  String selectedLocation = 'Zona Norte';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedLocation,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedLocation = newValue;
                });
              }
            },
            items: locations.map<DropdownMenuItem<String>>((String location) {
              return DropdownMenuItem<String>(
                value: location,
                child: Text(location),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
