import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({super.key, required this.nameController});
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Имя',
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
