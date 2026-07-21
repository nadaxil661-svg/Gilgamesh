import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../core/services/auth_service.dart';

class AddTrainerScreen extends StatefulWidget {
  const AddTrainerScreen({super.key});

  @override
  State<AddTrainerScreen> createState() => _AddTrainerScreenState();
}

class _AddTrainerScreenState extends State<AddTrainerScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _jobController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  void _handleRegister() async {
    if (_nameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty ||
        _jobController.text.isEmpty) {
      _showSnackBar('يرجى ملء جميع البيانات', Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.registerUserByAdmin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        role: 'supervisor', // In this system, supervisors and trainers share staff roles
        extraData: {
          'job': _jobController.text.trim(),
          'isTrainer': true,
        },
      );

      if (mounted) {
        _showSnackBar('تم تسجيل المدرب بنجاح', Colors.green);
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
      title: "إضافة مدرب جديد",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Icon(Icons.person_add_alt_1, size: 80, color: Colors.amber),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: "اسم المدرب الكامل",
              prefixIcon: Icons.person,
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "التخصص (المسمى الوظيفي)",
              prefixIcon: Icons.work_outline,
              controller: _jobController,
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
              text: "تسجيل المدرب",
              onPressed: _handleRegister,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
