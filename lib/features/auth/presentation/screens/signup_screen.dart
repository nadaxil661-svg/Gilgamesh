import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../core/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String _selectedRole = 'student';
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  final Map<String, String> _roles = {
    'admin': 'مدير',
    'supervisor': 'مشرف',
    'student': 'طالب',
  };

  void _handleSignup() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty) {
      _showSnackBar('يرجى ملء جميع الحقول', Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: _selectedRole,
        name: _nameController.text.trim(),
      );
      
      if (mounted) {
        _showSnackBar('تم إنشاء الحساب بنجاح', Colors.green);
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
      title: 'إنشاء حساب جديد',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'الاسم الكامل', 
              prefixIcon: Icons.person, 
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'البريد الإلكتروني', 
              prefixIcon: Icons.email, 
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'كلمة المرور', 
              prefixIcon: Icons.lock, 
              isPassword: true, 
              controller: _passwordController,
            ),
            const SizedBox(height: 30),
            const Text('اختر نوع الحساب:', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildRoleSelector(),
            const SizedBox(height: 40),
            CustomButton(
              text: "إنشاء الحساب", 
              onPressed: _handleSignup, 
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return RadioGroup<String>(
      groupValue: _selectedRole,
      onChanged: (value) => setState(() => _selectedRole = value!),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _roles.entries.map((entry) {
          return Column(
            children: [
              Radio<String>(
                value: entry.key,
              ),
              Text(entry.value),
            ],
          );
        }).toList(),
      ),
    );
  }
}
