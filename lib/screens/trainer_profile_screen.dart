import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';

/// واجهة بروفايل المدرب
/// تم ضبط التنسيقات لتطابق الصورة المرجعية رقم 13 بدقة
class TrainerProfileScreen extends StatelessWidget {
  final Map<String, String> trainerData;
  final bool isGuest;

  const TrainerProfileScreen({super.key, required this.trainerData, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopHeader(context),
              const SizedBox(height: 25),
              _buildStatsCard(),
              const SizedBox(height: 35),
              _buildBioSection(),
              const SizedBox(height: 50),
              _buildDownloadCVButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: 4, isGuest: isGuest,
          onTap: (idx) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => NavigationWrapper(initialIndex: idx, isGuest: isGuest)), (r) => false),
        ),
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 260, width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFFBEC21), Color(0xFFFCC218)]),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          ),
        ),
        Positioned(top: 50, right: 20, child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28), onPressed: () => Navigator.pop(context))),
        Column(
          children: [
            const SizedBox(height: 55),
            Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle), child: CircleAvatar(radius: 55, backgroundColor: Colors.white, child: CircleAvatar(radius: 52, backgroundImage: AssetImage(trainerData["img"] ?? "assets/مدرب1.png")))),
            const SizedBox(height: 12),
            Text(trainerData["name"] ?? "اسم المدرب", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
            Text(trainerData["job"] ?? "التخصص", style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 8))]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStat(Icons.workspace_premium_outlined, trainerData["rating"] ?? "7+", "الخبرة"),
            _buildStat(Icons.star_outline, "4.5", "التقييم"),
            _buildStat(Icons.analytics_outlined, "نشط", "الحالة"),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData i, String v, String l) {
    return Column(children: [Icon(i, color: const Color(0xFFFCC218), size: 28), const SizedBox(height: 5), Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(l, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))]);
  }

  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        "${trainerData["name"]} متخصص في ${trainerData["job"]}، يمتلك خبرة عملية واسعة تهدف لمساعدة الطلاب على اكتساب مهارات حقيقية بطريقة مبسطة وحديثة وتركز على الإبداع والتطبيق العملي لتحقيق أفضل نتيجة.",
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, height: 1.7, color: Colors.black87, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildDownloadCVButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 55, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFFCC218), width: 1.2)),
        child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.picture_as_pdf_outlined, color: Colors.grey, size: 22), SizedBox(width: 8), Text("Hala_CV.pdf", style: TextStyle(color: Colors.grey, fontSize: 14))]),
      ),
    );
  }
}
