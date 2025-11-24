import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRegister extends StatelessWidget {
  const GoRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Нет аккаунта? ', style: TextStyle(color: Colors.grey[600])),
        GestureDetector(
          onTap: () {
            context.push('/register');
          },
          child: const Text(
            'Зарегистрироваться',
            style: TextStyle(
              color: Color(0xFF3498DB),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
