import 'package:flutter/material.dart';

class RegisterPasswordTextField extends StatelessWidget {
  const RegisterPasswordTextField({
    super.key,
    required this.passwordController,
    required this.obscurePassword,
    this.onPressed,
    required this.label,
  });

  final TextEditingController passwordController;
  final bool obscurePassword;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: passwordController,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3498DB)),
        ),
        filled: true,
        fillColor: theme.cardColor,
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
