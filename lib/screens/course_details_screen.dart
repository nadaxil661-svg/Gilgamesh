import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';

/// واجهة تفاصيل الدورة (خاصة بالدورات فقط)
/// تم ربط شريط الأدوات الموحد لضمان التنقل من أي مكان
class CourseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final bool isGuest;

  const CourseDetailsScreen({
    super.key,
    required this.courseData,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28), onPressed: () => Navigator.pop(context)),
          title: Text(courseData['title'] ?? "تفاصيل الدورة", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)), centerTitle: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [_buildHeaderCard(), const SizedBox(height: 30), _buildTitle("حول هذه الدورة"), _buildDesc(), _buildTrainerRow("م. أحمد الأحمد", "assets/مدرب1.png"), const SizedBox(height: 30), _buildWeeksList()]),
        ),
        // ربط شريط الأدوات الموحد
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: 0, 
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

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15)]),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFFBEC21))), child: ClipRRect(borderRadius: BorderRadius.circular(13), child: Image.asset(courseData['img'] ?? 'assets/دورات 2.png', width: 90, height: 90, fit: BoxFit.cover))),
        const SizedBox(width: 15),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(courseData['title'] ?? "دورة مهنية", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Text("شهادة معتمدة", style: TextStyle(fontSize: 11, color: Colors.grey)), const SizedBox(height: 8), LinearProgressIndicator(value: 0.5, backgroundColor: Colors.grey.shade100, valueColor: const AlwaysStoppedAnimation(Color(0xFFFBEC21)))])),
        Text(courseData['price'] ?? "250\$", style: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildTitle(String t) => Align(alignment: Alignment.centerRight, child: Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  Widget _buildDesc() => const Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text("محتوى تعليمي متطور يواكب متطلبات سوق العمل، يهدف لمساعدة الطلاب على اكتساب مهارات حقيقية وعملية في تخصصهم.", style: TextStyle(fontSize: 14, height: 1.7, color: Colors.black54)));
  Widget _buildTrainerRow(String n, String i) => Row(children: [CircleAvatar(radius: 30, backgroundImage: AssetImage(i)), const SizedBox(width: 15), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const Text("trainer.expert@gmail.com", style: TextStyle(fontSize: 12, color: Colors.grey))])]);
  Widget _buildWeeksList() => Column(children: [1, 2, 3].map((i) => Container(margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFFBEC21).withValues(alpha: 0.2))), child: ExpansionTile(title: Text("الأسبوع $i", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), children: const [Padding(padding: EdgeInsets.all(15), child: Text("تفاصيل المحاضرات والمادة العلمية..."))]))).toList());
}
