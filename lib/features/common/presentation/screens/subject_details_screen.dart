import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';

class SubjectDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> subjectData;
  final bool isGuest;
  final String? userRole;

  const SubjectDetailsScreen({
    super.key,
    required this.subjectData,
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
            _buildHeader(context),
            const SizedBox(height: 50),
            _buildDescription(),
            const SizedBox(height: 30),
            _buildTrainerRow(),
            if (isStaff) ...[
              const SizedBox(height: 30),
              _buildManagementSection(),
            ],
            const SizedBox(height: 30),
            _buildLessonsList(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 240, // Reduced from 320
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.amber, width: 2),
            image: const DecorationImage(
              image: AssetImage('assets/3مواد.png'), 
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Title on the Right (RTL)
        Positioned(
          top: 35,
          right: 40,
          child: Text(
            subjectData['title'] ?? "UI UX",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        // Back Button on the Left (RTL)
        Positioned(
          top: 30,
          left: 35,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 5)
              ]
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDEE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Info Section on the Right (RTL)
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 5),
                    const Text("4.5", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                // Title and Time on the Left in the card but aligned Right to Left
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // RTL Alignment
                  children: [
                    Text(
                      subjectData['title'] ?? "UI UX",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("120h", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        SizedBox(width: 5),
                        Icon(Icons.access_time, size: 14, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        "تركز مادة UI/UX على إنشاء واجهات تفاعلية تلبي احتياجات المستخدم، وتحسن سهولة الاستخدام وجودة التجربة الرقمية بأسلوب حديث ومبتكر",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          height: 1.6,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTrainerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("م.زهرة العبدالله", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("trainer.zahra@gmail.com", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/مدرب6.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
      ),
    );
  }

  Widget _mgmtCard(String desc, String btn, IconData icon, Color color) {
    return Container(
      width: 105,
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

  Widget _buildLessonsList() {
    return Column(
      children: List.generate(4, (index) => _buildLessonItem("مدخل إلى عالم فيغما")),
    );
  }

  Widget _buildLessonItem(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFF9E8A2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_downward, size: 16, color: Colors.black87),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(width: 10),
          const Icon(Icons.language, color: Colors.black54, size: 20),
        ],
      ),
    );
  }
}
