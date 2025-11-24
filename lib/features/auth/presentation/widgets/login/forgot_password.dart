import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          context.push('/login/reset_password');
        },
        child: Text(
          'Забыли пароль?',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ),
    );
  }
}
