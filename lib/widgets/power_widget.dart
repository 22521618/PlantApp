import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:plant_app/widgets/option_wdget.dart';
import 'package:plant_app/widgets/transparent_card.dart';

class PowerWidget extends StatelessWidget {
  final bool isActive;
  final Function(bool) onChanged;

  const PowerWidget({Key? key, required this.isActive, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              "Light",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OptionWidget(
                icon: 'assets/svg/bright.svg',
                isSelected: false,
                onTap: () {},
                size: 25,
              ),
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
          ),
        ],
      ),
    );
  }
}
