import 'package:flutter/material.dart';
import 'package:plant_app/core/color.dart';
import 'package:plant_app/data/plant_model.dart';

class DetailsPage extends StatelessWidget {
  final Plants plant;
  const DetailsPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height / 2,
                  decoration: BoxDecoration(
                    color: lightGreen,
                    boxShadow: [
                      BoxShadow(
                        color: green.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    image: DecorationImage(
                      image: AssetImage(plant.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: plant.name,
                                  style: TextStyle(
                                    color: black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                TextSpan(
                                  text: '  (${plant.category} Plant)',
                                  style: TextStyle(
                                    color: black.withOpacity(0.5),
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 30.0,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: green,
                              boxShadow: [
                                BoxShadow(
                                  color: green.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image.asset(
                              'assets/icons/heart.png',
                              color: white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      RichText(
                        text: TextSpan(
                          text: plant.description,
                          style: TextStyle(
                            color: black.withOpacity(0.5),
                            fontSize: 15.0,
                            height: 1.4,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Treatment',
                        style: TextStyle(
                          color: black.withOpacity(0.9),
                          fontSize: 18.0,
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/icons/sun.png',
                                  color: black, height: 24.0),
                              SizedBox(height: 15),
                              Text(
                                "${plant.light}",
                                style: TextStyle(
                                  color: black.withOpacity(0.9),
                                  fontSize: 18.0,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset('assets/icons/drop.png',
                                  color: black, height: 24.0),
                              SizedBox(height: 15),
                              Text(
                                "${plant.humandity}",
                                style: TextStyle(
                                  color: black.withOpacity(0.9),
                                  fontSize: 18.0,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset('assets/icons/temperature.png',
                                  color: black, height: 24.0),
                              SizedBox(height: 15),
                              Text(
                                "${plant.temp}",
                                style: TextStyle(
                                  color: black.withOpacity(0.9),
                                  fontSize: 18.0,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
