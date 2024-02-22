import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.errorMessage,
    required this.onChange,
    this.obscureText = false,
    this.keyboardType = TextInputType.emailAddress,
  });

  final String label;
  final String? errorMessage;
  final TextInputType keyboardType;
  final Function(String?) onChange;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorText: errorMessage,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChange,
    );
  }
}
