import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../common/presentation/screens/diplomas_screen.dart';
import '../../../supervisor/presentation/screens/trainers_list_screen.dart';
import '../../../common/presentation/screens/reviews_screen.dart';
import '../../../common/presentation/screens/courses_screen.dart';
import '../../../common/presentation/screens/course_details_screen.dart';
import '../../../student/presentation/screens/profile_screen.dart';

class AcademyHomeScreen extends StatelessWidget {
  final bool isGuest;
  final String? userRole;

  const AcademyHomeScreen({super.key, this.isGuest = false, this.userRole});

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
            _buildSectionHeader(
              context,
              "الدبلومات المهنية:",
              DiplomasScreen(isGuest: isGuest, userRole: userRole),
            ),
            _buildDiplomasList(),
            const SizedBox(height: 25),
            _buildSectionHeader(
              context,
              "المدربين",
              TrainersListScreen(isGuest: isGuest, userRole: userRole),
            ),
            _buildTrainersList(context),
            const SizedBox(height: 25),
            _buildSectionHeader(
              context,
              "الدورات",
              const CoursesScreen(),
            ),
            _buildCoursesList(context),
            const SizedBox(height: 25),
            _buildSectionHeader(
              context,
              "آراء الطلاب",
              ReviewsScreen(isGuest: isGuest),
            ),
            _buildReviewsList(),
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
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: isGuest ? _buildGuestHeaderContent() : _buildStudentHeaderContent(context),
      ),
    );
  }

  Widget _buildGuestHeaderContent() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/2imag.png'),
        ),
      ),
    );
  }

  Widget _buildStudentHeaderContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, 
            MaterialPageRoute(builder: (c) => const StudentProfileScreen())),
          child: const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/1D.png')),
          ),
        ),
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text("صباح الخير يا يارا", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Icon(Icons.wb_sunny_outlined, color: Colors.orange, size: 18),
              ],
            ),
            Text("ابدأ رحلتك حول التميز", 
              style: TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
        const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white24,
          backgroundImage: AssetImage('assets/2imag.png'),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.surface, 
          borderRadius: BorderRadius.circular(15),
        ),
        child: const TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "بحث",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 15), 
              child: Icon(Icons.search, color: Colors.grey, size: 26),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
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

  Widget _buildDiplomasList() {
    final diplomas = [
      {"title": "التصميم والتسويق", "icon": "assets/icons/1.png", "color": const Color(0xFFF0EAF3), "border": const Color(0xFFB194C0)},
      {"title": "الشيف", "icon": "assets/icons/2.png", "color": const Color(0xFFF8ECEC), "border": const Color(0xFFEBB3B5)},
      {"title": "التغذية", "icon": "assets/icons/3.png", "color": const Color(0xFFFFFDEE), "border": const Color(0xFFF2EDBB)},
      {"title": "إدارة أعمال", "icon": "assets/icons/4.png", "color": const Color(0xFFE2F0ED), "border": const Color(0xFF80BAAE)},
    ];
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: diplomas.length,
        itemBuilder: (context, index) {
          final item = diplomas[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, 
              MaterialPageRoute(builder: (context) => DiplomasScreen(isGuest: isGuest, userRole: userRole))),
            child: Container(
              width: 102,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: item["color"] as Color, 
                borderRadius: BorderRadius.circular(12), 
                border: Border.all(color: item["border"] as Color, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(item["icon"] as String, height: 30),
                  const SizedBox(height: 6),
                  Text(item["title"] as String, 
                    textAlign: TextAlign.center, 
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold), 
                    maxLines: 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrainersList(BuildContext context) {
    final trainers = [
      {"name": "سالي سليم", "img": "assets/مدرب1.png"},
      {"name": "جود العبدالله", "img": "assets/مدرب6.png"},
      {"name": "رؤى محمد", "img": "assets/مدرب3.png"},
      {"name": "حلا محمد", "img": "assets/مدرب4.png"},
      {"name": "غصون الجاسم", "img": "assets/مدرب5.png"},
    ];
    return Container(
      height: 140,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: trainers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (context) => TrainersListScreen(isGuest: isGuest, userRole: userRole))),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44, 
                    backgroundColor: Colors.grey.shade200, 
                    backgroundImage: AssetImage(trainers[index]["img"]!),
                  ),
                  const SizedBox(height: 8),
                  Text(trainers[index]["name"]!, 
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context) {
    final courses = [
      {"title": "إدارة مكاتب", "duration": "40 h", "rating": "3.8", "img": "assets/1ورات.png"},
      {"title": "باريستا", "duration": "40 h", "rating": "3.3", "img": "assets/دورات 2.png"},
      {"title": "لغة إنكليزية", "duration": "60 h", "rating": "4.3", "img": "assets/3دورات.png"},
      {"title": "ريادة أعمال", "duration": "40 h", "rating": "3.8", "img": "assets/1imag.png"},
    ];
    return Container(
      height: 115,
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CourseDetailsScreen(courseData: course, isGuest: isGuest, userRole: userRole))),
            child: Container(
              width: 110,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), 
                border: Border.all(color: Colors.amber.shade200, width: 1.5), 
                image: DecorationImage(image: AssetImage(course["img"]!), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), 
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, 
                    end: Alignment.bottomCenter, 
                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                  )
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course["title"]!, 
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10), 
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatIcon(Icons.star, course["rating"]!, Colors.amber),
                        _buildStatIcon(Icons.access_time, course["duration"]!, Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 10), 
        const SizedBox(width: 2), 
        Text(text, 
          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))
      ]
    );
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: reviews.length + 1,
        itemBuilder: (context, index) {
          if (index == reviews.length) return _buildSeeMoreReviewsCard();
          final rev = reviews[index];
          return Container(
            width: 105,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(25), 
              border: Border.all(color: Colors.grey.shade100, width: 1.2), 
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03), 
                  blurRadius: 10, offset: const Offset(0, 4),
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Image.asset("assets/icons/5.png", height: 18), 
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 10), 
                        const SizedBox(width: 1), 
                        Text(rev["rating"]!, 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))
                      ]
                    )
                  ]
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(rev["text"]!, 
                    style: const TextStyle(fontSize: 8.5, color: Colors.black54, height: 1.3), 
                    maxLines: 4, 
                    overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeeMoreReviewsCard() {
    return Container(
      width: 90, 
      margin: const EdgeInsets.symmetric(horizontal: 8), 
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)), 
      child: Center(
        child: CircleAvatar(
          radius: 18, 
          backgroundColor: AppColors.primary.withValues(alpha: 0.1), 
          child: const Text("س", 
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        )
      )
    );
  }
}
