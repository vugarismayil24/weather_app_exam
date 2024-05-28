import 'package:flutter/material.dart';

class CityButton extends StatelessWidget {
  final String cityName;
  final VoidCallback onPressed;

  const CityButton({
    required this.cityName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(cityName),
      ),
    );
  }
}