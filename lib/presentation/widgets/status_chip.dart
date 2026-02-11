import 'package:flutter/material.dart';
import '../../domain/models/ticket.dart';
import '../../core/theme/app_theme.dart';

class StatusChip extends StatelessWidget {
  final RepairStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusChip({
    super.key,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? status.backgroundColor
              : (isDark ? AppColors.surfaceDark : Colors.white),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : const Color(0xFFE6E2DB)),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Icon(status.icon, size: 18, color: status.textColor),
              const SizedBox(width: 8),
            ],
            Text(
              status.label,
              style: TextStyle(
                color: isSelected
                    ? status.textColor
                    : (isDark ? Colors.grey[400] : AppColors.textLight),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
