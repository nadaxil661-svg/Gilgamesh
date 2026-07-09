import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../core/services/auth_service.dart';
import 'signup_screen.dart';
import '../../../home/presentation/screens/navigation_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('يرجى إدخال البريد الإلكتروني وكلمة المرور', Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    try {
      UserCredential? result = await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (result != null && result.user != null) {
        String? role = await _authService.getUserRole(result.user!.uid);
        
        if (mounted) {
          _showSnackBar(
            'أهلاً بك، دورك هو: ${role == 'admin' ? 'مدير' : role == 'supervisor' ? 'مشرف' : 'طالب'}',
            Colors.blue,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => const NavigationWrapper(isGuest: false)),
          );
        }
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/1imag.png', height: 120, width: 100, 
                errorBuilder: (c, e, s) => const Icon(Icons.image, size: 100)),
              const SizedBox(height: 20),
              const Text("أهلاً بعودتك", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("واصل رحلتك التعليمية وحقق طموحاتك الأكاديمية", 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 16, color: Colors.black87)),
              const SizedBox(height: 50),
              CustomTextField(
                hintText: "البريد الإلكتروني", 
                prefixIcon: Icons.email, 
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: "كلمة المرور", 
                prefixIcon: Icons.lock, 
                isPassword: true, 
                controller: _passwordController,
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "تسجيل دخول", 
                onPressed: _handleLogin, 
                isLoading: _isLoading,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.push(context, 
                  MaterialPageRoute(builder: (c) => const SignupScreen())),
                child: const Text("ليس لديك حساب؟ إنشاء حساب جديد", 
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              _buildDivider(),
              const SizedBox(height: 20),
              CustomButton(
                text: "تسجيل كزائر", 
                onPressed: () => Navigator.push(context, 
                  MaterialPageRoute(builder: (c) => const NavigationWrapper(isGuest: true))),
                isOutlined: true,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("أو", style: TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }
}
