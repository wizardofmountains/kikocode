import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../../domain/models/group.dart';

/// Multi-select dropdown field for group selection with emojis
/// Features inline expansion with checkboxes and colored emoji icons
class GroupSelectionField extends StatefulWidget {
  final List<Group> groups;
  final List<Group> selectedGroups;
  final ValueChanged<List<Group>>? onChanged;
  final VoidCallback? onInfoTap;

  const GroupSelectionField({
    super.key,
    required this.groups,
    this.selectedGroups = const [],
    this.onChanged,
    this.onInfoTap,
  });

  @override
  State<GroupSelectionField> createState() => _GroupSelectionFieldState();
}

class _GroupSelectionFieldState extends State<GroupSelectionField> {
  bool _isExpanded = false;
  late List<Group> _selectedGroups;

  @override
  void initState() {
    super.initState();
    _selectedGroups = List.from(widget.selectedGroups);
  }

  @override
  void didUpdateWidget(GroupSelectionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedGroups != oldWidget.selectedGroups) {
      _selectedGroups = List.from(widget.selectedGroups);
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleGroup(Group group) {
    setState(() {
      if (_selectedGroups.contains(group)) {
        _selectedGroups.remove(group);
      } else {
        _selectedGroups.add(group);
      }
    });
    widget.onChanged?.call(_selectedGroups);
  }

  String _getDisplayText() {
    if (_selectedGroups.isEmpty) {
      return 'Gruppe/n';
    } else if (_selectedGroups.length == 1) {
      return _selectedGroups.first.name;
    } else {
      return '${_selectedGroups.length} Gruppen';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceHighest,
        border: Border.all(
          color: AppColors.surfaceLow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl - 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row
            InkWell(
              onTap: _toggleExpanded,
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 24, right: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            _getDisplayText(),
                            style: KikoTypography.withColor(
                              KikoTypography.appBody,
                              _selectedGroups.isEmpty
                                  ? AppColors.captionKiko
                                  : AppColors.textPrimaryKiko,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _isExpanded
                                ? Coolicons.chevron_up
                                : Coolicons.chevron_down,
                            size: 18,
                            color: AppColors.textPrimaryKiko,
                          ),
                        ],
                      ),
                    ),
                    if (widget.onInfoTap != null)
                      IconButton(
                        icon: const Icon(
                          Coolicons.info_circle,
                          size: 20,
                        ),
                        color: AppColors.textPrimaryKiko,
                        onPressed: widget.onInfoTap,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Group items (only shown when expanded)
            if (_isExpanded)
              for (final group in widget.groups)
                Builder(
                  builder: (context) {
                    final isSelected = _selectedGroups.contains(group);
                    return InkWell(
                      onTap: () => _toggleGroup(group),
                      child: Container(
                        height: 51,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            // Emoji circle
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: group.iconColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  group.emoji,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),

                            // Group name
                            Expanded(
                              child: Text(
                                group.name,
                                style: KikoTypography.withColor(
                                  KikoTypography.appBody,
                                  AppColors.textPrimaryKiko,
                                ),
                              ),
                            ),

                            // Checkbox
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.primaryKiko
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryKiko
                                      : AppColors.surfaceLow,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
