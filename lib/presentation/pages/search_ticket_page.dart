import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/ticket.dart';
import '../widgets/repair_tile.dart';

class SearchTicketPage extends StatefulWidget {
  const SearchTicketPage({super.key});

  @override
  State<SearchTicketPage> createState() => _SearchTicketPageState();
}

class _SearchTicketPageState extends State<SearchTicketPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<RepairTicket> _allTickets = [
    const RepairTicket(
      id: 'REP-2024-89',
      deviceName: 'iPhone 13 Pro',
      category: 'Screen Replacement',
      status: RepairStatus.inProgress,
      icon: Icons.smartphone_outlined,
      clientName: 'John Doe',
      clientPhone: '+1 (555) 882-1920',
      technician: 'Mike S.',
      technicianName: 'Mike Stevenson',
      price: 145.00,
      createdAt: 'Oct 24, 2024',
      description:
          'Screen cracked on the upper right corner after drop. Battery health is at 78%, client requested replacement if possible within budget.',
    ),
    const RepairTicket(
      id: 'REP-2024-82',
      deviceName: 'MacBook Air M1',
      category: 'Battery Service',
      status: RepairStatus.ready,
      icon: Icons.laptop_mac_outlined,
      clientName: 'Sarah Jenkins',
      technician: 'Alex R.',
      price: 280.00,
    ),
    const RepairTicket(
      id: 'REP-2024-75',
      deviceName: 'Samsung Galaxy S22',
      category: 'Charging Port',
      status: RepairStatus.waiting,
      icon: Icons.smartphone_outlined,
      clientName: 'David Lee',
      technician: 'Mike S.',
      price: 85.00,
    ),
  ];

  List<RepairTicket> get _filteredResults {
    if (_searchQuery.isEmpty) return _allTickets;
    final query = _searchQuery.toLowerCase();
    return _allTickets.where((t) {
      return t.id.toLowerCase().contains(query) ||
          t.deviceName.toLowerCase().contains(query) ||
          (t.clientName?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            // Sticky App Bar
            _buildAppBar(context, isDark),

            // Search Input
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSearchBar(isDark),
            ),

            // Filter Chips
            _buildFilterChips(isDark),

            // Section Header
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 8, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ОСТАННІ РЕЗУЛЬТАТИ (${_filteredResults.length})',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            // Results List
            Expanded(
              child: _filteredResults.isEmpty
                  ? _buildEmptyState(isDark)
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      itemCount: _filteredResults.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return RepairTile(
                          ticket: _filteredResults[index],
                          showDetails: true,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              style: IconButton.styleFrom(
                highlightColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
              ),
            ),
          ),
          const Text(
            'Знайти ремонт',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark
            : Colors.white, // gray-800 or white
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : const Color(0xFFF3F4F6),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Пошук за ID, клієнтом або пристроєм...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilterChips(bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          _buildFilterChip('Статус: В роботі', isDark, isActive: true),
          const SizedBox(width: 8),
          _buildFilterChip('Виконавець: Будь-хто', isDark),
          const SizedBox(width: 8),
          _buildFilterChip('Дата: Останні 30 днів', isDark),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isDark, {bool isActive = false}) {
    return Container(
      height: 36,
      padding: const EdgeInsets.only(left: 16, right: 12),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.1)
            : (isDark ? AppColors.surfaceDark : Colors.white),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isActive
              ? AppColors.primary
              : (isDark ? Colors.grey[700]! : const Color(0xFFE5E7EB)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive)
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  color: isDark ? Colors.white : Colors.black87,
                ),
                children: const [
                  TextSpan(text: 'Статус: '),
                  TextSpan(
                    text: 'В роботі',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.grey[300] : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            size: 20,
            color: isActive ? AppColors.primary : Colors.grey[500],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : const Color(0xFFF3F4F6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
          ),
          const SizedBox(height: 16),
          const Text(
            'Талонів не знайдено',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Спробуйте змінити фільтри або пошукати за іншим ID чи іменем клієнта.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() => _searchQuery = '');
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Очистити всі фільтри',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
