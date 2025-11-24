import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final String errorMessage;

  const ErrorContainer({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 235, 215),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, size: 36, color: Colors.red),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              errorMessage,
              style: theme.textTheme.bodySmall!.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
