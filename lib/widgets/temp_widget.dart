import 'package:flutter/material.dart';
import 'package:plant_app/widgets/transparent_card.dart';

class TempWidget extends StatelessWidget {
  final double temp;
  final Function(double) changeTemp;

  const TempWidget({Key? key, required this.temp, required this.changeTemp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String tempString = temp.toInt.toString();
    return Center(
      child: TransparentCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Temp",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  '0°C',
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                      min: 0,
                      max: 100,
                      value: temp,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white30,
                      onChanged: changeTemp),
                ),
                const Text(
                  '100°C',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  // cho hien temp
                  "${temp} °C",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
