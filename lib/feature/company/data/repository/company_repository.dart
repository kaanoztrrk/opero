import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opero/product/utility/helpers.dart';
import 'package:uuid/uuid.dart';
import '../models/company_model/company_model.dart';
import '../models/membership/membership_model.dart';

class CompanyRepository {
  final FirebaseFirestore _firestore;

  CompanyRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  Future<CompanyModel> createCompany({
    required String name,
    required String ownerId,
  }) async {
    final companyId = const Uuid().v4();
    final inviteCode = AppHelpers().generateInviteCode(8);

    final company = CompanyModel(
      companyId: companyId,
      name: name,
      createdBy: ownerId,
      inviteCode: inviteCode, // ✅ yeni alan
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _firestore
        .collection('companies')
        .doc(companyId)
        .set(company.toJson());

    // Owner'ı membership olarak ekle
    final membershipRef = _firestore.collection('memberships').doc();
    final membership = MembershipModel(
      membershipId: membershipRef.id,
      userId: ownerId,
      companyId: companyId,
      role: MembershipRole.owner,
      invitedBy: ownerId,
    );
    await membershipRef.set(membership.toJson());

    return company;
  }

  Future<MembershipModel> joinCompany({
    required String userId,
    required String companyId,
    required String invitedBy,
    MembershipRole role = MembershipRole.employee,
  }) async {
    final membershipRef = _firestore.collection('memberships').doc();
    final membership = MembershipModel(
      membershipId: membershipRef.id,
      userId: userId,
      companyId: companyId,
      role: role,
      invitedBy: invitedBy,
    );
    await membershipRef.set(membership.toJson());
    return membership;
  }

  Future<List<CompanyModel>> getUserCompanies(String userId) async {
    final membershipsQuery = await _firestore
        .collection('memberships')
        .where('userId', isEqualTo: userId)
        .get();

    final companyIds = membershipsQuery.docs
        .map((e) => e['companyId'] as String)
        .toList();

    if (companyIds.isEmpty) return [];

    // Firestore whereIn limiti 10: 10'dan fazlaysa batch yap
    final batches = <List<String>>[];
    for (var i = 0; i < companyIds.length; i += 10) {
      batches.add(
        companyIds.sublist(
          i,
          i + 10 > companyIds.length ? companyIds.length : i + 10,
        ),
      );
    }

    final companies = <CompanyModel>[];
    for (var batch in batches) {
      final companiesQuery = await _firestore
          .collection('companies')
          .where('companyId', whereIn: batch)
          .get();
      companies.addAll(
        companiesQuery.docs
            .map((e) => CompanyModel.fromJson(e.data()))
            .toList(),
      );
    }

    return companies;
  }

  Future<CompanyModel> getCompanyById(String companyId) async {
    final doc = await _firestore.collection('companies').doc(companyId).get();

    if (!doc.exists) {
      throw Exception("Company not found");
    }

    return CompanyModel.fromJson(doc.data()!);
  }
}
