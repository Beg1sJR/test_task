import 'package:flutter/material.dart';

class LastNameTextField extends StatelessWidget {
  const LastNameTextField({super.key, required this.lastNameController});
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: lastNameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Фамилия',
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
      ),
    );
  }
}
