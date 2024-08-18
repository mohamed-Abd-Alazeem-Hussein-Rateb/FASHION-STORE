import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Home_screen.dart';
import 'package:flutter_application_1/screens/Register_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
  
}

class _SplachScreenState extends State<SplachScreen> {
  @override
void initState() {
  super.initState();
  Future.delayed(Duration(seconds: 8), () {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }
  );
}

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  'images/logo.svg', // حط هنا مسار الصورة بتاعتك
                  width: 115, // ممكن تحدد العرض والارتفاع اللي يناسبك
                  height: 115,
                ),
              ),
            ),
            Text(
              'Developer : Mohamed Abd El-Azeem',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
