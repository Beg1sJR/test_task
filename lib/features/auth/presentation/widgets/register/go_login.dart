import 'package:flutter/material.dart';

class GoLogin extends StatelessWidget {
  const GoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Уже есть аккаунт? ', style: TextStyle(color: Colors.grey[600])),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Войти',
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
