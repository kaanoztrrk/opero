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
    writer.write(obj.createdAt); // writeDateTime yerine write() kullan
    writer.write(obj.updatedAt);
    writer.write(obj.logoUrl); // nullable
    writer.write(obj.modules); // nullable
    writer.write(obj.settings); // nullable
  }

  @override
  CompanyModel read(BinaryReader reader) {
    return CompanyModel(
      companyId: reader.readString(),
      name: reader.readString(),
      createdBy: reader.readString(),
      createdAt: reader.read() as DateTime, // readDateTime yerine read()
      updatedAt: reader.read() as DateTime,
      logoUrl: reader.read() as String?,
      modules: (reader.read() as List?)?.cast<String>(),
      settings: (reader.read() as Map?)?.cast<String, dynamic>(),
    );
  }
}
