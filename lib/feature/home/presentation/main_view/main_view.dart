import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opero/product/init/di/di.dart';

import '../../../company/data/models/company_model/company_model.dart';
import '../../cubits/main/main_cube.dart';
import '../../cubits/main/main_state.dart';
import '../dashboard_view/dashboard_view.dart';
import '../settings_view/settings_view.dart';
import '../statistics_view/statistics_view.dart';

class MainView extends StatefulWidget {
  final String companyId;
  const MainView({super.key, required this.companyId});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  CompanyModel? _company;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCompany();
  }

  Future<void> _loadCompany() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('companies')
          .doc(widget.companyId)
          .get();

      if (doc.exists) {
        setState(() {
          _company = CompanyModel.fromJson(doc.data()!);
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
        });
        print("Company not found");
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print("Error fetching company: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardView(company: _company),
      const StatisticsView(),
      const SettingsView(),
    ];

    return BlocProvider.value(
      value: getIt<MainCubit>(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: _loading
                ? const Center(child: CircularProgressIndicator())
                : pages[state.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<MainCubit>().changeTab(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: "Statistics",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
