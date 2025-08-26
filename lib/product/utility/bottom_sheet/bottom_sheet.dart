import 'package:flutter/material.dart';

class AppBottomSheet {
  final BuildContext context;

  AppBottomSheet(this.context);

  /// Temel bottom sheet gösterme fonksiyonu
  Future<void> show({
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height, // opsiyonel sabit yükseklik
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.white,
      isScrollControlled: true, // 🔹 klavye için gerekli
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              // 🔹 içerik kaydırılabilir
              child: Container(
                padding: padding,
                constraints: height != null
                    ? BoxConstraints(minHeight: 0, maxHeight: height)
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Draggable handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    // Başlık opsiyonel
                    if (title != null) ...[title, const SizedBox(height: 12)],
                    // İçerik opsiyonel
                    if (content != null) ...[
                      content,
                      const SizedBox(height: 20),
                    ],
                    // Aksiyon butonları opsiyonel
                    if (actions != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
