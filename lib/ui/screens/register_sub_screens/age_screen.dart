import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

class AgeScreen extends StatefulWidget {
  final Function(num) onChanged;
  final num initialValue;

  AgeScreen({@required this.onChanged, @required this.initialValue});

  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int age;

  @override
  void initState() {
    super.initState();
    age = widget.initialValue != null ? widget.initialValue : 18;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Minha idade é',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              child: NumberPicker(
                  itemWidth: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffff5890), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  value: age,
                  minValue: 18,
                  maxValue: 120,
                  onChanged: (value) => {
                        setState(() {
                          age = value;
                        }),
                        widget.onChanged(value)
                      }),
            ),
          ),
        ),
      ],
    );
  }
}
