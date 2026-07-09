import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';
import 'exams_screen.dart';

/// واجهة ملف الطالب الشخصي (يارا)
/// تم ربط شريط الأدوات الموحد لضمان التنقل من أي مكان
class StudentProfileScreen extends StatelessWidget {
  final bool isGuest;
  const StudentProfileScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 15),
              _buildContactRow(),
              const SizedBox(height: 30),
              _buildCircleActions(context),
              const SizedBox(height: 30),
              _buildAcademicCard(),
              const SizedBox(height: 25),
              _buildStatsRow(),
              const SizedBox(height: 35),
              _buildMainAction(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
        // شريط الأدوات الموحد مربوط بالواجهة
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: 3, // تفعيل أيقونة الإعدادات
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

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFBEC21), Color(0xFFFCC218)],
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
              child: const CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white,
                child: CircleAvatar(radius: 49, backgroundImage: AssetImage('assets/1D.png')),
              ),
            ),
            const SizedBox(height: 12),
            const Text("يارا إبراهيم", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("السنة الأولى _ الفصل الثاني", style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildContactRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _infoBox("الرقم الأكاديمي", "ST-250145", Icons.calendar_month_outlined),
          const SizedBox(width: 12),
          _infoBox("البريد الإلكتروني", "yara.ibrahim@student.edu", Icons.email_outlined, isFlex: true),
        ],
      ),
    );
  }

  Widget _infoBox(String t, String v, IconData i, {bool isFlex = false}) {
    Widget b = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
              Icon(i, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 4),
          Text(v, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
    return isFlex ? Expanded(flex: 2, child: b) : Expanded(child: b);
  }

  Widget _buildCircleActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _circle(context, "جدول الدوام", Icons.calendar_today_outlined, 2),
          _circle(context, "الإمتحانات", Icons.edit_note_rounded, -1),
        ],
      ),
    );
  }

  Widget _circle(BuildContext context, String l, IconData i, int tab) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isGuest) return;
            if(tab >= 0) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => NavigationWrapper(initialIndex: tab, isGuest: isGuest)), (r) => false);
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (c) => ExamsScreen(isGuest: isGuest)));
            }
          },
          child: Opacity(
            opacity: isGuest ? 0.2 : 1.0,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFBEC21).withValues(alpha: 0.6), width: 1.5),
              ),
              child: Icon(i, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(l, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildAcademicCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade50),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 15)],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFFFFDEE), borderRadius: BorderRadius.circular(10)),
                  child: const Text("نشط", style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const Row(
                  children: [
                    Text("تسويق وتصميم إعلاني", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 8),
                    Icon(Icons.laptop_mac_rounded, size: 20, color: Colors.grey),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            _row("المعدل: 91%", Icons.trending_up_rounded, Colors.green),
            _row("2025_2026", Icons.calendar_today_outlined, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _row(String t, IconData i, Color c) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text(t, style: const TextStyle(fontSize: 12)), const SizedBox(width: 8), Icon(i, size: 16, color: c)]));

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _s("الساعات المكتملة", "87", Icons.access_time_rounded),
          _s("المقررات المنجزة", "14", Icons.assignment_outlined),
          _s("نقاط التميز", "340", Icons.stars_rounded),
        ],
      ),
    );
  }

  Widget _s(String l, String v, IconData i) {
    return Container(
      width: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFFCC218), width: 1.2),
      ),
      child: Column(
        children: [
          Icon(i, size: 22, color: const Color(0xFFFCC218)),
          const SizedBox(height: 5),
          Text(v, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(l, style: const TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildMainAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
      ),
    );
  }
}
