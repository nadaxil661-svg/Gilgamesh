import 'package:flutter/material.dart';
import '../academy/home_screen.dart';
import 'schedule_screen.dart';
import 'settings_screen.dart';
import 'grades_screen.dart';

/// مغلف التنقل الرئيسي (Shell)
/// يدعم وضع الطالب (كل شيء متاح) ووضع الزائر (أزرار معطلة ومموهة)
class NavigationWrapper extends StatefulWidget {
  final int initialIndex;
  final bool isGuest;

  const NavigationWrapper({
    super.key, 
    this.initialIndex = 0, 
    this.isGuest = false,
  });

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex > 3 ? 0 : widget.initialIndex;
  }

  // الترتيب البصري: الرئيسية -> العلامات -> الجدول -> الإعدادات
  List<Widget> get _screens => [
    AcademyHomeScreen(isGuest: widget.isGuest),
    GradesScreen(isGuest: widget.isGuest),
    ScheduleScreen(isGuest: widget.isGuest),
    SettingsScreen(isGuest: widget.isGuest),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        isGuest: widget.isGuest,
        onTap: (index) {
          // للزائر: منع الانتقال للتبويبات المحظورة (العلامات والجدول)
          if (widget.isGuest && (index == 1 || index == 2)) return;
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}

/// ويدجت شريط التنقل السفلي الموحد (الترتيب من اليسار لليمين LTR)
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final bool isGuest;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key, 
    required this.selectedIndex, 
    required this.onTap,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, -5))],
      ),
      child: Directionality(
        textDirection: TextDirection.ltr, // لضمان الترتيب من اليسار لليمين
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_filled, "الرئيسية"),
            _buildNavItem(1, Icons.workspace_premium_outlined, "العلامات", isRestricted: isGuest),
            _buildNavItem(2, Icons.calendar_month_outlined, "الجدول", isRestricted: isGuest),
            _buildNavItem(3, Icons.settings_outlined, "الإعدادات"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, {bool isRestricted = false}) {
    bool isSelected = selectedIndex == index;
    double opacity = isRestricted ? 0.2 : 1.0;

    return GestureDetector(
      onTap: isRestricted ? null : () => onTap(index),
      child: Opacity(
        opacity: opacity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFFFBEC21) : Colors.grey.shade100,
              ),
              child: Icon(icon, color: isSelected ? Colors.white : Colors.grey.shade600, size: 28),
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, color: isSelected ? const Color(0xFFFCC218) : Colors.grey, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
