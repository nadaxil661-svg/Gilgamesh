import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';

class GradesScreen extends StatelessWidget {
  final bool isGuest;
  final String? userRole;
  const GradesScreen({super.key, this.isGuest = false, this.userRole});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> grades = [
      {"title": "UI UX", "grade": 95, "status": "ممتاز", "date": "20 يونيو", "color": Colors.green},
      {"title": "معلوماتية", "grade": 50, "status": "راسب", "date": "18 يونيو", "color": Colors.red},
      {"title": "ثقافة", "grade": 70, "status": "جيد", "date": "1 يونيو", "color": Colors.orange},
      {"title": "مونتاج", "grade": 80, "status": "جيد جداً", "date": "19 يونيو", "color": Colors.orange},
      {"title": "فوتوشوب", "grade": 90, "status": "ممتاز", "date": "7 يونيو", "color": Colors.green},
      {"title": "تصوير", "grade": 85, "status": "جيد", "date": "4 يونيو", "color": Colors.orange},
      {"title": "رسم", "grade": 88, "status": "جيد جداً", "date": "10 يونيو", "color": Colors.orange},
      {"title": "اليستريتر", "grade": 94, "status": "ممتاز", "date": "8 يونيو", "color": Colors.green},
    ];

    return AppScaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 55),
                _buildSectionTitle("تفاصيل المواد الدراسية"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: grades.length,
                    itemBuilder: (context, index) => _buildGradeCard(grades[index]),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          if (isGuest) _buildGuestOverlay(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(25, 55, 25, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("نتائجك الدراسية", 
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                      Text("إحصائيات الفصل الحالي 2025/2026", 
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -35,
          left: 20,
          right: 20,
          child: Row(
            children: [
              _buildSummaryCard("المواد", "8", Icons.book_rounded, Colors.blue),
              const SizedBox(width: 10),
              _buildSummaryCard("الأعلى", "100%", Icons.star_rounded, Colors.green),
              const SizedBox(width: 10),
              _buildSummaryCard("الأدنى", "50%", Icons.trending_down, Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05), 
              blurRadius: 10, 
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(title, 
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
      ),
    );
  }

  Widget _buildGradeCard(Map<String, dynamic> item) {
    Color itemColor = item['color'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.015), blurRadius: 10)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item['title'], 
            textAlign: TextAlign.center, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 55,
                height: 55,
                child: CircularProgressIndicator(
                  value: item['grade'] / 100,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey.shade50,
                  valueColor: AlwaysStoppedAnimation<Color>(itemColor),
                ),
              ),
              Text("${item['grade']}%", 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: itemColor.withValues(alpha: 0.1), 
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(item['status'], 
              style: TextStyle(color: itemColor, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestOverlay() {
    return Container(
      color: Colors.white.withValues(alpha: 0.85),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_person_rounded, size: 70, color: AppColors.primary),
            SizedBox(height: 20),
            Text("هذه البيانات متاحة للطلاب فقط", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("يرجى تسجيل الدخول كطالب لرؤية درجاتك", 
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
