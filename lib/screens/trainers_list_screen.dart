import 'package:flutter/material.dart';
import 'trainer_profile_screen.dart';
import 'navigation_wrapper.dart';

/// واجهة قائمة المدربين الشاملة
/// تم تحديثها بجميع صور المدربين (الوجوه الحقيقية) المطلوبة
class TrainersListScreen extends StatelessWidget {
  final bool isGuest;
  const TrainersListScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    // قائمة بجميع المدربين مع الصور الحقيقية (الوجوه)
    final List<Map<String, String>> trainers = [
      {"name": "بيان سليم", "job": "برمجة ويب", "rating": "8+", "img": "assets/مدرب1.png"},
      {"name": "رؤى محمد", "job": "إدارة فنادق", "rating": "6+", "img": "assets/مدرب3.png"},
      {"name": "سارة العبدالله", "job": "UI UX", "rating": "5+", "img": "assets/مدرب3.png"},
      {"name": "حلا محمد", "job": "التسويق الرقمي", "rating": "7+", "img": "assets/مدرب4.png"},
      {"name": "غصون الجاسم", "job": "لغة إنجليزية", "rating": "6+", "img": "assets/مدرب5.png"},
      {"name": "ريان السالم", "job": "معلوماتية", "rating": "7+", "img": "assets/مدرب2.png"},
      {"name": "نور اليوسف", "job": "تغذية", "rating": "7+", "img": "assets/مدرب6.png"},
      {"name": "هدى ديب", "job": "ريادة أعمال", "rating": "7+", "img": "assets/مدرب1.png"},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, elevation: 0,
          leading: IconButton(
            // السهم يشير للجهة الأخرى (اليسار في RTL للعودة)
            icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context)
          ),
          title: const Text("المدربين", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 25,
              childAspectRatio: 0.8,
            ),
            itemCount: trainers.length,
            itemBuilder: (context, index) {
              final trainer = trainers[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainerProfileScreen(trainerData: trainer, isGuest: isGuest),
                  ),
                ),
                child: _buildTrainerCard(trainer),
              );
            },
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: 0, 
          isGuest: isGuest,
          onTap: (idx) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => NavigationWrapper(initialIndex: idx, isGuest: isGuest)), (r) => false),
        ),
      ),
    );
  }

  Widget _buildTrainerCard(Map<String, String> trainer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.4), width: 1.2),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          CircleAvatar(
            radius: 42,
            backgroundImage: AssetImage(trainer["img"]!),
          ),
          const SizedBox(height: 12),
          Text(trainer["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
          Text(trainer["job"]!, style: const TextStyle(color: Colors.grey, fontSize: 11), textAlign: TextAlign.center, maxLines: 1),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.workspace_premium_outlined, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Text(trainer["rating"]!, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
