import 'package:flutter/material.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';

/// Photo well for a dish or category.
///
/// Venues have no images yet. The slot keeps a fixed frame so a later photo
/// can drop in without pushing the name or the price.
class MenuImageSlot extends StatelessWidget {
  const MenuImageSlot({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.sand,
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
        child: Icon(AppIcons.image, color: AppColors.muted, size: size * 0.42),
      ),
    );
  }
}
