import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import 'diploma_details_screen.dart';

class DiplomasScreen extends StatelessWidget {
  const DiplomasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          _buildTopHeader(context),
          _buildDiplomasList(),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 15, bottom: 10),
            child: Text("الدبلومات المهنية:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiplomasList() {
    final List<Map<String, dynamic>> diplomas = [
      {'title': 'دبلوم التغذية', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '900\$', 'image': 'assets/icons/4.png', 'color': const Color(0xFFFFFDEE), 'borderColor': const Color(0xFFF2EDBB), 'accentColor': const Color(0xFFD7B94F)},
      {'title': 'دبلوم إدارة الأعمال', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '700\$', 'image': 'assets/icons/3.png', 'color': const Color(0xFFE2F0ED), 'borderColor': const Color(0xFF80BAAE), 'accentColor': const Color(0xFF74A8A1)},
      {'title': 'دبلوم تقانة المعلومات', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '700\$', 'image': 'assets/icons/6.png', 'color': const Color(0xFFF9F3E1), 'borderColor': const Color(0xFFFCE085), 'accentColor': const Color(0xFFD8BB5A)},
      {'title': 'دبلوم التصميم والتسويق', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '700\$', 'image': 'assets/icons/2.png', 'color': const Color(0xFFF0EAF3), 'borderColor': const Color(0xFFB194C0), 'accentColor': const Color(0xFFB85DDA)},
      {'title': 'دبلوم إدارة مكاتب', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '700\$', 'image': 'assets/icons/7.png', 'color': const Color(0xFFF3F7FF), 'borderColor': const Color(0xFF5573B2), 'accentColor': const Color(0xFF7088D8)},
      {'title': 'دبلوم الشيف المهني', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '900\$', 'image': 'assets/icons/1.png', 'color': const Color(0xFFF8ECEC), 'borderColor': const Color(0xFFEBB3B5), 'accentColor': const Color(0xFFD79CA5)},
      {'title': 'دبلوم المحاسبة والمالية', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '800\$', 'image': 'assets/icons/3.png', 'color': const Color(0xFFF9F9F9), 'borderColor': const Color(0xFFE0E0E0), 'accentColor': Colors.grey},
      {'title': 'دبلوم الموارد البشرية', 'duration': 'سنتان', 'subjects': '7 مواد', 'price': '750\$', 'image': 'assets/icons/4.png', 'color': const Color(0xFFE8F5E9), 'borderColor': const Color(0xFFC8E6C9), 'accentColor': Colors.green},
    ];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: diplomas.length,
        itemBuilder: (context, index) => _buildDiplomaCard(context, diplomas[index]),
      ),
    );
  }

  Widget _buildDiplomaCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => Navigator.push(context, 
        MaterialPageRoute(builder: (context) => DiplomaDetailsScreen(diplomaData: item))),
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: item['color'],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: item['borderColor'], width: 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 5))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              _buildDiplomaIcon(item['image']),
              _buildDividerLine(item['accentColor']),
              _buildDiplomaInfo(item['title'], item['duration'], item['subjects']),
              const Spacer(),
              _buildPrice(item['price']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiplomaIcon(String imagePath) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Image.asset(imagePath, fit: BoxFit.contain, 
        errorBuilder: (c, e, s) => const Icon(Icons.school, color: Colors.grey)),
    );
  }

  Widget _buildDividerLine(Color color) {
    return Container(
      width: 1.5, 
      height: 40, 
      margin: const EdgeInsets.symmetric(horizontal: 15), 
      color: color.withValues(alpha: 0.3),
    );
  }

  Widget _buildDiplomaInfo(String title, String duration, String subjects) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, 
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        Text("$duration | $subjects", 
          style: const TextStyle(fontSize: 11, color: Colors.black45)),
      ],
    );
  }

  Widget _buildPrice(String price) {
    return Text(price, 
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87));
  }
}
