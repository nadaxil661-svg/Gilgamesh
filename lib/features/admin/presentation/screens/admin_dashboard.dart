import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/auth_service.dart';
import 'add_supervisor_screen.dart';
import 'add_student_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "لوحة تحكم المدير",
      actions: [
        IconButton(
          onPressed: () async {
            await AuthService().signOut();
          },
          icon: const Icon(Icons.logout, color: Colors.red),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildStatCard("إجمالي الطلاب", "150", Icons.people, Colors.blue),
            const SizedBox(height: 20),
            _buildStatCard("إجمالي المشرفين", "12", Icons.admin_panel_settings, Colors.green),
            const SizedBox(height: 20),
            _buildStatCard("الدورات النشطة", "25", Icons.book, Colors.orange),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "الإدارة",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "إضافة مشرف جديد",
              Icons.person_add,
              Colors.amber,
              () => Navigator.push(context, MaterialPageRoute(builder: (c) => const AddSupervisorScreen())),
            ),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "إضافة طالب جديد",
              Icons.group_add,
              Colors.blue,
              () => Navigator.push(context, MaterialPageRoute(builder: (c) => const AddStudentScreen())),
            ),
            const SizedBox(height: 40),
            const Text(
              "مرحباً بك أيها المدير. يمكنك هنا إدارة النظام بالكامل.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
