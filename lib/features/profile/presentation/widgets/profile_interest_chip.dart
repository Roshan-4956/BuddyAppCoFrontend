import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/image_source_utils.dart';
class ProfileInterestChip extends StatelessWidget {
  const ProfileInterestChip({
    super.key,
    required this.label,
    this.iconUrl,
    this.assetPath,
  });

  final String label;
  final String? iconUrl;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_hasIcon)
            SizedBox(
              height: 14,
              width: 14,
              child: _buildIcon(),
            ),
          if (_hasIcon)
            const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textOnChip,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  bool get _hasIcon =>
      (assetPath != null && assetPath!.isNotEmpty) ||
      (iconUrl != null && iconUrl!.isNotEmpty);

  Widget _buildIcon() {
    if (assetPath != null && assetPath!.isNotEmpty) {
      return SvgPicture.asset(assetPath!, fit: BoxFit.contain);
    }
    final url = iconUrl ?? '';
    final data = ImageSourceUtils.imageDataFromUri(url);
    if (data != null) {
      if (data.mimeType == 'image/svg+xml') {
        return SvgPicture.memory(data.bytes, fit: BoxFit.contain);
      }
      return Image.memory(
        data.bytes,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const SizedBox.shrink(),
      );
    }
    if (url.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(url, fit: BoxFit.contain);
    }
    return Image.network(
      url,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
