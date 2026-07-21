import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import 'home_screen.dart';
import '../../../student/presentation/screens/grades_screen.dart';
import '../../../student/presentation/screens/schedule_screen.dart';
import '../../../common/presentation/screens/settings_screen.dart';

import '../../../supervisor/presentation/screens/supervisor_dashboard.dart';
import '../../../supervisor/presentation/screens/trainers_list_screen.dart';
import '../../../supervisor/presentation/screens/students_list_screen.dart';
import '../../../supervisor/presentation/screens/attendance_screen.dart';
import '../../../supervisor/presentation/screens/supervisor_profile_screen.dart';
import '../../../student/presentation/screens/profile_screen.dart';
import '../../../student/presentation/screens/grades_screen.dart';

class NavigationWrapper extends StatefulWidget {
  final int initialIndex;
  final bool isGuest;
  final String? userRole;

  const NavigationWrapper({
    super.key, 
    this.initialIndex = 0, 
    this.isGuest = false,
    this.userRole,
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

  List<Widget> get _screens {
    if (widget.userRole == 'admin' || widget.userRole == 'supervisor') {
      return [
        SupervisorDashboard(
          userRole: widget.userRole,
          onProfileTap: () => setState(() => _selectedIndex = 4),
        ),
        StudentsListScreen(userRole: widget.userRole),
        const AttendanceScreen(),
        GradesScreen(isGuest: false, userRole: widget.userRole),
        const SupervisorProfileScreen(),
      ];
    }
    return [
      AcademyHomeScreen(isGuest: widget.isGuest, userRole: widget.userRole),
      GradesScreen(isGuest: widget.isGuest),
      ScheduleScreen(isGuest: widget.isGuest),
      SettingsScreen(isGuest: widget.isGuest),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isStaff = widget.userRole == 'admin' || widget.userRole == 'supervisor';
    int maxIndex = isStaff ? 4 : 3;
    int currentIdx = _selectedIndex > maxIndex ? 0 : _selectedIndex;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _screens[currentIdx],
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: currentIdx,
          isGuest: widget.isGuest,
          userRole: widget.userRole,
          onTap: (index) {
            if (!isStaff && widget.isGuest && (index == 1 || index == 2)) return;
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }
}
