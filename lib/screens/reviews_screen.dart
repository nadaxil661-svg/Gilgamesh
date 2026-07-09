import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';

/// واجهة آراء الطلاب
/// تم تحديث زر "أضف تقييمك" للزائر ليكون مخفياً جزئياً (باهت) وغير فعال تماماً
class ReviewsScreen extends StatelessWidget {
  final bool isGuest;
  const ReviewsScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFDFDFD),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("آراء الطلاب", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
          centerTitle: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 120), // مسافة إضافية للزر في الأسفل
              child: Column(
                children: [
                  _buildRatingHeader(),
                  const SizedBox(height: 30),
                  _buildList(),
                ],
              ),
            ),
            // زر إضافة الرأي: يظهر مموه جداً (0.2) للزائر وغير قابل للنقر أبداً
            _buildAddButton(),
          ],
        ),
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

  Widget _buildRatingHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15)],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Text("4.6", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFFFBEC21))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => Icon(i < 4 ? Icons.star_rounded : Icons.star_half_rounded, color: const Color(0xFFFBEC21), size: 20)),
                )
              ],
            ),
          ),
          Container(height: 80, width: 1, color: Colors.grey.shade100, margin: const EdgeInsets.symmetric(horizontal: 10)),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _bar("5 نجوم", 0.9),
                _bar("4 نجوم", 0.7),
                _bar("3 نجوم", 0.4),
                _bar("2 نجمة", 0.2),
                _bar("1 نجمة", 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(String l, double p) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text(l, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(value: p, minHeight: 6, backgroundColor: Colors.grey.shade100, valueColor: const AlwaysStoppedAnimation(Color(0xFFFBEC21))),
              ),
            )
          ],
        ),
      );

  Widget _buildList() {
    final r = [
      {"n": "سارة محمد", "t": "شرح المدرب كان واضح ومفيد جداً واستفدت بشكل كبير."},
      {"n": "أحمد العلي", "t": "تجربة رائعة! المعهد يقدم محتوى تعليمي حديث جداً."}
    ];
    return Column(
      children: r.map((i) => Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(i["n"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Icon(Icons.star_rounded, color: Color(0xFFFBEC21), size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(i["t"]!, style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black54)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildAddButton() {
    return Positioned(
      bottom: 25,
      left: 25,
      right: 25,
      child: IgnorePointer(
        ignoring: isGuest, // منع التفاعل تماماً للزائر
        child: Opacity(
          opacity: isGuest ? 0.2 : 1.0, // تمويه الزر للزائر (باهت جداً)
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFBEC21), Color(0xFFFCC218)]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit_note_rounded, color: Colors.black87, size: 26),
              label: const Text("أضف تقييمك", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
