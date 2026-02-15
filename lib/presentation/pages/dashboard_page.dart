import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/ticket.dart';
import '../widgets/repair_tile.dart';
import 'create_ticket_page.dart';
import 'search_ticket_page.dart';
import 'admin_profile_page.dart';

import 'team_management_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  bool _isAdminSubPage = false;

  final List<RepairTicket> _recentTickets = [
    const RepairTicket(
      id: 'R-1092',
      deviceName: 'iPhone 13 Pro',
      category: 'Screen Replacement',
      status: RepairStatus.inProgress,
      icon: Icons.smartphone_outlined,
      price: 145.00,
      clientName: 'John Doe',
      clientPhone: '+1 (555) 882-1920',
      technician: 'Mike S.',
      technicianName: 'Mike Stevenson',
      createdAt: 'Oct 24, 2024',
      description:
          'Screen cracked on the upper right corner after drop. Battery health is at 78%, client requested replacement if possible within budget.',
    ),
    const RepairTicket(
      id: 'R-1091',
      deviceName: 'MacBook Air M2',
      category: 'Liquid Damage',
      status: RepairStatus.inProgress,
      icon: Icons.laptop_mac_outlined,
      price: 280.00,
      clientName: 'Sarah Jenkins',
      technician: 'Alex R.',
    ),
    const RepairTicket(
      id: 'R-1088',
      deviceName: 'iPad Pro 11"',
      category: 'Battery Service',
      status: RepairStatus.ready,
      icon: Icons.tablet_mac_outlined,
      price: 99.00,
      clientName: 'David Lee',
      technician: 'Mike S.',
    ),
    const RepairTicket(
      id: 'R-1085',
      deviceName: 'AirPods Max',
      category: 'Connectivity Issue',
      status: RepairStatus.waiting,
      icon: Icons.headphones_outlined,
      price: 45.00,
      clientName: 'Emma Wilson',
      technician: 'Alex R.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _buildBody(isDark),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildBody(bool isDark) {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardHome(isDark);
      case 1:
        return const Center(child: Text('Orders Screen (Coming Soon)'));
      case 2:
        return _isAdminSubPage
            ? TeamManagementPage(
                onBack: () => setState(() => _isAdminSubPage = false),
              )
            : AdminProfilePage(
                onTeamManagement: () => setState(() => _isAdminSubPage = true),
              );
      default:
        return _buildDashboardHome(isDark);
    }
  }

  Widget _buildDashboardHome(bool isDark) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Repair Service',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateTicketPage(),
                      ),
                    ),
                    child: _buildActionButton(
                      context,
                      label: 'New Ticket',
                      sublabel: 'Create entry',
                      icon: Icons.add,
                      color: AppColors.primary,
                      textColor: AppColors.textLight,
                      isDark: isDark,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchTicketPage(),
                      ),
                    ),
                    child: _buildActionButton(
                      context,
                      label: 'Search',
                      sublabel: 'Find by ID',
                      icon: Icons.search,
                      color: isDark
                          ? AppColors.surfaceDark
                          : AppColors.textLight,
                      textColor: Colors.white,
                      isDark: isDark,
                      hasBorder: isDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchTicketPage(),
                    ),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recentTickets.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return RepairTile(ticket: _recentTickets[index]);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required String sublabel,
    required IconData icon,
    required Color color,
    required Color textColor,
    required bool isDark,
    bool hasBorder = false,
  }) {
    return Container(
      height: 176,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: hasBorder
            ? Border.all(color: Colors.white.withValues(alpha: 0.1))
            : null,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: textColor, size: 28),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                sublabel,
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A150B) : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.grey[200]!,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _isAdminSubPage = false;
          });
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_outlined),
            activeIcon: Icon(Icons.handyman),
            label: 'Repairs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            activeIcon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
      ),
    );
  }
}
