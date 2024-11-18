import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/core/color.dart';
import 'package:plant_app/data/category_model.dart';
import 'package:plant_app/data/plant_data.dart';
import 'package:plant_app/models/weather_model.dart';
import 'package:plant_app/page/details_page.dart';
import 'package:plant_app/services/weather_service.dart';
import 'package:plant_app/utils/slider_utils.dart';
import 'package:plant_app/widgets/control_motor.dart';
import 'package:plant_app/widgets/custom_appbar.dart';
import 'package:plant_app/widgets/option_wdget.dart';
import 'package:plant_app/widgets/power_widget.dart';
import 'package:plant_app/widgets/slider_widget.dart';
import 'package:plant_app/widgets/speed_widget.dart';
import 'package:plant_app/widgets/temp_widget.dart';
import 'package:plant_app/widgets/transparent_card.dart';
import 'package:plant_app/widgets/weather_widget.dart';

import 'package:rainbow_color/rainbow_color.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  PageController controller = PageController();
  bool isActive = true;
  int speed = 3;
  double temp = 50;
  double progressVal = 0.67;

  var activeColor = Rainbow(spectrum: [
    Color.fromARGB(255, 19, 179, 67),
    Color.fromARGB(255, 19, 179, 67),
  ], rangeStart: 0.0, rangeEnd: 1.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white,
                activeColor[progressVal].withOpacity(0.5),
                activeColor[progressVal]
              ]),
        ),
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
            baseColor: const Color(0xFFFFFFFF),
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.3,
            spawnMinSpeed: speed * 60.0,
            spawnMaxSpeed: speed * 120,
            spawnMinRadius: 2.0,
            spawnMaxRadius: 5.0,
            particleCount: speed * 150,
          )),
          vsync: this,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 45.0,
                          width: 350.0,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: green),
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 45,
                                width: 300,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/icons/search.png',
                                height: 25,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < categories.length; i++)
                          GestureDetector(
                            onTap: () {
                              setState(() => selectId = categories[i].id);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categories[i].name,
                                  style: TextStyle(
                                    color: selectId == i ? green : black,
                                    fontSize: 16.0,
                                  ),
                                ),
                                if (selectId == i)
                                  const CircleAvatar(
                                    radius: 3,
                                    backgroundColor: green,
                                  )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 350.0,
                    width: 300,
                    child: PageView.builder(
                      itemCount: plants.length,
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      padEnds: false,
                      pageSnapping: true,
                      onPageChanged: (value) =>
                          setState(() => activePage = value),
                      itemBuilder: (itemBuilder, index) {
                        bool active = index == activePage;
                        return slider(active, index);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular',
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        Image.asset(
                          'assets/icons/more.png',
                          color: green,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 150.0,
                    child: ListView.builder(
                      itemCount: populerPlants.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 20.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (itemBuilder, index) {
                        return Container(
                          width: 200.0,
                          margin: const EdgeInsets.only(right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: lightGreen,
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    populerPlants[index].imagePath,
                                    width: 70,
                                    height: 70,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        populerPlants[index].name,
                                        style: TextStyle(
                                          color: black.withOpacity(0.7),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        '\$${populerPlants[index].price.toStringAsFixed(0)}',
                                        style: TextStyle(
                                          color: black.withOpacity(0.4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                right: 20,
                                bottom: 20,
                                child: CircleAvatar(
                                  backgroundColor: green,
                                  radius: 15,
                                  child: Image.asset(
                                    'assets/icons/heart.png',
                                    color: white,
                                    height: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer slider(active, index) {
    double margin = active ? 20 : 30;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: mainPlantsCard(index),
    );
  }

  Widget mainPlantsCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => DetailsPage(plant: plants[index]),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
          ],
          border: Border.all(color: green, width: 2),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightGreen,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: AssetImage(plants[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: CircleAvatar(
                backgroundColor: green,
                radius: 15,
                child: Image.asset(
                  'assets/icons/heart.png',
                  color: white,
                  height: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '${plants[index].name} ',
                  style: TextStyle(
                    color: black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int selectId = 0;
  int activePage = 0;
}
