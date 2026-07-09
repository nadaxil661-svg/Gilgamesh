import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // تسجيل مستخدم جديد مع تحديد الدور (مدير، مشرف، طالب)
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String role, // 'admin', 'supervisor', 'student'
    required String name,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      if (user != null) {
        // حفظ بيانات المستخدم ودوره في Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.';
    }
  }

  // تسجيل الدخول
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.';
    }
  }

  // جلب دور المستخدم الحالي
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.get('role');
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // التعامل مع أخطاء Firebase وتحويلها للعربية
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
      case 'user-not-found':
        return 'لا يوجد مستخدم بهذا البريد الإلكتروني.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة.';
      default:
        return 'حدث خطأ في عملية المصادقة: ${e.message}';
    }
  }
}
