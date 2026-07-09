import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../supervisor/presentation/screens/students_list_screen.dart';
import '../../../student/presentation/screens/schedule_screen.dart';
import '../../../supervisor/presentation/screens/trainer_profile_screen.dart';
import 'course_details_screen.dart';

class DiplomaDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> diplomaData;

  const DiplomaDetailsScreen({super.key, required this.diplomaData});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 160),
            _buildSectionTitle("مواد السنة الأولى"),
            _buildSubjectsList(context),
            const SizedBox(height: 30),
            _buildSectionTitle("المدربين"),
            _buildTrainersList(context),
            const SizedBox(height: 30),
            _buildPlanningCard(context),
            const SizedBox(height: 30),
            _buildStudentsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 100,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("السنة الأولى", 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(diplomaData['title'], 
                            style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.school, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text("التقدم الدراسي", 
                    style: TextStyle(fontSize: 10, color: Colors.grey)),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 8,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBadge(Icons.calendar_today, "الفصل الأول"),
                    _buildInfoBadge(Icons.people, "3 مدربين"),
                    _buildInfoBadge(Icons.book, "9 مواد"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(title, 
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDEE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF2EDBB)),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          Icon(icon, size: 14, color: Colors.amber),
        ],
      ),
    );
  }

  Widget _buildSubjectsList(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildSubjectCard(context, "فوتوشوب", "assets/مواد1.png"),
          _buildSubjectCard(context, "اليستريتر", "assets/2مواد.png"),
          _buildSubjectCard(context, "UI UX", "assets/3مواد.png"),
          _buildSubjectCard(context, "تسويق رقمي", "assets/4مواد.png"),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () => Navigator.push(context, 
        MaterialPageRoute(builder: (c) => CourseDetailsScreen(courseData: {
          "title": title, "price": "250", "rating": "4.5", "duration": "40 h",
        }))),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 45, 
              errorBuilder: (c, e, s) => const Icon(Icons.book, size: 40, color: Colors.amber)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainersList(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildTrainerSmallCard(context, "حلا محمد", "تسويق رقمي", "7+"),
          _buildTrainerSmallCard(context, "زهرة العبدالله", "UI UX", "7+"),
          _buildTrainerSmallCard(context, "ريان السالم", "معلوماتية", "7+"),
          _buildTrainerSmallCard(context, "سارة فهد", "مونتاج", "6+"),
          _buildTrainerSmallCard(context, "سيمند علي", "برمجة", "7+"),
        ],
      ),
    );
  }

  Widget _buildTrainerSmallCard(BuildContext context, String name, String job, String rating) {
    return GestureDetector(
      onTap: () => Navigator.push(context, 
        MaterialPageRoute(builder: (c) => TrainerProfileScreen(trainerData: {
          "name": name, "job": job, "rating": rating,
        }))),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/مدرب4.png'),
            ),
            const SizedBox(height: 5),
            Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text(job, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanningCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, size: 40, color: Colors.grey),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("خطط لدراستك", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text("نظم وقتك وحقق أهدافك", 
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.push(context, 
                      MaterialPageRoute(builder: (c) => const ScheduleScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chevron_left, size: 18),
                          Text("افتح جدولك الآن", 
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (c) => const StudentsListScreen())),
          icon: const Icon(Icons.people, color: Colors.black54),
          label: const Text("الطلاب", 
            style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }
}
