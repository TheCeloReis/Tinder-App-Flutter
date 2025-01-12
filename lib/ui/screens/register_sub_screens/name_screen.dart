import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/ui/widgets/bordered_text_field.dart';

class NameScreen extends StatelessWidget {
  final Function(String) onChanged;
  final String initialValue;

  NameScreen({@required this.onChanged, @required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                'Meu nome é',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        Expanded(
          child: BorderedTextField(
            labelText: 'Nome',
            onChanged: onChanged,
            textController: TextEditingController(text: initialValue),
            textCapitalization: TextCapitalization.words,
          ),
        ),
      ],
    );
  }
}
