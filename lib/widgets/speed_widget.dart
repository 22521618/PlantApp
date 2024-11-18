import 'package:flutter/material.dart';

import 'package:plant_app/widgets/option_wdget.dart';
import 'package:plant_app/widgets/transparent_card.dart';

class SpeedWidget extends StatelessWidget {
  final int speed;
  final Function(int) changeSpeed;
  final String soilHumidity;

  const SpeedWidget({
    Key? key,
    required this.speed,
    required this.changeSpeed,
    required this.soilHumidity,
  }) : super(key: key);

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
            padding: const EdgeInsets.only(left: 15),
            child: const Text(
              "Humandity",
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OptionWidget(
                icon: 'assets/svg/drop.svg',
                isSelected: false,
                onTap: () {},
                size: 25,
              ),
              Text(
                "$soilHumidity%",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
