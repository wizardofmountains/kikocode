import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all5,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppBorders.xl2,
        boxShadow: AppShadows.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aktuell',
            style: AppTypography.h5.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          AppSpacing.v3,
          _buildEventItem('Di, 9. Dez.: Laternenwanderung'),
          _buildEventItem('Mi, 10. Dez.: Gemüsebuffet'),
          _buildEventItem('Do, 11. Dez.: Pyjamaparty'),
        ],
      ),
    );
  }

  Widget _buildEventItem(String text) {
    return Padding(
      padding: AppSpacing.bottomOnly(AppSpacing.spacing2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: AppSpacing.only(
              top: 7,
              right: AppSpacing.spacing3,
            ),
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

