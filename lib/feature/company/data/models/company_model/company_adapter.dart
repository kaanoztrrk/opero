import 'package:hive/hive.dart';
import 'company_model.dart';

class CompanyAdapter extends TypeAdapter<CompanyModel> {
  @override
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    writer.writeString(obj.companyId);
    writer.writeString(obj.name);
    writer.writeString(obj.createdBy);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
    writer.write(obj.logoUrl);
    writer.write(obj.modules);
    writer.write(obj.settings);
    writer.writeString(obj.inviteCode); // ✅ yeni alan
  }

  @override
  CompanyModel read(BinaryReader reader) {
    return CompanyModel(
      companyId: reader.readString(),
      name: reader.readString(),
      createdBy: reader.readString(),
      createdAt: reader.read() as DateTime,
      updatedAt: reader.read() as DateTime,
      logoUrl: reader.read() as String?,
      modules: (reader.read() as List?)?.cast<String>(),
      settings: (reader.read() as Map?)?.cast<String, dynamic>(),
      inviteCode: reader.readString(), // ✅ yeni alanı oku
    );
  }
}
