import 'package:flutter/material.dart';

class coustm_Text_field extends StatelessWidget {
  final String name;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  bool? isSecure;

    coustm_Text_field({
    super.key, // renamed the constructor parameter
     required this.name,
    required this.icon,
    required this.validator,
    required this.controller,
    this.isSecure, // this is the field
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecure ?? false,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        fillColor: Colors.grey.shade200,
        filled: true,
        labelText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
    );
  }
}
