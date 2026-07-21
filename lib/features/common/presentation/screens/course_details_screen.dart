import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/screens/navigation_wrapper.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final bool isGuest;
  final String? userRole;

  const CourseDetailsScreen({
    super.key,
    required this.courseData,
    this.isGuest = false,
    this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    bool isStaff = userRole == 'admin' || userRole == 'supervisor';

    return AppScaffold(
      title: courseData['title'] ?? "تفاصيل الدورة",
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28), 
        onPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            _buildHeaderCard(), 
            const SizedBox(height: 30), 
            _buildTitle("حول هذه الدورة"), 
            _buildDesc(), 
            _buildTrainerRow("م. منار الأحمد", "assets/مدرب1.png"), 
            if (isStaff) ...[
              const SizedBox(height: 30),
              _buildManagementSection(),
            ],
            const SizedBox(height: 30), 
            _buildWeeksList()
          ],
        ),
      ),
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

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(15), 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(22), 
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15)
        ]
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2), 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), 
              border: Border.all(color: AppColors.primary),
            ), 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13), 
              child: Image.asset(
                courseData['img'] ?? 'assets/دورات 2.png', 
                width: 90, height: 90, fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(courseData['title'] ?? "دورة مهنية", 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
                const Text("شهادة معتمدة", 
                  style: TextStyle(fontSize: 11, color: Colors.grey)), 
                const SizedBox(height: 8), 
                LinearProgressIndicator(
                  value: 0.5, 
                  backgroundColor: Colors.grey.shade100, 
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ],
            ),
          ),
          Text(courseData['price'] ?? "250\$", 
            style: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTitle(String t) => Align(
    alignment: Alignment.centerRight, 
    child: Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
  );

  Widget _buildDesc() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 12), 
    child: Text(
      "محتوى تعليمي متطور يواكب متطلبات سوق العمل، يهدف لمساعدة الطلاب على اكتساب مهارات حقيقية وعملية في تخصصهم.", 
      style: TextStyle(fontSize: 14, height: 1.7, color: Colors.black54),
    ),
  );

  Widget _buildTrainerRow(String n, String i) => Row(
    children: [
      CircleAvatar(radius: 30, backgroundImage: AssetImage(i)), 
      const SizedBox(width: 15), 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), 
          const Text("trainer.expert@gmail.com", 
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ],
  );

  Widget _buildManagementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text("إدارة المادة", 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _mgmtCard("تعديل معلومات المادة الأساسية", "تعديل", Icons.edit_outlined, Colors.green),
            _mgmtCard("إدارة الدروس والملفات والاختبارات", "إدارة المحتوى", Icons.folder_open_outlined, Colors.amber),
            _mgmtCard("حذف المادة بشكل دائم من النظام", "حذف المادة", Icons.delete_outline, Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _mgmtCard(String desc, String btn, IconData icon, Color color) {
    return Container(
      width: 110,
      height: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withValues(alpha: 0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 28),
          Text(desc, 
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.w500)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(btn, 
              textAlign: TextAlign.center,
              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeksList() => Column(
    children: [1, 2, 3].map((i) => Container(
      margin: const EdgeInsets.only(bottom: 12), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), 
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ), 
      child: ExpansionTile(
        title: Text("الأسبوع $i", 
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), 
        children: const [
          Padding(
            padding: EdgeInsets.all(15), 
            child: Text("تفاصيل المحاضرات والمادة العلمية..."),
          )
        ],
      ),
    )).toList(),
  );
}
