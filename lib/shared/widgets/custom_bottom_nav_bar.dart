import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final bool isGuest;
  final String? userRole;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key, 
    required this.selectedIndex, 
    required this.onTap,
    this.isGuest = false,
    this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    bool isStaff = userRole == 'admin' || userRole == 'supervisor';

    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35), 
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08), 
            blurRadius: 20, 
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: isStaff ? _buildStaffItems() : _buildStudentItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStaffItems() {
    return [
      _buildNavItem(0, Icons.home_filled, "الرئيسية"),
      _buildNavItem(1, Icons.group_outlined, "الطلاب", imagePath: 'assets/icons/students_nav.png'),
      _buildNavItem(2, Icons.calendar_today_outlined, "الحضور", imagePath: 'assets/icons/attendance_nav.png'),
      _buildNavItem(3, Icons.star_border_rounded, "العلامات", imagePath: 'assets/icons/grades_nav.png'),
      _buildNavItem(4, Icons.person_outline, "الملف الشخصي"),
    ];
  }

  List<Widget> _buildStudentItems() {
    return [
      _buildNavItem(0, Icons.home_filled, "الرئيسية"),
      _buildNavItem(1, Icons.workspace_premium_outlined, "العلامات", isRestricted: isGuest),
      _buildNavItem(2, Icons.calendar_month_outlined, "الجدول", isRestricted: isGuest),
      _buildNavItem(3, Icons.settings_outlined, "الإعدادات"),
    ];
  }

  Widget _buildNavItem(int index, IconData icon, String label, {bool isRestricted = false, String? imagePath}) {
    bool isSelected = selectedIndex == index;
    double opacity = isRestricted ? 0.3 : 1.0;

    return GestureDetector(
      onTap: isRestricted ? null : () => onTap(index),
      child: Opacity(
        opacity: opacity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55, 
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFFFFE500) : const Color(0xFFF5F5F5),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: const Color(0xFFFFE500).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ] : null,
              ),
              child: imagePath != null 
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      imagePath, 
                      color: isSelected ? Colors.black : Colors.grey.shade500,
                      errorBuilder: (c, e, s) => Icon(icon, color: isSelected ? Colors.black : Colors.grey.shade500, size: 26),
                    ),
                  )
                : Icon(
                    icon, 
                    color: isSelected ? Colors.black : Colors.grey.shade500, 
                    size: 26,
                  ),
            ),
            const SizedBox(height: 5),
            Text(label, 
              style: TextStyle(
                fontSize: 9, 
                color: isSelected ? Colors.black87 : Colors.grey.shade500,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
