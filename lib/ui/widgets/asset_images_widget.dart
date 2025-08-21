import 'package:flutter/cupertino.dart';

enum IconType { plus, save, chevronForward, close, share, sort }

class AssetImageWidget extends StatelessWidget {
  final IconType iconType;
  final Color? color;

  const AssetImageWidget({
    super.key,
    required this.iconType,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final String assetPath;
    switch (iconType) {
      case IconType.share:
        assetPath = 'assets/share.png';
        break;
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
      case IconType.sort:
        assetPath = 'assets/sort.png';
        break;
    }
    return Image.asset(
      assetPath,
      color: color,
    );
  }
}
