import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class TeamMember {
  final String name;
  final String phone;
  final String initials;
  final Color avatarBg;
  final Color avatarText;
  final String role;
  final bool isInvited;

  const TeamMember({
    required this.name,
    required this.phone,
    required this.initials,
    required this.avatarBg,
    required this.avatarText,
    required this.role,
    this.isInvited = false,
  });
}

class TeamManagementPage extends StatefulWidget {
  final VoidCallback onBack;

  const TeamManagementPage({super.key, required this.onBack});

  @override
  State<TeamManagementPage> createState() => _TeamManagementPageState();
}

class _TeamManagementPageState extends State<TeamManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<TeamMember> _allMembers = [
    const TeamMember(
      name: 'Yuriy Kolomiiets',
      phone: '+380 99 123 45 67',
      initials: 'YK',
      avatarBg: Color(0xFFE5E7EB),
      avatarText: Color(0xFF4B5563),
      role: 'Admin',
    ),
    const TeamMember(
      name: 'John Doe',
      phone: '+380 97 765 43 21',
      initials: 'JD',
      avatarBg: Color(0xFFDBEAFE),
      avatarText: Color(0xFF2563EB),
      role: 'Pending',
    ),
    const TeamMember(
      name: 'Sarah Miller',
      phone: '+380 66 111 22 33',
      initials: 'SM',
      avatarBg: Color(0xFFF3E8FF),
      avatarText: Color(0xFF9333EA),
      role: 'Pending',
    ),
    const TeamMember(
      name: 'Alex Lee',
      phone: '+380 93 444 55 66',
      initials: 'AL',
      avatarBg: Color(0xFFFFEDD5),
      avatarText: Color(0xFFEA580C),
      role: 'Pending',
    ),
    const TeamMember(
      name: 'Invited User',
      phone: '+380 50 888 99 00',
      initials: '',
      avatarBg: Color(0xFFF3F4F6),
      avatarText: Color(0xFF9CA3AF),
      role: 'Pending',
      isInvited: true,
    ),
  ];

  List<TeamMember> get _filteredMembers {
    if (_searchQuery.isEmpty) return _allMembers;
    final query = _searchQuery.toLowerCase();
    return _allMembers
        .where((m) => m.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(context, isDark),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(isDark),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 12),
                    child: Text(
                      'TEAM MEMBERS (${_filteredMembers.length})',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredMembers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildMemberTile(_filteredMembers[index], isDark);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBack,
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 8),
          const Text(
            'Team Management',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
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
          hintText: 'Search technician...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildMemberTile(TeamMember member, bool isDark) {
    final isAdmin = member.role == 'Admin';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFE6E2DB),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: member.avatarBg,
              shape: BoxShape.circle,
              border: member.isInvited
                  ? Border.all(
                      color: Colors.grey[300]!,
                      style: BorderStyle
                          .none, // Can't easily do dashed in CSS/Flutter without custom painter
                    )
                  : null,
            ),
            child: Center(
              child: member.isInvited
                  ? Icon(Icons.person, color: member.avatarText, size: 20)
                  : Text(
                      member.initials,
                      style: TextStyle(
                        color: member.avatarText,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  member.phone,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _buildRoleSelector(isAdmin, isDark),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline, size: 20),
            color: AppColors.danger,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelector(bool isAdmin, bool isDark) {
    final bgColor = isAdmin ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2);
    final textColor = isAdmin
        ? const Color(0xFF166534)
        : const Color(0xFF991B1B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isAdmin ? 'ADMIN' : 'PENDING',
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.expand_more, size: 14, color: textColor),
        ],
      ),
    );
  }
}
