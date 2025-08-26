import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClearPrefsButton extends StatelessWidget {
  const ClearPrefsButton({super.key});

  Future<void> _clearPrefs(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tüm SharedPreferences verileri silindi!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _clearPrefs(context),
      child: const Text("SharedPreferences Verilerini Sil"),
    );
  }
}
