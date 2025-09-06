import 'dart:math';

class AppHelpers {
  /// Kullanıcının adından sadece ilk kelimeyi döndürür
  String getFirstName(String fullName) {
    if (fullName.isEmpty) return "";
    return fullName.split(' ').first;
  }

  String getPublicId(String uid) {
    if (uid.length < 6) return uid;
    return uid.substring(uid.length - 6); // son 6 karakter
  }

  String generateInviteCode(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure();
    return List.generate(
      length,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
