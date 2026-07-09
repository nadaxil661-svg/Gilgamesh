import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';

/// واجهة تسجيل الدخول (النسخة الأصلية القديمة)
/// تدعم التمييز بين دخول الطالب ودخول الزائر
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/1imag.png', height: 120, width: 100, errorBuilder: (c, e, s) => const Icon(Icons.image, size: 100)),
                const SizedBox(height: 20),
                const Text("أهلاً بعودتك", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const Text("واصل رحلتك التعليمية وحقق طموحاتك الأكاديمية", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 50),
                _field("البريد الإلكتروني", Icons.email),
                const SizedBox(height: 30),
                _field("كلمة المرور", Icons.visibility_off, isPassword: true),
                const SizedBox(height: 30),
                _mainBtn(context),
                const SizedBox(height: 30),
                _divider(),
                const SizedBox(height: 30),
                _guestBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String h, IconData i, {bool isPassword = false}) => TextField(obscureText: isPassword, textAlign: TextAlign.right, decoration: InputDecoration(hintText: h, prefixIcon: Icon(i, color: Colors.grey), filled: true, fillColor: Colors.grey.shade100, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)));

  /// زر الدخول كطالب (الزر الأول)
  Widget _mainBtn(BuildContext context) => Container(width: double.infinity, height: 60, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFBEC21), Color(0xFFFCC218)]), borderRadius: BorderRadius.circular(20)), child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const NavigationWrapper(isGuest: false))), style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text("تسجيل دخول", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))));

  /// زر الدخول كزائر (الزر الثاني)
  Widget _guestBtn(BuildContext context) => SizedBox(width: double.infinity, height: 60, child: OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const NavigationWrapper(isGuest: true))), style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFFCC218), width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text("تسجيل كزائر", style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold))));

  Widget _divider() => const Row(children: [Expanded(child: Divider(color: Colors.grey, thickness: 1)), Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("أو", style: TextStyle(color: Colors.grey))), Expanded(child: Divider(color: Colors.grey, thickness: 1))]);
}
