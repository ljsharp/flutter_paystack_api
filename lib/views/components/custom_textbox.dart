import 'package:flutter/material.dart';

class CustomTextbox extends StatelessWidget {
  const CustomTextbox({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
