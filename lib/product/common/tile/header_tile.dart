import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:opero/product/common/field/primary_textfield.dart';
import 'package:opero/product/common/text/text_widget.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';

class HeaderTile extends StatefulWidget {
  final bool showAvatar;
  final double avatarRadius;
  final String? title;
  final String? subtitle;
  final bool useTextField;

  // Tek PrimaryTextField parametreleri
  final String? textfieldHint;
  final String? textfieldTitle;
  final TextEditingController? textfieldController;
  final TextInputType textfieldKeyboardType;
  final bool textfieldObscureText;
  final IconData? textfieldPrefixIcon;
  final IconData? textfieldSuffixIcon;
  final void Function()? textfieldOnSuffixTap;
  final void Function(String)? textfieldOnChanged;
  final String? Function(String?)? textfieldValidator;
  final bool textfieldIsPasswordField;

  // Avatar özellikleri
  final IconData? avatarIcon;
  final String? avatarNetworkUrl; // network veya Firebase url
  final String? avatarAssetPath;
  final Color? avatarBackgroundColor;
  final Color? avatarBorderColor;
  final Color? avatarIconColor;

  // Firebase Storage path
  final String? firebaseStoragePath;
  final bool onEdit; // avatar edit ikonunu gösterme
  final void Function(String url)? onImageUploaded;

  // Dışarıdan alınabilir type parametreleri
  final AppTextType titleType;
  final AppTextType subtitleType;

  const HeaderTile({
    super.key,
    this.showAvatar = true,
    this.avatarRadius = 45.0,
    this.title,
    this.subtitle,
    this.useTextField = false,
    this.titleType = AppTextType.headlineLarge,
    this.subtitleType = AppTextType.titleLarge,
    this.avatarIcon,
    this.avatarNetworkUrl,
    this.avatarAssetPath,
    this.avatarBackgroundColor,
    this.avatarBorderColor,
    this.avatarIconColor,
    this.firebaseStoragePath,
    this.onEdit = false,
    this.onImageUploaded,
    // PrimaryTextField parametreleri
    this.textfieldHint,
    this.textfieldTitle,
    this.textfieldController,
    this.textfieldKeyboardType = TextInputType.text,
    this.textfieldObscureText = false,
    this.textfieldPrefixIcon,
    this.textfieldSuffixIcon,
    this.textfieldOnSuffixTap,
    this.textfieldOnChanged,
    this.textfieldValidator,
    this.textfieldIsPasswordField = false,
  });

  @override
  State<HeaderTile> createState() => _HeaderTileState();
}

class _HeaderTileState extends State<HeaderTile> {
  final ImagePicker _picker = ImagePicker();
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _avatarUrl = widget.avatarNetworkUrl;
    if (widget.firebaseStoragePath != null) {
      _loadFirebaseImage(widget.firebaseStoragePath!);
    }
  }

  Future<void> _loadFirebaseImage(String path) async {
    try {
      final url = await FirebaseStorage.instance.ref(path).getDownloadURL();
      setState(() {
        _avatarUrl = url;
      });
    } catch (e) {
      debugPrint("❌ Firebase avatar yüklenemedi: $e");
    }
  }

  Future<void> _pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    if (widget.firebaseStoragePath != null) {
      try {
        final ref = FirebaseStorage.instance.ref(widget.firebaseStoragePath!);
        await ref.putFile(file);
        final url = await ref.getDownloadURL();
        setState(() {
          _avatarUrl = url;
        });
        widget.onImageUploaded?.call(url);
      } catch (e) {
        debugPrint("❌ Firebase upload hatası: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showAvatar)
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: widget.avatarBorderColor != null
                      ? Border.all(color: widget.avatarBorderColor!, width: 2)
                      : null,
                ),
                child: CircleAvatar(
                  radius: widget.avatarRadius,
                  backgroundColor:
                      widget.avatarBackgroundColor ?? Colors.grey.shade200,
                  backgroundImage: _avatarUrl != null
                      ? NetworkImage(_avatarUrl!)
                      : (widget.avatarAssetPath != null
                            ? AssetImage(widget.avatarAssetPath!)
                                  as ImageProvider
                            : null),
                  child: _avatarUrl == null && widget.avatarAssetPath == null
                      ? Icon(
                          widget.avatarIcon ?? Icons.person,
                          size: widget.avatarRadius * 0.8,
                          color: widget.avatarIconColor ?? Colors.grey.shade600,
                        )
                      : null,
                ),
              ),
              if (widget.onEdit)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: AppColors.border(context),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      color: AppColors.widgetColor(context),
                      onPressed: _pickAndUploadImage,
                    ),
                  ),
                ),
            ],
          ),

        SizedBox(height: AppSizes.spacingXL),

        if (widget.useTextField)
          PrimaryTextField(
            hint: widget.textfieldHint ?? "",
            title: widget.textfieldTitle,
            controller: widget.textfieldController,
            keyboardType: widget.textfieldKeyboardType,
            obscureText: widget.textfieldObscureText,
            prefixIcon: widget.textfieldPrefixIcon,
            suffixIcon: widget.textfieldSuffixIcon,
            onSuffixTap: widget.textfieldOnSuffixTap,
            onChanged: widget.textfieldOnChanged,
            validator: widget.textfieldValidator,
            isPasswordField: widget.textfieldIsPasswordField,
          )
        else ...[
          if (widget.title != null)
            AppText(
              text: widget.title!,
              type: widget.titleType,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
          if (widget.subtitle != null)
            AppText(
              text: widget.subtitle!,
              type: widget.subtitleType,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
        ],
      ],
    );
  }
}
