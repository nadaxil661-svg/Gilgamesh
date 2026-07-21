import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../supervisor/presentation/screens/students_list_screen.dart';
import '../../../student/presentation/screens/schedule_screen.dart';
import '../../../supervisor/presentation/screens/trainer_profile_screen.dart';
import 'subject_details_screen.dart';

class DiplomaDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> diplomaData;
  final bool isGuest;
  final String? userRole;

  const DiplomaDetailsScreen({
    super.key, 
    required this.diplomaData, 
    this.isGuest = false,
    this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    bool isStaff = userRole == 'admin' || userRole == 'supervisor';

    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isStaff) _buildStaffHeader(context) else _buildHeader(context),
            if (isStaff) _buildStaffBody(context) else _buildStudentBody(context),
          ],
        ),
      ),
    );
  }

  // --- Common Body Sections ---

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

  // --- Student/Guest Layout ---

  Widget _buildStudentBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: isGuest ? 20 : 160),
        _buildSectionTitle("مواد السنة الأولى"),
        _buildSubjectsList(context),
        const SizedBox(height: 30),
        _buildSectionTitle("المدربين"),
        _buildTrainersList(context),
        const SizedBox(height: 30),
        _buildPlanningCard(context),
        const SizedBox(height: 30),
        _buildStudentsButton(context),
        const SizedBox(height: 30),
      ],
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
        if (!isGuest)
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
                          Text(diplomaData['title'] ?? "", 
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

  // --- Staff Layout ---

  Widget _buildStaffHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFE500), Color(0xFFFFF7AD)],
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
          top: 80,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.92,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15)
              ],
            ),
            child: Column(
              children: [
                Text(diplomaData['title'] ?? "التصميم والتسويق الإعلاني", 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _staffStatItem("عدد الطلاب", "45 طالب", Icons.group_outlined),
                    Container(width: 1, height: 30, color: Colors.grey.shade200),
                    _staffStatItem("نسبة النجاح", "87%", Icons.trending_up),
                    Container(width: 1, height: 30, color: Colors.grey.shade200),
                    _staffStatItem("عدد الشعب", "3", Icons.assignment_outlined),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _staffStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber, size: 20),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }

  Widget _buildStaffBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 120),
        _buildStaffActionCards(),
        const SizedBox(height: 25),
        _buildLargeManagementButtons(context),
        const SizedBox(height: 30),
        _buildSectionTitle("مواد السنة الأولى"),
        _buildStaffSubjectsList(context),
        const SizedBox(height: 30),
        _buildSectionTitle("المدربين"),
        _buildStaffTrainersList(context),
        const SizedBox(height: 30),
        _buildExamScheduleButton(),
        const SizedBox(height: 20),
        _buildStaffGlobalActions(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildStaffActionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _staffActionCard("إضافة مادة", Icons.add, () {}),
          _staffActionCard("إضافة مدرب", Icons.person_add_alt_1_outlined, () {}),
          _staffActionCard("تعديل الدبلوم", Icons.edit_outlined, () {}),
        ],
      ),
    );
  }

  Widget _staffActionCard(String label, IconData icon, VoidCallback onTap) {
    return Container(
      width: 105,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber, size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLargeManagementButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (c) => ScheduleScreen(isGuest: false, userRole: userRole))),
              child: _largeManagementCard("إدارة الجدول", Icons.calendar_month_outlined),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(child: _largeManagementCard("العلامات", Icons.show_chart)),
        ],
      ),
    );
  }

  Widget _largeManagementCard(String label, IconData icon) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.red.shade300, size: 30),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildStaffSubjectsList(BuildContext context) {
    final subjects = [
      {"title": "فوتوشوب", "img": "assets/مواد1.png"},
      {"title": "اليستريتر", "img": "assets/2مواد.png"},
      {"title": "UI UX", "img": "assets/3مواد.png"},
    ];
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: subjects.length,
        itemBuilder: (context, index) => Container(
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(subjects[index]["img"]!, height: 40),
              const SizedBox(height: 8),
              Text(subjects[index]["title"]!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaffTrainersList(BuildContext context) {
    final trainers = [
      {"name": "حلا محمد", "job": "تسويق رقمي", "img": "assets/مدرب4.png"},
      {"name": "زهرة العبدالله", "job": "UI UX", "img": "assets/مدرب6.png"},
      {"name": "ريان السالم", "job": "معلوماتية", "img": "assets/مدرب2.png"},
    ];
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: trainers.length,
        itemBuilder: (context, index) => Container(
          width: 110,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              CircleAvatar(radius: 35, backgroundImage: AssetImage(trainers[index]["img"]!)),
              const SizedBox(height: 8),
              Text(trainers[index]["name"]!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              Text(trainers[index]["job"]!, style: const TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExamScheduleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: const Center(
          child: Text("جدول الامتحانات", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
      ),
    );
  }

  Widget _buildStaffGlobalActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: _actionBtn("تعديل", Icons.edit, Colors.green.shade50, Colors.green)),
          const SizedBox(width: 15),
          Expanded(child: _actionBtn("حذف", Icons.delete_outline, Colors.red.shade50, Colors.red)),
        ],
      ),
    );
  }

  Widget _actionBtn(String l, IconData i, Color bg, Color c) => Container(
    height: 55,
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l, style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 10),
        Icon(i, color: c, size: 24),
      ],
    ),
  );

  // --- Common Helpers ---

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
        MaterialPageRoute(builder: (c) => SubjectDetailsScreen(subjectData: {
          "title": title, "price": "250", "rating": "4.5", "duration": "40 h",
        }, isGuest: isGuest, userRole: userRole))),
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
    if (isGuest) return const SizedBox.shrink();
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
    if (isGuest) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (c) => StudentsListScreen(userRole: userRole))),
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
