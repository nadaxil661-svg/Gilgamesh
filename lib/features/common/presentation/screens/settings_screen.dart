import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  final bool isGuest;
  const SettingsScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Column(
        children: [
          _buildTop(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _section("الحساب"),
                  _card([
                    _row(Icons.person_outline, "تعديل الملف"),
                    _row(Icons.lock_outline, "تغيير كلمة المرور"),
                    _row(Icons.mail_outline, "البريد الإلكتروني", isLast: true)
                  ]),
                  const SizedBox(height: 25),
                  _section("التطبيق"),
                    _card([
                      _row(Icons.notifications_none_outlined, "الإشعارات"),
                      _row(Icons.wb_sunny_outlined, "الوضع الداكن"),
                      _row(Icons.language_outlined, "اللغة", isLast: true)
                    ]),
                  const SizedBox(height: 35),
                  _logout(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTop(BuildContext context) => Container(
    height: 120, 
    width: double.infinity, 
    decoration: const BoxDecoration(
      gradient: AppColors.primaryGradient, 
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30), 
        bottomRight: Radius.circular(30),
      )
    ), 
    padding: const EdgeInsets.fromLTRB(20, 50, 20, 10), 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        const Text("الإعدادات", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), 
        IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28), 
          onPressed: () => Navigator.pop(context),
        )
      ]
    )
  );

  Widget _section(String t) => Padding(
    padding: const EdgeInsets.only(right: 10, bottom: 10), 
    child: Text(t, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
  );

  Widget _card(List<Widget> c) => Container(
    decoration: BoxDecoration(
      color: Colors.white, 
      borderRadius: BorderRadius.circular(20), 
      border: Border.all(color: Colors.grey.shade50), 
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15)
      ]
    ), 
    child: Column(children: c)
  );

  Widget _row(IconData i, String t, {bool isLast = false}) => Column(
    children: [
      ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8), 
          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle), 
          child: Icon(i, color: Colors.white, size: 20)
        ), 
        title: Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)), 
        trailing: const Icon(Icons.arrow_back_ios_new, size: 14, color: Colors.grey)
      ), 
      if (!isLast) Divider(height: 1, indent: 60, endIndent: 15, color: Colors.grey.shade100)
    ]
  );

  Widget _logout(BuildContext context) => SizedBox(
    width: double.infinity, 
    height: 55, 
    child: OutlinedButton.icon(
      onPressed: () async {
        await AuthService().signOut();
        if (context.mounted) {
          Navigator.of(context).popUntil((r) => r.isFirst);
        }
      }, 
      icon: const Icon(Icons.logout, color: Colors.red), 
      label: const Text("تسجيل الخروج", 
        style: TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold)), 
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red, width: 1.2), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      )
    )
  );
}
