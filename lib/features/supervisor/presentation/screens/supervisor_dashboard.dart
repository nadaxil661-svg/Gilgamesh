import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/auth_service.dart';
import '../../../admin/presentation/screens/add_student_screen.dart';
import 'students_list_screen.dart';
import 'trainers_list_screen.dart';
import '../../../common/presentation/screens/diplomas_screen.dart';
import '../../../common/presentation/screens/reviews_screen.dart';
import '../../../common/presentation/screens/courses_screen.dart';
import '../../../common/presentation/screens/course_details_screen.dart';

class SupervisorDashboard extends StatelessWidget {
  final String? userRole;
  final VoidCallback? onProfileTap;
  const SupervisorDashboard({super.key, this.userRole, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 25),
            _buildSearchField(),
            const SizedBox(height: 30),
            _buildStatsGrid(),
            const SizedBox(height: 30),
            _buildSectionHeader(context, "الدبلومات المهنية:", const DiplomasScreen()),
            _buildDiplomasList(context),
            const SizedBox(height: 25),
            _buildSectionHeader(context, "المدربين", const TrainersListScreen()),
            _buildTrainersList(context),
            const SizedBox(height: 25),
            _buildSectionHeader(context, "الدورات", const CoursesScreen()),
            _buildCoursesList(context),
            const SizedBox(height: 25),
            _buildSectionHeader(context, "آراء الطلاب", const ReviewsScreen()),
            _buildReviewsList(),
            const SizedBox(height: 30),
            _buildGlobalActions(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFE500), Color(0xFFFFF7AD)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onProfileTap,
              child: const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/ola.png'),
                ),
              ),
            ),
            const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.wb_sunny_outlined, color: Colors.orange, size: 18),
                    SizedBox(width: 5),
                    Text("صباح الخير يا علا", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text("مرحباً بك في لوحة تحكم المشرف", 
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
            IconButton(
              onPressed: () => AuthService().signOut(),
              icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
          ],
        ),
        child: const TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "بحث",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 26),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem("عدد الدورات", "8", Icons.book, Colors.amber),
          _buildStatItem("عدد الدبلومات", "6", Icons.school, Colors.amber),
          _buildStatItem("عدد الطلاب", "241", Icons.people, Colors.amber),
          _buildStatItem("عدد المدربين", "82", Icons.person, Colors.amber),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(label, 
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
            child: const Text("رؤية المزيد", 
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildDiplomasList(BuildContext context) {
    final diplomas = [
      {"title": "التصميم والتسويق الإعلاني", "icon": "assets/icons/1.png", "color": const Color(0xFFF0EAF3)},
      {"title": "الشيف", "icon": "assets/icons/2.png", "color": const Color(0xFFF8ECEC)},
      {"title": "التغذية", "icon": "assets/icons/3.png", "color": const Color(0xFFFFFDEE)},
    ];
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: diplomas.length,
        itemBuilder: (context, index) {
          final item = diplomas[index];
          return Container(
            width: 110,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: item["color"] as Color, 
              borderRadius: BorderRadius.circular(15), 
              border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(item["icon"] as String, height: 40),
                const SizedBox(height: 8),
                Text(item["title"] as String, 
                  textAlign: TextAlign.center, 
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), 
                  maxLines: 2),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrainersList(BuildContext context) {
    final trainers = [
      {"name": "رؤى محمد", "img": "assets/مدرب3.png"},
      {"name": "سلطان سليم", "img": "assets/مدرب1.png"},
      {"name": "زهرة العبدالله", "img": "assets/مدرب6.png"},
      {"name": "حلا محمد", "img": "assets/مدرب4.png"},
    ];
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: trainers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40, 
                  backgroundImage: AssetImage(trainers[index]["img"]!),
                ),
                const SizedBox(height: 8),
                Text(trainers[index]["name"]!, 
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context) {
    final courses = [
      {"title": "إدارة مكاتب", "duration": "40 h", "rating": "2.3", "img": "assets/1ورات.png"},
      {"title": "باريستا", "duration": "40 h", "rating": "3.3", "img": "assets/دورات 2.png"},
      {"title": "لغة إنكليزية", "duration": "60 h", "rating": "4.3", "img": "assets/3دورات.png"},
    ];
    return Container(
      height: 130,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            width: 130,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), 
              image: DecorationImage(image: AssetImage(course["img"]!), fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), 
                gradient: LinearGradient(
                  begin: Alignment.topCenter, 
                  end: Alignment.bottomCenter, 
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                )
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course["title"]!, 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMiniStat(Icons.star, course["rating"]!, Colors.amber),
                      _buildMiniStat(Icons.access_time, course["duration"]!, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMiniStat(IconData i, String t, Color c) => Row(
    children: [
      Icon(i, color: c, size: 10), 
      const SizedBox(width: 2), 
      Text(t, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))
    ]
  );

  Widget _buildReviewsList() {
    final reviews = [
      {"text": "توقعت أمثلة أكثر داخل المحاضرة وبعض المحاور كانت مختصرة جداً", "rating": "4.3"},
      {"text": "محتوى المحاضرة مرتب وواضح ولكن احتاج لمزيد من الأمثلة العملية", "rating": "4.2"},
      {"text": "شرح المدرب واضح ويصل المعلومة بسرعة", "rating": "4.1"},
    ];
    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final rev = reviews[index];
          return Container(
            width: 140,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(20), 
              border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    const Icon(Icons.format_quote, color: Colors.amber, size: 16), 
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12), 
                        Text(rev["rating"]!, 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))
                      ]
                    )
                  ]
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(rev["text"]!, 
                    style: const TextStyle(fontSize: 9, color: Colors.black54, height: 1.3), 
                    maxLines: 4, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlobalActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _actionBtn("تعديل", Icons.edit, Colors.green.shade50, Colors.green),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _actionBtn("حذف", Icons.delete_outline, Colors.red.shade50, Colors.red),
          ),
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
}
