import 'package:flutter/material.dart';
import 'package:kikocode/core/components/atoms/app_input.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Test screen to demonstrate AppInput validation error state
/// 
/// Shows both normal and error states side by side
class AppInputValidationTest extends StatefulWidget {
  const AppInputValidationTest({super.key});

  @override
  State<AppInputValidationTest> createState() => _AppInputValidationTestState();
}

class _AppInputValidationTestState extends State<AppInputValidationTest> {
  final _normalController = TextEditingController();
  final _errorController = TextEditingController();
  
  bool _showError = true;

  @override
  void dispose() {
    _normalController.dispose();
    _errorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      appBar: AppBar(
        title: const Text('AppInput Validation Test'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'AppInput Validation Error State Test',
              style: AppTypography.largeTitle.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.v6,
            
            // Toggle button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showError = !_showError;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              child: Text(_showError ? 'Hide Error State' : 'Show Error State'),
            ),
            AppSpacing.v8,
            
            // Normal State Example
            Text(
              '1. Normal State (No Error)',
              style: AppTypography.headline.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.v4,
            const AppInput(
              label: 'Benutzername',
              hintText: 'Benutzername',
            ),
            AppSpacing.v8,
            
            // Error State Example
            Text(
              '2. Error State (Empty Field)',
              style: AppTypography.headline.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.v4,
            AppInput(
              label: 'Benutzername',
              hintText: 'Benutzername',
              errorText: _showError ? 'Benutzername erforderlich!' : null,
            ),
            AppSpacing.v8,
            
            // Password Error State Example
            Text(
              '3. Password Field Error State',
              style: AppTypography.headline.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.v4,
            AppInput(
              label: 'Passwort',
              hintText: 'Passwort',
              obscureText: true,
              errorText: _showError ? 'Passwort erforderlich!' : null,
            ),
            AppSpacing.v8,
            
            // Interactive Test
            Text(
              '4. Interactive Test',
              style: AppTypography.headline.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.v4,
            Text(
              'Type something to clear the error:',
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            AppSpacing.v4,
            AppInput(
              controller: _errorController,
              label: 'Benutzername',
              hintText: 'Benutzername',
              errorText: _errorController.text.isEmpty && _showError 
                  ? 'Benutzername erforderlich!' 
                  : null,
              onChanged: (value) {
                setState(() {}); // Rebuild to update error state
              },
            ),
            AppSpacing.v8,
            
            // Design Specifications
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.surfaceLow,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Design Specifications',
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  AppSpacing.v3,
                  _buildSpecRow('Border Color', '#FF383C (Accent Red)', AppColors.accentRed),
                  _buildSpecRow('Border Width', '2px', null),
                  _buildSpecRow('Border Radius', '25px', null),
                  _buildSpecRow('Background', '#FBF7EF (Surface Highest)', AppColors.surfaceHighest),
                  _buildSpecRow('Error Text', '11px Nunito Sans Regular', AppColors.accentRed),
                  _buildSpecRow('Placeholder', '17px Nunito Sans Regular @ 40%', AppColors.accentRed.withOpacity(0.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSpecRow(String label, String value, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                if (color != null) ...[
                  AppSpacing.h2,
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.borderDark,
                        width: 1,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
