import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';

/// واجهة تفاصيل المادة (خاصة بالمواد فقط)
/// تم ربط شريط الأدوات الموحد لضمان التنقل من أي مكان
class SubjectDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> subjectData;
  final bool isGuest;

  const SubjectDetailsScreen({
    super.key,
    required this.subjectData,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            subjectData['title'] ?? "UI UX",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageHeader(),
              const SizedBox(height: 60),
              _buildDescription(),
              const SizedBox(height: 35),
              _buildTrainerInfo(),
              const SizedBox(height: 40),
              _buildLessonsList(),
              const SizedBox(height: 30),
            ],
          ),
        ),
        // ربط شريط الأدوات الموحد
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: 0, // تفعيل أيقونة الرئيسية
          isGuest: isGuest,
          onTap: (idx) => Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (c) => NavigationWrapper(initialIndex: idx, isGuest: isGuest)), 
            (r) => false
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity, height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFFFBEC21), width: 2),
            image: DecorationImage(image: AssetImage(subjectData['img'] ?? 'assets/3مواد.png'), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: -35,
          child: Container(
            width: 280, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(color: const Color(0xFFFFFDEE), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 5))]),
            child: Column(children: [
              Text(subjectData['title'] ?? "UI UX", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.star, color: Colors.amber, size: 18), const SizedBox(width: 5), const Text("4.5", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(width: 30),
                const Icon(Icons.access_time, color: Colors.grey, size: 18), const SizedBox(width: 5), const Text("120h", style: TextStyle(fontSize: 14, color: Colors.grey)),
              ]),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() => const Text("تختص مادة UI/UX بتصميم واجهات سهلة وجذابة وتحسين تجربة المستخدم داخل التطبيقات والمواقع.", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, height: 1.6, color: Colors.black87, fontWeight: FontWeight.w500));

  Widget _buildTrainerInfo() => Row(mainAxisAlignment: MainAxisAlignment.end, children: [const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text("م. زهرة العبدالله", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), Text("trainer.zahra@gmail.com", style: TextStyle(fontSize: 12, color: Colors.grey))]), const SizedBox(width: 15), const CircleAvatar(radius: 35, backgroundImage: AssetImage('assets/مدرب3.png'))]);

  Widget _buildLessonsList() => Column(children: List.generate(4, (i) => _buildLessonItem("مدخل إلى عالم فيغما")));

  Widget _buildLessonItem(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(18)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(5), decoration: const BoxDecoration(color: Color(0xFFFBEC21), shape: BoxShape.circle), child: const Icon(Icons.arrow_outward, size: 18, color: Colors.black54)),
        const Spacer(), Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)), const SizedBox(width: 12), const Icon(Icons.language_outlined, color: Colors.black54, size: 22),
      ]),
    );
  }
}
