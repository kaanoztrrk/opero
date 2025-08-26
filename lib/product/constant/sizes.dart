class AppSizes {
  AppSizes._(); // Singleton değil, sadece statik erişim için private constructor

  // -------------------- Padding & Margin --------------------
  // 4 - Çok küçük boşluk, ikon veya minör spacing
  static const double paddingXS = 4.0;
  // 8 - Küçük boşluk, text ve ikon arası
  static const double paddingSM = 8.0;
  // 16 - Standart padding, kart veya container içi
  static const double paddingMD = 16.0;
  // 24 - Büyük padding, bölümler arası mesafe
  static const double paddingLG = 24.0;
  // 32 - Extra büyük padding, sayfa kenar boşluğu
  static const double paddingXL = 32.0;
  // 48 - Çok büyük boşluk, section arası boşluk
  static const double paddingXXL = 48.0;

  // -------------------- Font Sizes --------------------
  // 10 - Küçük açıklama, hint text
  static const double fontXXS = 10.0;
  // 12 - Küçük etiketler
  static const double fontXS = 12.0;
  // 14 - Küçük paragraf, body text
  static const double fontSM = 14.0;
  // 16 - Standart paragraf, normal body
  static const double fontMD = 16.0;
  // 18 - Başlık altı text, küçük başlık
  static const double fontLG = 18.0;
  // 22 - Orta başlık
  static const double fontXL = 22.0;
  // 28 - Büyük başlık, section title
  static const double fontXXL = 28.0;
  // 32 - Ana başlık, sayfa başlığı
  static const double fontXXXL = 32.0;

  // -------------------- Border Radius --------------------
  // 4 - Çok küçük köşe, minimal rounding
  static const double radiusXS = 4.0;
  // 8 - Küçük köşe, butonlar ve kartlar
  static const double radiusSM = 8.0;
  // 12 - Standart köşe, container ve kart
  static const double radiusMD = 12.0;
  // 16 - Büyük köşe, modal veya card
  static const double radiusLG = 16.0;
  // 24 - Extra büyük köşe, rounded container
  static const double radiusXL = 24.0;
  // 1000 - Tam yuvarlak, avatar ve ikonlar
  static const double radiusCircle = 1000.0;

  // -------------------- Icon Sizes --------------------
  // 12 - Minör ikon
  static const double iconXS = 12.0;
  // 16 - Küçük ikon
  static const double iconSM = 16.0;
  // 24 - Standart ikon (Material default)
  static const double iconMD = 24.0;
  // 32 - Büyük ikon
  static const double iconLG = 32.0;
  // 48 - Extra büyük ikon
  static const double iconXL = 48.0;

  // -------------------- Elevation --------------------
  // 1 - Minimal shadow
  static const double elevationXS = 1.0;
  // 2 - Küçük kart veya buton
  static const double elevationSM = 2.0;
  // 4 - Standart elevation, Material default
  static const double elevationMD = 4.0;
  // 8 - Büyük shadow, modal veya dialog
  static const double elevationLG = 8.0;

  // -------------------- Line Height / Spacing --------------------
  // 2 - Çok sık satırlar arası
  static const double spacingXXS = 2.0;
  // 4 - Küçük satır veya element spacing
  static const double spacingXS = 4.0;
  // 8 - Küçük spacing
  static const double spacingSM = 8.0;
  // 12 - Orta spacing
  static const double spacingMD = 12.0;
  // 16 - Büyük spacing
  static const double spacingLG = 16.0;
  // 24 - Çok büyük spacing
  static const double spacingXL = 24.0;
  // 32 - Çok geniş spacing
  static const double spacingXXL = 32.0;

  // -------------------- Widths / Heights (generic) --------------------
  // 32 - Küçük buton yüksekliği
  static const double buttonHeightSM = 32.0;
  // 48 - Standart buton yüksekliği
  static const double buttonHeightMD = 48.0;
  // 56 - Büyük buton yüksekliği
  static const double buttonHeightLG = 56.0;

  // 40 - Küçük input
  static const double inputHeightSM = 40.0;
  // 48 - Standart input
  static const double inputHeightMD = 48.0;
  // 56 - Büyük input
  static const double inputHeightLG = 56.0;
}
