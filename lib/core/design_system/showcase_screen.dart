import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import 'design_system.dart';

/// A screen to showcase all design system components
/// 
/// This screen demonstrates how to use various design system
/// tokens and can serve as a living style guide for the app.
class DesignSystemShowcase extends StatefulWidget {
  const DesignSystemShowcase({super.key});

  @override
  State<DesignSystemShowcase> createState() => _DesignSystemShowcaseState();
}

class _DesignSystemShowcaseState extends State<DesignSystemShowcase> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Colors',
    'Typography',
    'Buttons',
    'Cards',
    'Inputs',
    'Spacing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Showcase'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.h4v0,
            child: Row(
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedTab == index;
                return Padding(
                  padding: AppSpacing.rightOnly(AppSpacing.spacing2),
                  child: ChoiceChip(
                    label: Text(_tabs[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedTab = index);
                      }
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.all6,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTab) {
      case 0:
        return _buildColorsTab();
      case 1:
        return _buildTypographyTab();
      case 2:
        return _buildButtonsTab();
      case 3:
        return _buildCardsTab();
      case 4:
        return _buildInputsTab();
      case 5:
        return _buildSpacingTab();
      default:
        return const SizedBox();
    }
  }

  // ============= Colors Tab =============
  Widget _buildColorsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Semantic Colors'),
        AppSpacing.v4,
        Wrap(
          spacing: AppSpacing.spacing3,
          runSpacing: AppSpacing.spacing3,
          children: [
            _colorCard('Primary', AppColors.primary),
            _colorCard('Secondary', AppColors.secondary),
            _colorCard('Success', AppColors.success),
            _colorCard('Warning', AppColors.warning),
            _colorCard('Error', AppColors.error),
            _colorCard('Info', AppColors.info),
          ],
        ),
        AppSpacing.v8,
        _sectionTitle('Purple Scale'),
        AppSpacing.v4,
        _colorScale('purple', [
          AppColors.purple50,
          AppColors.purple100,
          AppColors.purple200,
          AppColors.purple300,
          AppColors.purple400,
          AppColors.purple500,
          AppColors.purple600,
          AppColors.purple700,
          AppColors.purple800,
          AppColors.purple900,
        ]),
        AppSpacing.v8,
        _sectionTitle('Gray Scale'),
        AppSpacing.v4,
        _colorScale('gray', [
          AppColors.gray50,
          AppColors.gray100,
          AppColors.gray200,
          AppColors.gray300,
          AppColors.gray400,
          AppColors.gray500,
          AppColors.gray600,
          AppColors.gray700,
          AppColors.gray800,
          AppColors.gray900,
        ]),
      ],
    );
  }

  Widget _colorCard(String name, Color color) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppBorders.lg,
              border: AppBorders.all(color: AppColors.borderLight),
            ),
          ),
          AppSpacing.v2,
          Text(name, style: AppTypography.labelSmall),
        ],
      ),
    );
  }

  Widget _colorScale(String name, List<Color> colors) {
    return Wrap(
      spacing: AppSpacing.spacing2,
      runSpacing: AppSpacing.spacing2,
      children: List.generate(colors.length, (index) {
        final shade = (index + 1) * 100;
        return _colorCard('$name-$shade', colors[index]);
      }),
    );
  }

  // ============= Typography Tab =============
  Widget _buildTypographyTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Display Styles'),
        AppSpacing.v4,
        Text('Display 5', style: AppTypography.display5),
        AppSpacing.v2,
        _sectionTitle('Headings'),
        AppSpacing.v4,
        Text('Heading 1', style: AppTypography.h1),
        AppSpacing.v2,
        Text('Heading 2', style: AppTypography.h2),
        AppSpacing.v2,
        Text('Heading 3', style: AppTypography.h3),
        AppSpacing.v2,
        Text('Heading 4', style: AppTypography.h4),
        AppSpacing.v2,
        Text('Heading 5', style: AppTypography.h5),
        AppSpacing.v2,
        Text('Heading 6', style: AppTypography.h6),
        AppSpacing.v4,
        _sectionTitle('Body Text'),
        AppSpacing.v4,
        Text('Body Large - The quick brown fox jumps over the lazy dog',
            style: AppTypography.bodyLarge),
        AppSpacing.v2,
        Text('Body Base - The quick brown fox jumps over the lazy dog',
            style: AppTypography.bodyBase),
        AppSpacing.v2,
        Text('Body Small - The quick brown fox jumps over the lazy dog',
            style: AppTypography.bodySmall),
        AppSpacing.v2,
        Text('Body XSmall - The quick brown fox jumps over the lazy dog',
            style: AppTypography.bodyXSmall),
        AppSpacing.v4,
        _sectionTitle('Labels'),
        AppSpacing.v4,
        Text('Label Large', style: AppTypography.labelLarge),
        AppSpacing.v2,
        Text('Label Base', style: AppTypography.labelBase),
        AppSpacing.v2,
        Text('Label Small', style: AppTypography.labelSmall),
        AppSpacing.v4,
        _sectionTitle('Special Styles'),
        AppSpacing.v4,
        Text('Caption text', style: AppTypography.caption),
        AppSpacing.v2,
        Text('OVERLINE TEXT', style: AppTypography.overline),
        AppSpacing.v2,
        Text('code style', style: AppTypography.codeBase),
        AppSpacing.v2,
        Text('Link style', style: AppTypography.link),
      ],
    );
  }

  // ============= Buttons Tab =============
  Widget _buildButtonsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Elevated Buttons'),
        AppSpacing.v4,
        Wrap(
          spacing: AppSpacing.spacing3,
          runSpacing: AppSpacing.spacing3,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Default'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Coolicons.plus),
              label: const Text('With Icon'),
            ),
            ElevatedButton(
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ],
        ),
        AppSpacing.v6,
        _sectionTitle('Outlined Buttons'),
        AppSpacing.v4,
        Wrap(
          spacing: AppSpacing.spacing3,
          runSpacing: AppSpacing.spacing3,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text('Default'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Coolicons.download),
              label: const Text('With Icon'),
            ),
            OutlinedButton(
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ],
        ),
        AppSpacing.v6,
        _sectionTitle('Text Buttons'),
        AppSpacing.v4,
        Wrap(
          spacing: AppSpacing.spacing3,
          runSpacing: AppSpacing.spacing3,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Default'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Coolicons.info_circle),
              label: const Text('With Icon'),
            ),
            TextButton(
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ],
        ),
        AppSpacing.v6,
        _sectionTitle('Icon Buttons'),
        AppSpacing.v4,
        Wrap(
          spacing: AppSpacing.spacing3,
          runSpacing: AppSpacing.spacing3,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Coolicons.heart_outline),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Coolicons.trash_empty),
            ),
            IconButton(
              onPressed: null,
              icon: const Icon(Coolicons.settings),
            ),
          ],
        ),
      ],
    );
  }

  // ============= Cards Tab =============
  Widget _buildCardsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Basic Card'),
        AppSpacing.v4,
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
              Text('Card Title', style: AppTypography.h5),
              AppSpacing.v2,
              Text(
                'This is a basic card with base shadow and xl border radius.',
                style: AppTypography.bodyBase.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.v6,
        _sectionTitle('Card with Border'),
        AppSpacing.v4,
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
              Text('Bordered Card', style: AppTypography.h5),
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
        AppSpacing.v6,
        _sectionTitle('Colored Cards'),
        AppSpacing.v4,
        _coloredCard(
          'Success Card',
          'This card uses success colors',
          AppColors.success50,
          AppColors.success200,
          AppColors.success900,
          AppColors.success700,
        ),
        AppSpacing.v4,
        _coloredCard(
          'Warning Card',
          'This card uses warning colors',
          AppColors.amber50,
          AppColors.amber200,
          AppColors.amber900,
          AppColors.amber700,
        ),
        AppSpacing.v4,
        _coloredCard(
          'Error Card',
          'This card uses error colors',
          AppColors.red50,
          AppColors.red200,
          AppColors.red900,
          AppColors.red700,
        ),
      ],
    );
  }

  Widget _coloredCard(
    String title,
    String content,
    Color bgColor,
    Color borderColor,
    Color titleColor,
    Color contentColor,
  ) {
    return Container(
      padding: AppSpacing.all6,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppBorders.xl,
        border: AppBorders.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h5.copyWith(color: titleColor),
          ),
          AppSpacing.v2,
          Text(
            content,
            style: AppTypography.bodyBase.copyWith(color: contentColor),
          ),
        ],
      ),
    );
  }

  // ============= Inputs Tab =============
  Widget _buildInputsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Text Fields'),
        AppSpacing.v4,
        const TextField(
          decoration: InputDecoration(
            labelText: 'Label',
            hintText: 'Placeholder text',
          ),
        ),
        AppSpacing.v4,
        const TextField(
          decoration: InputDecoration(
            labelText: 'With Icon',
            hintText: 'Email address',
            prefixIcon: Icon(Coolicons.mail),
          ),
        ),
        AppSpacing.v4,
        const TextField(
          decoration: InputDecoration(
            labelText: 'With Helper',
            hintText: 'Enter value',
            helperText: 'This is helper text',
            suffixIcon: Icon(Coolicons.info_circle),
          ),
        ),
        AppSpacing.v4,
        const TextField(
          decoration: InputDecoration(
            labelText: 'Error State',
            hintText: 'Invalid input',
            errorText: 'This field is required',
            prefixIcon: Icon(Coolicons.close_big),
          ),
        ),
        AppSpacing.v6,
        _sectionTitle('Checkboxes & Radios'),
        AppSpacing.v4,
        CheckboxListTile(
          value: true,
          onChanged: (value) {},
          title: const Text('Checked'),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (value) {},
          title: const Text('Unchecked'),
        ),
        RadioListTile(
          value: 1,
          groupValue: 1,
          onChanged: (value) {},
          title: const Text('Selected'),
        ),
        RadioListTile(
          value: 2,
          groupValue: 1,
          onChanged: (value) {},
          title: const Text('Unselected'),
        ),
        AppSpacing.v6,
        _sectionTitle('Switches'),
        AppSpacing.v4,
        SwitchListTile(
          value: true,
          onChanged: (value) {},
          title: const Text('Enabled'),
        ),
        SwitchListTile(
          value: false,
          onChanged: (value) {},
          title: const Text('Disabled'),
        ),
      ],
    );
  }

  // ============= Spacing Tab =============
  Widget _buildSpacingTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Spacing Scale'),
        AppSpacing.v4,
        Text(
          'Visual representation of spacing values',
          style: AppTypography.bodyBase.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSpacing.v6,
        _spacingBar('spacing1', AppSpacing.spacing1),
        AppSpacing.v2,
        _spacingBar('spacing2', AppSpacing.spacing2),
        AppSpacing.v2,
        _spacingBar('spacing3', AppSpacing.spacing3),
        AppSpacing.v2,
        _spacingBar('spacing4', AppSpacing.spacing4),
        AppSpacing.v2,
        _spacingBar('spacing5', AppSpacing.spacing5),
        AppSpacing.v2,
        _spacingBar('spacing6', AppSpacing.spacing6),
        AppSpacing.v2,
        _spacingBar('spacing8', AppSpacing.spacing8),
        AppSpacing.v2,
        _spacingBar('spacing10', AppSpacing.spacing10),
        AppSpacing.v2,
        _spacingBar('spacing12', AppSpacing.spacing12),
        AppSpacing.v2,
        _spacingBar('spacing16', AppSpacing.spacing16),
        AppSpacing.v6,
        _sectionTitle('Semantic Aliases'),
        AppSpacing.v4,
        _spacingBar('xs', AppSpacing.xs),
        AppSpacing.v2,
        _spacingBar('sm', AppSpacing.sm),
        AppSpacing.v2,
        _spacingBar('md', AppSpacing.md),
        AppSpacing.v2,
        _spacingBar('lg', AppSpacing.lg),
        AppSpacing.v2,
        _spacingBar('xl', AppSpacing.xl),
      ],
    );
  }

  Widget _spacingBar(String label, double width) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text('$label:', style: AppTypography.labelSmall),
        ),
        Container(
          width: width,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: AppBorders.base,
          ),
        ),
        AppSpacing.h3,
        Text('${width.toInt()}px', style: AppTypography.caption),
      ],
    );
  }

  // ============= Helper Methods =============
  Widget _sectionTitle(String title) {
    return Text(title, style: AppTypography.h4);
  }
}

