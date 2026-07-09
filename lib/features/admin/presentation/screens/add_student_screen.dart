import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../core/services/auth_service.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _academicIdController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  void _handleRegister() async {
    if (_nameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty ||
        _academicIdController.text.isEmpty) {
      _showSnackBar('يرجى ملء جميع البيانات', Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.registerUserByAdmin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        role: 'student',
        extraData: {
          'academicId': _academicIdController.text.trim(),
        },
      );

      if (mounted) {
        _showSnackBar('تم تسجيل الطالب بنجاح', Colors.green);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(e.toString(), Colors.red);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, textAlign: TextAlign.right), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "إضافة طالب جديد",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Icon(Icons.person_add, size: 80, color: Colors.blue),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: "اسم الطالب الكامل",
              prefixIcon: Icons.person,
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "الرقم الأكاديمي",
              prefixIcon: Icons.badge,
              controller: _academicIdController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "البريد الإلكتروني",
              prefixIcon: Icons.email,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "كلمة المرور",
              prefixIcon: Icons.lock,
              isPassword: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: "تسجيل الطالب",
              onPressed: _handleRegister,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
