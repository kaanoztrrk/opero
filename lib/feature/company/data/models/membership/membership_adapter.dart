import 'package:hive/hive.dart';
import 'membership_model.dart';

class MembershipAdapter extends TypeAdapter<MembershipModel> {
  @override
  final int typeId = 2;

  @override
  MembershipModel read(BinaryReader reader) {
    return MembershipModel(
      membershipId: reader.readString(),
      userId: reader.readString(),
      companyId: reader.readString(),
      role: MembershipRole.values[reader.readInt()],
      invitedBy: reader.readString(),
      joinedAt: reader.read() as DateTime,
      isActive: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, MembershipModel obj) {
    writer.writeString(obj.membershipId);
    writer.writeString(obj.userId);
    writer.writeString(obj.companyId);
    writer.writeInt(obj.role.index); // enum index ile yaz
    writer.writeString(obj.invitedBy);
    writer.write(obj.joinedAt); // nullable değil
    writer.writeBool(obj.isActive);
  }
}
