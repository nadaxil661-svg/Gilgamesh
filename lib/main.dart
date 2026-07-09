import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // استيراد واجهة تسجيل الدخول

void main() {
  runApp(const MyApp()); // نقطة انطلاق التطبيق
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء علامة الـ debug من الزاوية
      title: 'Academy App',
      theme: ThemeData(
        primarySwatch: Colors.amber, // اللون الأساسي للتطبيق
        useMaterial3: true, // تفعيل سمات Material 3 الحديثة
        fontFamily: 'Cairo', // تعيين خط "كاييرو" كخط افتراضي للتطبيق
      ),
      home: const LoginScreen(), // الصفحة التي سيبدأ بها التطبيق عند الفتح
    );
  }
}
