import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/screens/navigation_wrapper.dart';
import 'trainer_profile_screen.dart';

class TrainersListScreen extends StatelessWidget {
  final bool isGuest;
  const TrainersListScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
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

    return AppScaffold(
      title: "المدربين",
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
        onPressed: () => Navigator.pop(context)
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
                  builder: (context) => TrainerProfileScreen(
                    trainerData: trainer, isGuest: isGuest
                  ),
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
        onTap: (idx) => Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(builder: (c) => NavigationWrapper(initialIndex: idx, isGuest: isGuest)), 
          (r) => false
        ),
      ),
    );
  }

  Widget _buildTrainerCard(Map<String, String> trainer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03), 
            blurRadius: 10, offset: const Offset(0, 5)
          ),
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
          Text(trainer["name"]!, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), 
            textAlign: TextAlign.center),
          Text(trainer["job"]!, 
            style: const TextStyle(color: Colors.grey, fontSize: 11), 
            textAlign: TextAlign.center, maxLines: 1),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.workspace_premium_outlined, color: AppColors.primary, size: 18),
                const SizedBox(width: 4),
                Text(trainer["rating"]!, 
                  style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
