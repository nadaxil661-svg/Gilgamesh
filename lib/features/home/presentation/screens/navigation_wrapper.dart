import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import 'home_screen.dart';
import '../../../student/presentation/screens/grades_screen.dart';
import '../../../student/presentation/screens/schedule_screen.dart';
import '../../../common/presentation/screens/settings_screen.dart';

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

  List<Widget> get _screens => [
    AcademyHomeScreen(isGuest: widget.isGuest),
    GradesScreen(isGuest: widget.isGuest),
    ScheduleScreen(isGuest: widget.isGuest),
    SettingsScreen(isGuest: widget.isGuest),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          isGuest: widget.isGuest,
          onTap: (index) {
            if (widget.isGuest && (index == 1 || index == 2)) return;
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }
}
