import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';

class SupervisorProfileScreen extends StatelessWidget {
  const SupervisorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 15),
            _buildContactCards(),
            const SizedBox(height: 25),
            _buildJobDetailsCard(),
            const SizedBox(height: 25),
            _buildBioCard(),
            const SizedBox(height: 30),
            _buildSettingsButton(),
            const SizedBox(height: 40),
          ],
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
              colors: [Color(0xFFFFE500), Color(0xFFFFF7AD)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40), 
              bottomRight: Radius.circular(40)
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
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
                child: CircleAvatar(radius: 49, backgroundImage: AssetImage('assets/ola.png')),
              ),
            ),
            const SizedBox(height: 12),
            const Text("علا الزين", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _infoBox("الرقم الوظيفي", "ST-250145", Icons.calendar_today_outlined),
          const SizedBox(width: 12),
          _infoBox("البريد الإلكتروني", "ola@gilgamesh.edu", Icons.email_outlined, isFlex: true),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(t, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Icon(i, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 4),
          Text(v, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
    return isFlex ? Expanded(flex: 2, child: b) : Expanded(child: b);
  }

  Widget _buildJobDetailsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 15)],
        ),
        child: Column(
          children: [
            _detailRow("المسمى الوظيفي : مشرف إداري", Icons.badge_outlined),
            const Divider(height: 25),
            _detailRow("القسم : الإدارة الأكاديمية", Icons.business_outlined),
            const Divider(height: 25),
            _detailRow("سنة التعيين : 2025", Icons.calendar_month_outlined),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String text, IconData icon) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(width: 15),
      Icon(icon, size: 22, color: Colors.grey),
    ],
  );

  Widget _buildBioCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 15)],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("نبذة شخصية", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(width: 10),
                Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "يشرف على تنظيم وإدارة العمليات التعليمية الأكاديمية، ومتابعة بيانات الطالب والدورات والمدربين لضمان سير العمل بكفاءة",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13, height: 1.6, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE500),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("الإعدادات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(width: 15),
            Icon(Icons.settings_outlined, size: 24),
          ],
        ),
      ),
    );
  }
}
