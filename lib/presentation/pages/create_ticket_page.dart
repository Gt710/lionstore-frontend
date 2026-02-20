import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/ticket.dart';
import '../widgets/status_chip.dart';

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({super.key});

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  RepairStatus _selectedStatus = RepairStatus.received;
  final String _assignedWorker = 'Marcus Thorne';

  // Form controllers
  final TextEditingController _deviceModelController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _problemDescriptionController =
      TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _deviceModelController.dispose();
    _passwordController.dispose();
    _problemDescriptionController.dispose();
    _clientNameController.dispose();
    _phoneNumberController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Header
            _buildHeader(context, isDark),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Selection
                    _buildStatusSelection(isDark),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 1),
                    ),

                    // Form Sections
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildSectionHeader(
                            'Деталі пристрою',
                            Icons.smartphone_outlined,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Модель пристрою',
                            placeholder: 'наприклад, iPhone 14 Pro Max',
                            controller: _deviceModelController,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Опис проблеми',
                            placeholder:
                                'Опишіть проблему, фізичні пошкодження тощо...',
                            controller: _problemDescriptionController,
                            isDark: isDark,
                            maxLines: 4,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Пароль пристрою / Ключ',
                            placeholder: '1234, 0000 або графічний ключ',
                            controller: _passwordController,
                            isDark: isDark,
                          ),

                          const SizedBox(height: 24),
                          const Divider(height: 1),
                          const SizedBox(height: 24),

                          _buildSectionHeader(
                            'Інформація про клієнта',
                            Icons.person_outline,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Ім\'я клієнта',
                            placeholder: 'ПІБ',
                            controller: _clientNameController,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Номер телефону',
                            placeholder: '(0XX) XXX-XX-XX',
                            controller: _phoneNumberController,
                            isDark: isDark,
                            prefixIcon: Icons.call_outlined,
                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(height: 24),
                          const Divider(height: 1),
                          const SizedBox(height: 24),

                          _buildSectionHeader(
                            'Логістика',
                            Icons.engineering_outlined,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: _buildDropdown(
                                  label: 'Виконавець',
                                  value: _assignedWorker,
                                  items: [
                                    'Marcus Thorne',
                                    'Sarah Jenkins',
                                    'Не призначено',
                                  ],
                                  onChanged: (val) {},
                                  isDark: isDark,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: _buildTextField(
                                  label: 'Вартість',
                                  placeholder: '0.00',
                                  controller: _priceController,
                                  isDark: isDark,
                                  prefixText: '₴ ',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 100,
                          ), // Space for sticky bottom button
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom > 0
          ? null
          : _buildCreateButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.backgroundDark.withValues(alpha: 0.95)
            : AppColors.backgroundLight.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            style: IconButton.styleFrom(
              backgroundColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.05),
            ),
          ),
          const Text(
            'Новий талон на ремонт',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 48,
            child: Icon(Icons.pets, color: AppColors.primary, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSelection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Початковий статус',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children:
                  [
                    RepairStatus.received,
                    RepairStatus.inProgress,
                    RepairStatus.waiting,
                    RepairStatus.ready,
                  ].map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: StatusChip(
                        status: status,
                        isSelected: _selectedStatus == status,
                        onTap: () => setState(() => _selectedStatus = status),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required bool isDark,
    int maxLines = 1,
    IconData? prefixIcon,
    String? prefixText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[300] : AppColors.textLight,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: isDark ? Colors.grey[600] : const Color(0xFF8C7B5F),
              fontWeight: FontWeight.normal,
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
            prefix: prefixText != null
                ? Text(
                    prefixText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : null,
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFFE6E2DB),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFFE6E2DB),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[300] : AppColors.textLight,
            ),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textLight,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFFE6E2DB),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFFE6E2DB),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.backgroundDark.withValues(alpha: 0.8)
            : AppColors.backgroundLight.withValues(alpha: 0.8),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleType(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.2),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline),
            SizedBox(width: 8),
            Text(
              'Створити талон',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper to fix ElevatedButton shape error if any
class RoundedRectangleType extends RoundedRectangleBorder {
  const RoundedRectangleType({super.side, super.borderRadius});
}
