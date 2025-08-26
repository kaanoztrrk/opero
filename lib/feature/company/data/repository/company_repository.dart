import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';

class CompanyRepository {
  final FirebaseFirestore _firestore;

  CompanyRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createCompany(CompanyModel company) async {
    await _firestore
        .collection('companies')
        .doc(company.id)
        .set(company.toJson());
  }

  Future<void> updateCompany(CompanyModel company) async {
    await _firestore
        .collection('companies')
        .doc(company.id)
        .update(company.toJson());
  }

  Future<void> deleteCompany(String companyId) async {
    await _firestore.collection('companies').doc(companyId).delete();
  }

  Future<void> addMember(String companyId, String userId) async {
    final docRef = _firestore.collection('companies').doc(companyId);
    await docRef.update({
      'members': FieldValue.arrayUnion([userId]),
    });
  }

  Future<void> removeMember(String companyId, String userId) async {
    final docRef = _firestore.collection('companies').doc(companyId);
    await docRef.update({
      'members': FieldValue.arrayRemove([userId]),
    });
  }

  // Opsiyonel: stream ile dinleme
  Stream<CompanyModel?> streamCompany(String companyId) {
    return _firestore
        .collection('companies')
        .doc(companyId)
        .snapshots()
        .map(
          (doc) => doc.exists
              ? CompanyModel.fromJson(doc.data()!..['id'] = doc.id)
              : null,
        );
  }
}
