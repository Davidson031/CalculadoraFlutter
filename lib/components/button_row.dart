import 'package:flutter/material.dart';

import 'button.dart';

class ButtonRow extends StatelessWidget {
  
  final List<Button> buttons;

  ButtonRow({
    required this.buttons
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.fold(<Widget>[], (lista, button){
          lista.isEmpty ? lista.add(button) : lista.addAll([const SizedBox(width: 1), button]);
          return lista;
        }),
      ),
    );
  }
}