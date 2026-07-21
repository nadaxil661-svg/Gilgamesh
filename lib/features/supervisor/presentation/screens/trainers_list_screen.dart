import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../home/presentation/screens/navigation_wrapper.dart';
import 'trainer_profile_screen.dart';
import '../../../admin/presentation/screens/add_trainer_screen.dart';

class TrainersListScreen extends StatelessWidget {
  final bool isGuest;
  final String? userRole;
  const TrainersListScreen({super.key, this.isGuest = false, this.userRole});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> trainers = [
      {"name": "سلطان سليم", "job": "برمجة ويب\nوقواعد بيانات", "rating": "8+", "img": "assets/مدرب1.png"},
      {"name": "رؤى محمد", "job": "حجوزات\nوإدارة فنادق", "rating": "6+", "img": "assets/مدرب3.png"},
      {"name": "زهرة العبدالله", "job": "UI UX", "rating": "5+", "img": "assets/مدرب6.png"},
      {"name": "حلا محمد", "job": "تسويق\nرقمي", "rating": "7+", "img": "assets/مدرب4.png"},
      {"name": "غصون الجاسم", "job": "لغة إنجليزية\nومحادثة", "rating": "6+", "img": "assets/مدرب5.png"},
      {"name": "ريان السالم", "job": "معلوماتية", "rating": "7+", "img": "assets/مدرب2.png"},
      {"name": "دانا اليوسف", "job": "تغذية", "rating": "7+", "img": "assets/مدرب6.png"},
      {"name": "عمر ديب", "job": "ريادة أعمال\nوإدارة مشاريع", "rating": "7+", "img": "assets/مدرب1.png"},
    ];

    return AppScaffold(
      title: "المدربين",
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
        onPressed: () => Navigator.pop(context)
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 100),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 50,
              childAspectRatio: 0.9,
            ),
            itemCount: trainers.length,
            itemBuilder: (context, index) {
              final trainer = trainers[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainerProfileScreen(
                      trainerData: trainer, isGuest: isGuest, userRole: userRole,
                    ),
                  ),
                ),
                child: _buildTrainerCard(trainer),
              );
            },
          ),
          if (userRole == 'admin' || userRole == 'supervisor')
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const AddTrainerScreen()),
                ),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE500),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("إضافة مدرب", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.add, size: 24),
                    ],
                  ),
                ),
              ),
            ),
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

  Widget _buildTrainerCard(Map<String, String> trainer) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.amber.shade200, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02), 
                blurRadius: 10, offset: const Offset(0, 5)
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(trainer["name"]!, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), 
                textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Text(trainer["job"]!, 
                style: const TextStyle(color: Colors.grey, fontSize: 10, height: 1.2), 
                textAlign: TextAlign.center, maxLines: 2),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.workspace_premium, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(trainer["rating"]!, 
                        style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              if (userRole == 'admin' || userRole == 'supervisor') ...[
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),
                _buildActionButtons(),
              ],
            ],
          ),
        ),
        Positioned(
          top: -40,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(trainer["img"]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _miniActionButton("تعديل", Icons.edit, const Color(0xFFE8F5E9), Colors.green),
        _miniActionButton("حذف", Icons.delete_outline, const Color(0xFFFFEBEE), Colors.red),
      ],
    );
  }

  Widget _miniActionButton(String label, IconData icon, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9)),
          const SizedBox(width: 3),
          Icon(icon, color: color, size: 10),
        ],
      ),
    );
  }
}
