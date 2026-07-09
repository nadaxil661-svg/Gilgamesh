import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';

/// واجهة الامتحانات
/// تم ربط شريط الأدوات الموحد لضمان التنقل السلس
class ExamsScreen extends StatelessWidget {
  final bool isGuest;
  const ExamsScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> exams = [
      {"subject": "فوتوشوب", "date": "الثلاثاء _ 2 يونيو 2026", "location": "قاعة الحاسوب", "time": "9:00 _ 11:00 صباحاً", "remaining": "1 يوم"},
      {"subject": "معلوماتية", "date": "الخميس _ 4 يونيو 2026", "location": "قاعة الحاسوب", "time": "9:00 _ 10:00 صباحاً", "remaining": "3 يوم"},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28), onPressed: () => Navigator.pop(context)),
          title: const Text("الإمتحانات", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)), centerTitle: false,
        ),
        body: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(20), itemCount: exams.length,
              itemBuilder: (context, index) => _buildExamCard(exams[index]),
            ),
            if (isGuest) _buildGuestOverlay(),
          ],
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

  Widget _buildExamCard(Map<String, String> exam) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Row(children: [
        Expanded(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(exam["subject"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFFBEC21), borderRadius: BorderRadius.circular(20)), child: Text(exam["remaining"]!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)))]),
          const SizedBox(height: 12),
          _row(Icons.calendar_month_rounded, exam["date"]!), _row(Icons.location_on_outlined, exam["location"]!), _row(Icons.access_time_rounded, exam["time"]!),
        ]))),
        Container(width: 5, height: 110, decoration: const BoxDecoration(color: Color(0xFFFBEC21), borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)))),
      ]),
    );
  }

  Widget _row(IconData i, String t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(children: [Icon(i, size: 16, color: Colors.grey.shade500), const SizedBox(width: 10), Text(t, style: TextStyle(fontSize: 13, color: Colors.grey.shade600))]));

  Widget _buildGuestOverlay() => Container(color: Colors.white.withValues(alpha: 0.85), child: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.lock_person_rounded, size: 70, color: Colors.amber), SizedBox(height: 20), Text("سجل كطالب لمتابعة امتحاناتك", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))])));
}
