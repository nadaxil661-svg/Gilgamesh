import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import 'course_details_screen.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> courses = [
      {"title": "إدارة مكاتب", "cert": "شهادة معتمدة", "duration": "40h", "rating": "3.8", "price": "250\$", "progress": 0.65, "percent": "65%", "img": "assets/سسس.png"},
      {"title": "باريستا", "cert": "شهادة معتمدة", "duration": "40h", "rating": "3.3", "price": "250\$", "progress": 0.5, "percent": "50%", "img": "assets/d2.png"},
      {"title": "لغة إنكليزية", "cert": "شهادة معتمدة", "duration": "60h", "rating": "4.3", "price": "300\$", "progress": 0.9, "percent": "90%", "img": "assets/3دورات.png"},
      {"title": "مونتاج", "cert": "شهادة معتمدة", "duration": "50h", "rating": "4.5", "price": "300\$", "progress": 0.75, "percent": "75%", "img": "assets/ششش.png"},
      {"title": "تغذية", "cert": "شهادة معتمدة", "duration": "40h", "rating": "4.2", "price": "250\$", "progress": 0.45, "percent": "45%", "img": "assets/دورات8.png"},
      {"title": "ذكاء إصطناعي", "cert": "شهادة معتمدة", "duration": "60h", "rating": "4.9", "price": "275\$", "progress": 0.95, "percent": "95%", "img": "assets/دورات9.png"},
    ];

    return AppScaffold(
      title: "الدورات المتاحة",
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        onPressed: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, 
              MaterialPageRoute(builder: (c) => CourseDetailsScreen(courseData: course))),
            child: _buildCourseCard(course),
          );
        },
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Container(
      height: 125,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04), 
            blurRadius: 15, offset: const Offset(0, 8),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildCourseImage(course['img']),
            const SizedBox(width: 15),
            Expanded(child: _buildCourseInfo(course)),
            const SizedBox(width: 10),
            _buildPrice(course['price']),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseImage(String? imagePath) {
    return Container(
      width: 95,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 1.5),
        image: DecorationImage(
          image: AssetImage(imagePath ?? 'assets/1ورات.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCourseInfo(Map<String, dynamic> course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(course['title'], 
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(course['cert'], 
          style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildSmallIconStat(Icons.access_time, course['duration'], Colors.grey),
            const SizedBox(width: 12),
            _buildSmallIconStat(Icons.star, course['rating'], Colors.amber),
          ],
        ),
        const SizedBox(height: 8),
        _buildProgressBar(course['progress'], course['percent']),
      ],
    );
  }

  Widget _buildSmallIconStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildProgressBar(double progress, String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade100,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(String price) {
    return Text(price, 
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87));
  }
}
