import 'package:flutter/material.dart';
import 'navigation_wrapper.dart';

/// واجهة قائمة الطلاب
/// تم تصحيح سهم الرجوع وتنسيق شريط الأدوات الموحد
class StudentsScreen extends StatelessWidget {
  final bool isGuest;
  const StudentsScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, elevation: 0, 
          leading: IconButton(
            // تصحيح السهم ليشير للجهة المقابلة (العودة في RTL)
            icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28), 
            onPressed: () => Navigator.pop(context)
          ), 
          title: const Text('قائمة الطلاب', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), 
          centerTitle: false
        ),
        body: _buildList(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: 0, 
          isGuest: isGuest,
          onTap: (idx) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => NavigationWrapper(initialIndex: idx, isGuest: isGuest)), (r) => false),
        ),
      ),
    );
  }

  Widget _buildList() {
    final List<Map<String, String>> students = [
      {'name': 'شهد فهد', 'email': 'shahed.f@student.edu', 'img': 'assets/طالب1.png'},
      {'name': 'سارة  خليل', 'email': 'dana.k@student.edu', 'img': 'assets/طالب2.png'},
      {'name': 'ساري  صليبي', 'email': 'dana.k@student.edu', 'img': 'assets/طالب3.png'},
      {'name': 'هادي  النوار', 'email': 'dana.k@student.edu', 'img': 'assets/طالب4.png'},
      {'name': 'لانا  غيث', 'email': 'dana.k@student.edu', 'img': 'assets/طالب6.png'},

    ];
    return ListView.builder(
      padding: const EdgeInsets.all(15), itemCount: students.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade50), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 5))]),
        child: Row(children: [
          CircleAvatar(radius: 28, backgroundImage: AssetImage(students[index]['img']!)),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(students[index]['name']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)), Text(students[index]['email']!, style: const TextStyle(fontSize: 11, color: Colors.grey))])),
          const Icon(Icons.phone_enabled, color: Color(0xFFFBEC21)),
        ]),
      ),
    );
  }
}
