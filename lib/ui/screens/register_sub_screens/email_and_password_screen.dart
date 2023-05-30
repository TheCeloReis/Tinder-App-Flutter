import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/ui/widgets/bordered_text_field.dart';

class EmailAndPasswordScreen extends StatelessWidget {
  final Function(String) emailOnChanged;
  final Function(String) passwordOnChanged;

  EmailAndPasswordScreen(
      {@required this.emailOnChanged, @required this.passwordOnChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meu email e',
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          'senha são',
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(height: 25),
        BorderedTextField(
          labelText: 'Email',
          onChanged: emailOnChanged,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 5),
        BorderedTextField(
          labelText: 'Senha',
          onChanged: passwordOnChanged,
          obscureText: true,
        ),
      ],
    );
  }
}
