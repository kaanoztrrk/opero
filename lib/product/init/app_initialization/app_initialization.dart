import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:opero/firebase_options.dart';
import '../../../feature/auth/data/models/user_model/user_adapter.dart';
import '../../../feature/auth/data/models/user_model/user_model.dart';
import '../../../feature/company/data/models/company_model/company_adapter.dart';
import '../../../feature/company/data/models/company_model/company_model.dart';
import '../../../feature/company/data/models/membership/membership_adapter.dart';
import '../../../feature/company/data/models/membership/membership_model.dart';

class AppInitialization {
  static Future<void> init({bool clearBoxes = false}) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase başlat
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Hive başlat
    await Hive.initFlutter();

    // Adapter’ları register et
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter(MembershipAdapter());

    // Box’ları aç
    await Hive.openBox<UserModel>('userBox');
    await Hive.openBox<CompanyModel>('companyBox');
    await Hive.openBox<MembershipModel>('membershipBox');

    // Eğer clearBoxes = true ise box’ları temizle
    if (clearBoxes) {
      await Hive.box<UserModel>('userBox').clear();
      await Hive.box<CompanyModel>('companyBox').clear();
      await Hive.box<MembershipModel>('membershipBox').clear();
    }
  }
}
