import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../shared/widgets/loading_screen.dart';
import 'login_screen.dart';
import '../../../home/presentation/screens/navigation_wrapper.dart';
import '../../../admin/presentation/screens/admin_dashboard.dart';
import '../../../supervisor/presentation/screens/supervisor_dashboard.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // حالة التحميل الأولية من Firebase
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        final user = snapshot.data;

        // إذا لم يكن هناك مستخدم مسجل دخول، اذهب لصفحة تسجيل الدخول
        if (user == null) {
          return const LoginScreen();
        }

        // إذا كان هناك مستخدم، جلب دوره من Firestore
        return FutureBuilder<String?>(
          future: authService.getUserRole(user.uid),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen(message: "جاري تحميل البيانات...");
            }

            final role = roleSnapshot.data;

            // توجيه المستخدم حسب دوره
            if (role == 'admin') {
              return const AdminDashboard();
            } else if (role == 'supervisor') {
              return const SupervisorDashboard();
            } else {
              // الافتراضي هو طالب
              return const NavigationWrapper(isGuest: false);
            }
          },
        );
      },
    );
  }
}
