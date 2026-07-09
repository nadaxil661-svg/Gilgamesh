import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/auth_service.dart';

class SupervisorDashboard extends StatelessWidget {
  const SupervisorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "لوحة تحكم المشرف",
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
            _buildActionCard("متابعة غياب الطلاب", Icons.calendar_today, Colors.blue),
            const SizedBox(height: 20),
            _buildActionCard("إدخال العلامات", Icons.edit_note, Colors.orange),
            const SizedBox(height: 20),
            _buildActionCard("التواصل مع المدربين", Icons.chat, Colors.green),
            const SizedBox(height: 40),
            const Text(
              "أهلاً بك أيها المشرف. مهمتك هي التأكد من سير العملية التعليمية بنجاح.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color) {
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
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 20),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
