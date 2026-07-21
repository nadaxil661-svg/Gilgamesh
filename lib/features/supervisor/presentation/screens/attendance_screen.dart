import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 50),
            const Text(
              "الحضور",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildCalendarCard(),
            const SizedBox(height: 40),
            const Text(
              "آخر المحاضرات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildLecturesList(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15)
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFFFE500),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circleArrow(Icons.chevron_left),
                const Text(
                  "يونيو 2026",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _circleArrow(Icons.chevron_right),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _buildDaysHeader(),
                const SizedBox(height: 10),
                _buildCalendarGrid(),
                const SizedBox(height: 20),
                _buildLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleArrow(IconData icon) => Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(color: Colors.white54, shape: BoxShape.circle),
        child: Icon(icon, size: 20),
      );

  Widget _buildDaysHeader() {
    final days = ["السبت", "الأحد", "الاثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعة"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((d) => Text(d, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)))
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(31, (index) {
        int day = index + 1;
        Color color = Colors.grey.shade100;
        Color border = Colors.grey.shade300;
        
        // Simulating the colors from the image
        if ([4, 12, 17, 25, 26].contains(day)) {
          color = const Color(0xFFE8F5E9);
          border = Colors.green;
        } else if ([5, 10, 11, 16, 19, 27].contains(day)) {
          color = const Color(0xFFFFEBEE);
          border = Colors.red;
        } else if ([3, 6, 20, 24].contains(day)) {
          color = const Color(0xFFFFFDEE);
          border = Colors.amber;
        }

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: border, width: 1),
          ),
          child: Text(
            "$day",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      }),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem("عطلة", Colors.grey.shade300),
        const SizedBox(width: 15),
        _legendItem("حاضر", Colors.green),
        const SizedBox(width: 15),
        _legendItem("متأخر", Colors.amber),
        const SizedBox(width: 15),
        _legendItem("غائب", Colors.red),
      ],
    );
  }

  Widget _legendItem(String l, Color c) => Row(
        children: [
          Text(l, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        ],
      );

  Widget _buildLecturesList() {
    final lectures = [
      {"title": "UI UX", "date": "الثلاثاء، 11 يونيو 2026", "time": "8:00_10:30", "status": "حاضر", "color": Colors.green, "icon": Icons.design_services_outlined},
      {"title": "مونتاج", "date": "الأحد، 2 يونيو 2026", "time": "12:00_2:00", "status": "حاضر", "color": Colors.green, "icon": Icons.video_collection_outlined},
      {"title": "فوتوشوب", "date": "الخميس، 6 يونيو 2026", "time": "9:00_11:00", "status": "متأخر", "color": Colors.amber, "icon": Icons.photo_outlined},
      {"title": "اليستريتر", "date": "الاثنين، 10 يونيو 2026", "time": "9:00_11:00", "status": "غائب", "color": Colors.red, "icon": Icons.draw_outlined},
      {"title": "تصوير", "date": "الأربعاء، 19 يونيو 2026", "time": "9:00_11:00", "status": "غائب", "color": Colors.red, "icon": Icons.camera_alt_outlined},
    ];

    return Column(
      children: lectures.map((l) => _buildLectureCard(l)).toList(),
    );
  }

  Widget _buildLectureCard(Map<String, dynamic> l) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: (l['color'] as Color).withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        children: [
          _statusBadge(l['status'], l['color']),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(l['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(l['date'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l['time'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  const SizedBox(width: 5),
                  const Icon(Icons.access_time, size: 12, color: Colors.grey),
                ],
              ),
            ],
          ),
          const SizedBox(width: 15),
          Icon(l['icon'] as IconData, color: Colors.black87, size: 30),
        ],
      ),
    );
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      width: 60,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
          const SizedBox(width: 4),
          Icon(label == "غائب" ? Icons.close : Icons.check_circle_outline, color: color, size: 14),
        ],
      ),
    );
  }
}
