import 'package:hive/hive.dart';
import 'user_model.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      uid: reader.readString(),
      email: reader.readString(),
      name: reader.readString(),
      photoUrl: reader.read() as String?,
      role: reader.readString(),
      isActive: reader.readBool(),
      lastLogin: reader.read() as DateTime?, // nullable
      createdAt: reader.read() as DateTime, // readDateTime da kullanılabilir
      updatedAt: reader.read() as DateTime,
      phoneNumber: reader.read() as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.uid);
    writer.writeString(obj.email);
    writer.writeString(obj.name);
    writer.write(obj.photoUrl); // nullable
    writer.writeString(obj.role);
    writer.writeBool(obj.isActive);
    writer.write(obj.lastLogin); // nullable
    writer.write(obj.createdAt); // write() ile DateTime da çalışır
    writer.write(obj.updatedAt);
    writer.write(obj.phoneNumber); // nullable
  }
}
