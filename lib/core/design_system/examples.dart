import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import 'design_system.dart';

/// Example widgets demonstrating the design system usage
/// 
/// These examples show how to use the design system components
/// in real-world scenarios. Use these as reference when building
/// your own components.

class DesignSystemExamples extends StatelessWidget {
  const DesignSystemExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Examples'),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.all6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Typography',
              _buildTypographyExamples(),
            ),
            AppSpacing.v8,
            _buildSection(
              'Colors',
              _buildColorExamples(),
            ),
            AppSpacing.v8,
            _buildSection(
              'Buttons',
              _buildButtonExamples(),
            ),
            AppSpacing.v8,
            _buildSection(
              'Cards',
              _buildCardExamples(),
            ),
            AppSpacing.v8,
            _buildSection(
              'Inputs',
              _buildInputExamples(),
            ),
            AppSpacing.v8,
            _buildSection(
              'Spacing',
              _buildSpacingExamples(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.h3),
        AppSpacing.v4,
        child,
      ],
    );
  }

  Widget _buildTypographyExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display 5', style: AppTypography.display5),
        AppSpacing.v2,
        Text('Heading 1', style: AppTypography.h1),
        AppSpacing.v2,
        Text('Heading 2', style: AppTypography.h2),
        AppSpacing.v2,
        Text('Heading 3', style: AppTypography.h3),
        AppSpacing.v2,
        Text('Body Large - Lorem ipsum dolor sit amet', style: AppTypography.bodyLarge),
        AppSpacing.v2,
        Text('Body Base - Lorem ipsum dolor sit amet', style: AppTypography.bodyBase),
        AppSpacing.v2,
        Text('Body Small - Lorem ipsum dolor sit amet', style: AppTypography.bodySmall),
        AppSpacing.v2,
        Text('Label Large', style: AppTypography.labelLarge),
        AppSpacing.v2,
        Text('Caption text', style: AppTypography.caption),
      ],
    );
  }

  Widget _buildColorExamples() {
    return Wrap(
      spacing: AppSpacing.spacing2,
      runSpacing: AppSpacing.spacing2,
      children: [
        _colorBox('Primary', AppColors.primary),
        _colorBox('Secondary', AppColors.secondary),
        _colorBox('Success', AppColors.success),
        _colorBox('Warning', AppColors.warning),
        _colorBox('Error', AppColors.error),
        _colorBox('Info', AppColors.info),
        _colorBox('Gray 100', AppColors.gray100),
        _colorBox('Gray 300', AppColors.gray300),
        _colorBox('Gray 500', AppColors.gray500),
        _colorBox('Gray 700', AppColors.gray700),
        _colorBox('Gray 900', AppColors.gray900),
      ],
    );
  }

  Widget _colorBox(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppBorders.lg,
            border: AppBorders.all(color: AppColors.borderLight),
          ),
        ),
        AppSpacing.v1,
        Text(label, style: AppTypography.caption),
      ],
    );
  }

  Widget _buildButtonExamples() {
    return Wrap(
      spacing: AppSpacing.spacing3,
      runSpacing: AppSpacing.spacing3,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Elevated'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Outlined'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Text'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Coolicons.plus),
          label: const Text('With Icon'),
        ),
      ],
    );
  }

  Widget _buildCardExamples() {
    return Column(
      children: [
        // Basic Card
        Container(
          padding: AppSpacing.all6,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppBorders.xl,
            boxShadow: AppShadows.base,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Basic Card', style: AppTypography.h5),
              AppSpacing.v2,
              Text(
                'This is a card with base shadow and xl border radius.',
                style: AppTypography.bodyBase.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.v4,
        // Card with border
        Container(
          padding: AppSpacing.all6,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppBorders.xl,
            border: AppBorders.all(color: AppColors.border),
            boxShadow: AppShadows.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Card with Border', style: AppTypography.h5),
              AppSpacing.v2,
              Text(
                'This card has a border and subtle shadow.',
                style: AppTypography.bodyBase.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.v4,
        // Colored Card
        Container(
          padding: AppSpacing.all6,
          decoration: BoxDecoration(
            color: AppColors.purple50,
            borderRadius: AppBorders.xl,
            border: AppBorders.all(color: AppColors.purple200),
            boxShadow: AppShadows.primarySm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Colored Card',
                style: AppTypography.h5.copyWith(color: AppColors.purple900),
              ),
              AppSpacing.v2,
              Text(
                'This card uses colored background and shadow.',
                style: AppTypography.bodyBase.copyWith(
                  color: AppColors.purple700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputExamples() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Label',
            hintText: 'Placeholder text',
          ),
        ),
        AppSpacing.v4,
        TextField(
          decoration: const InputDecoration(
            labelText: 'With Icon',
            hintText: 'Email',
            prefixIcon: Icon(Coolicons.mail),
          ),
        ),
        AppSpacing.v4,
        TextField(
          decoration: const InputDecoration(
            labelText: 'Error State',
            hintText: 'Invalid input',
            errorText: 'This field is required',
            prefixIcon: Icon(Coolicons.close_big),
          ),
        ),
      ],
    );
  }

  Widget _buildSpacingExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spacing Scale:', style: AppTypography.labelLarge),
        AppSpacing.v3,
        _spacingBar('spacing1', AppSpacing.spacing1),
        AppSpacing.v2,
        _spacingBar('spacing2', AppSpacing.spacing2),
        AppSpacing.v2,
        _spacingBar('spacing3', AppSpacing.spacing3),
        AppSpacing.v2,
        _spacingBar('spacing4', AppSpacing.spacing4),
        AppSpacing.v2,
        _spacingBar('spacing6', AppSpacing.spacing6),
        AppSpacing.v2,
        _spacingBar('spacing8', AppSpacing.spacing8),
      ],
    );
  }

  Widget _spacingBar(String label, double width) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text('$label:', style: AppTypography.caption),
        ),
        Container(
          width: width,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: AppBorders.base,
          ),
        ),
        AppSpacing.h2,
        Text('${width.toInt()}px', style: AppTypography.caption),
      ],
    );
  }
}

/// Example: Primary Button Component
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: AppSpacing.symmetric(
          horizontal: AppSpacing.spacing6,
          vertical: AppSpacing.spacing3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.lg,
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  AppSpacing.h2,
                ],
                Text(label, style: AppTypography.buttonBase),
              ],
            ),
    );
  }
}

/// Example: Custom Card Component
class CustomCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? child;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.all6,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppBorders.xl,
          border: AppBorders.all(color: AppColors.borderLight),
          boxShadow: AppShadows.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.h5),
            if (subtitle != null) ...[
              AppSpacing.v1,
              Text(
                subtitle!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            if (child != null) ...[
              AppSpacing.v4,
              child!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Example: Responsive Container
class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  const ResponsiveContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final padding = AppBreakpoints.value(
      context,
      xs: AppSpacing.spacing4,
      sm: AppSpacing.spacing6,
      md: AppSpacing.spacing8,
      lg: AppSpacing.spacing10,
    );

    final maxWidth = AppBreakpoints.getMaxContentWidth(context);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: AppSpacing.all(padding),
        child: child,
      ),
    );
  }
}

