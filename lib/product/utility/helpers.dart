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

  String generateCompanyCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final now = DateTime.now().millisecondsSinceEpoch;
    return List.generate(
      6,
      (i) => chars[(now ~/ (i + 1)) % chars.length],
    ).join();
  }
}
