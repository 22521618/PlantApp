import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:plant_app/widgets/option_wdget.dart';
import 'package:plant_app/widgets/transparent_card.dart';

class AutoWidget extends StatelessWidget {
  final bool isActive;
  final Function(bool) onChanged;

  const AutoWidget({Key? key, required this.isActive, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          alignment: Alignment.center,
          scaleY: 0.8,
          scaleX: 0.85,
          child: CupertinoSwitch(
            onChanged: onChanged,
            value: isActive,
            activeColor: Colors.white.withOpacity(0.5),
            trackColor: Colors.black.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
