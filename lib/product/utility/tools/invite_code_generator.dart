// lib/core/util/invite_code.dart
import 'dart:math';

class InviteCode {
  static const _alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  // (I, L, O, 0, 1 yok – karışmasın)

  static String generate({int length = 6}) {
    final rand = Random.secure();
    return List.generate(
      length,
      (_) => _alphabet[rand.nextInt(_alphabet.length)],
    ).join();
  }
}
