import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/screens/navigation_wrapper.dart';

class StudentsListScreen extends StatelessWidget {
  final bool isGuest;
  final String? userRole;
  const StudentsListScreen({super.key, this.isGuest = false, this.userRole});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'قائمة الطلاب',
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28), 
        onPressed: () => Navigator.pop(context)
      ),
      body: _buildList(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0, 
        isGuest: isGuest,
        onTap: (idx) => Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(builder: (c) => NavigationWrapper(initialIndex: idx, isGuest: isGuest)), 
          (r) => false
        ),
      ),
    );
  }

  Widget _buildList() {
    final List<Map<String, String>> students = [
      {'name': 'شهد فهد', 'email': 'shahed.f@student.edu', 'img': 'assets/طالب1.png'},
      {'name': 'سارة  خليل', 'email': 'dana.k@student.edu', 'img': 'assets/طالب2.png'},
      {'name': 'ساري  صليبي', 'email': 'dana.k@student.edu', 'img': 'assets/طالب3.png'},
      {'name': 'هادي  النوار', 'email': 'dana.k@student.edu', 'img': 'assets/طالب4.png'},
      {'name': 'لانا  غيث', 'email': 'dana.k@student.edu', 'img': 'assets/طالب6.png'},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(15), 
      itemCount: students.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 15), 
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(20), 
          border: Border.all(color: Colors.grey.shade50), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02), 
              blurRadius: 10, offset: const Offset(0, 5),
            )
          ]
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 28, backgroundImage: AssetImage(students[index]['img']!)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Text(students[index]['name']!, 
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)), 
                      Text(students[index]['email']!, 
                        style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.phone_enabled, color: AppColors.primary),
              ],
            ),
            if (userRole == 'admin' || userRole == 'supervisor') ...[
              const SizedBox(height: 15),
              _buildActionButtons(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _actionButton("تعديل", Icons.edit, const Color(0xFFE8F5E9), Colors.green),
        const SizedBox(width: 10),
        _actionButton("حذف", Icons.delete_outline, const Color(0xFFFFEBEE), Colors.red),
      ],
    );
  }

  Widget _actionButton(String label, IconData icon, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 5),
          Icon(icon, color: color, size: 16),
        ],
      ),
    );
  }
}
