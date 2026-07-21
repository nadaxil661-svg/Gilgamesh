import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/screens/navigation_wrapper.dart';

class ReviewsScreen extends StatelessWidget {
  final bool isGuest;
  const ReviewsScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      title: "آراء الطلاب",
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
        onPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
            child: Column(
              children: [
                _buildRatingHeader(),
                const SizedBox(height: 30),
                _buildList(),
              ],
            ),
          ),
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
    );
  }

  Widget _buildRatingHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Text("4.6", 
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.primary)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => Icon(
                    i < 4 ? Icons.star_rounded : Icons.star_half_rounded, 
                    color: AppColors.primary, size: 20
                  )),
                )
              ],
            ),
          ),
          Container(
            height: 80, 
            width: 1, 
            color: Colors.grey.shade100, 
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
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
        Text(l, 
          style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: p, 
              minHeight: 6, 
              backgroundColor: Colors.grey.shade100, 
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
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
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(20), 
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(i["n"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Icon(Icons.star_rounded, color: AppColors.primary, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(i["t"]!, 
              style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black54)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildAddButton() {
    if (isGuest) return const SizedBox.shrink();
    return Positioned(
      bottom: 25,
      left: 25,
      right: 25,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1), 
              blurRadius: 10, offset: const Offset(0, 5),
            )
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit_note_rounded, color: Colors.black87, size: 26),
          label: const Text("أضف تقييمك", 
            style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, 
            shadowColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
