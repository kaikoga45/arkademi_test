import 'package:flutter/material.dart';

class SectionTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      tileColor: const Color(0xFFF1F2F4),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: textTheme.titleMedium?.fontSize ?? 16.0,
        ),
      ),
      subtitle: Text('$subtitle Menit'),
    );
  }
}
