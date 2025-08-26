import 'package:flutter/material.dart';
import 'package:opero/product/common/button/clear_pref_button.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ClearPrefsButton()));
  }
}
