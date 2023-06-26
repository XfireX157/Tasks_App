import 'package:flutter/material.dart';

class Difficuty extends StatelessWidget {
  final int dificutyLevel;

  const Difficuty({
    required this.dificutyLevel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star,
            size: 15,
            color: dificutyLevel >= 1 ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color: dificutyLevel >= 2 ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color: dificutyLevel >= 3 ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color: dificutyLevel >= 4 ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color: dificutyLevel >= 5 ? Colors.blue : Colors.blue[100]),
      ],
    );
  }
}
