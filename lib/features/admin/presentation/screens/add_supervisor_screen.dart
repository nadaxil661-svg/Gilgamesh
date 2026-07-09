import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../core/services/auth_service.dart';

class AddSupervisorScreen extends StatefulWidget {
  const AddSupervisorScreen({super.key});

  @override
  State<AddSupervisorScreen> createState() => _AddSupervisorScreenState();
}

class _AddSupervisorScreenState extends State<AddSupervisorScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  void _handleRegister() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('يرجى ملء جميع البيانات', Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.registerUserByAdmin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        role: 'supervisor',
      );

      if (mounted) {
        _showSnackBar('تم تسجيل المشرف بنجاح', Colors.green);
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
      title: "إضافة مشرف جديد",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Icon(Icons.person_add_alt_1, size: 80, color: Colors.amber),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: "الاسم الكامل",
              prefixIcon: Icons.person,
              controller: _nameController,
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
              text: "تسجيل المشرف",
              onPressed: _handleRegister,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
