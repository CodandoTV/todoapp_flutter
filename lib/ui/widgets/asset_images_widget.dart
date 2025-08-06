import 'package:flutter/cupertino.dart';

enum IconType { plus, save, chevronForward, close }

class AssetImageWidget extends StatelessWidget {
  final IconType iconType;

  const AssetImageWidget({super.key, required this.iconType});

  @override
  Widget build(BuildContext context) {
    final String assetPath;
    switch (iconType) {
      case IconType.plus:
        assetPath = 'assets/exposure_plus.png';
        break;
      case IconType.save:
        assetPath = 'assets/save.png';
        break;
      case IconType.chevronForward:
        assetPath = 'assets/chevron.png';
        break;
      case IconType.close:
        assetPath = 'assets/close.png';
        break;
    }
    return Image.asset(assetPath);
  }
}
