import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';

class ScheduleScreen extends StatefulWidget {
  final bool isGuest;
  final String? userRole;
  const ScheduleScreen({super.key, this.isGuest = false, this.userRole});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDayIndex = 0;
  final List<String> _days = ["الأحد", "الإثنين", "الثلاثاء", "الأربعاء", "الخميس"];

  @override
  Widget build(BuildContext context) {
    bool isStaff = widget.userRole == 'admin' || widget.userRole == 'supervisor';

    return AppScaffold(
      title: "جدول الدوام الأسبوعي",
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
        onPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              _buildDaySelector(),
              Expanded(child: _buildScheduleList()),
              if (isStaff) _buildStaffActions(),
            ],
          ),
          if (widget.isGuest) _buildGuestOverlay(),
        ],
      ),
    );
  }

  Widget _buildStaffActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: const Center(
              child: Text("إضافة محاضرة +", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _globalActionBtn("تعديل", Icons.edit, Colors.green.shade50, Colors.green),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _globalActionBtn("حذف", Icons.delete_outline, Colors.red.shade50, Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _globalActionBtn(String l, IconData i, Color bg, Color c) => Container(
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

  Widget _buildDaySelector() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => setState(() => _selectedDayIndex = index),
          child: Container(
            width: 90,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _selectedDayIndex == index ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              _days[index],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _selectedDayIndex == index ? Colors.black : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleList() {
    final List<Map<String, String>> schedule = [
      {"title": "قواعد البيانات", "room": "قاعة 2", "time": "10:00 _ 11:30", "trainer": "د. سلطان سليم"},
      {"title": "برمجة ويب", "room": "قاعة 4", "time": "12:00 _ 1:30", "trainer": "د. سلطان سليم"},
      {"title": "تصميم UI UX", "room": "قاعة 1", "time": "1:30 _ 3:00", "trainer": "م. زهرة العبدالله"},
      {"title": "إدارة مكاتب", "room": "قاعة 3", "time": "3:30 _ 5:00", "trainer": "م. رؤى محمد"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: schedule.length,
      itemBuilder: (context, index) => _buildScheduleCard(schedule[index]),
    );
  }

  Widget _buildScheduleCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02), 
            blurRadius: 15, 
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item["title"]!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("محاضرة", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoRow(Icons.access_time_rounded, item["time"]!),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.location_on_outlined, item["room"]!),
                  const SizedBox(height: 6),
                  _infoRow(Icons.person_outline_rounded, item["trainer"]!),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        const SizedBox(width: 10),
        Text(text, 
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildGuestOverlay() {
    return Container(
      color: Colors.white.withValues(alpha: 0.85),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_person_rounded, size: 70, color: AppColors.primary),
            SizedBox(height: 20),
            Text("الجدول الأسبوعي متاح فقط للطلاب", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("يرجى تسجيل الدخول لمتابعة محاضراتك", 
              style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
