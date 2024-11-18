import 'dart:async';
import 'dart:ffi';

import 'package:animated_background/animated_background.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/services/global_varialble.dart';
import 'package:plant_app/utils/slider_utils.dart';
import 'package:plant_app/widgets/auto_widget.dart';
import 'package:plant_app/widgets/custom_appbar.dart';
import 'package:plant_app/widgets/option_wdget.dart';
import 'package:plant_app/widgets/power_widget.dart';
import 'package:plant_app/widgets/slider_widget.dart';
import 'package:plant_app/widgets/snackbar_widget.dart';
import 'package:plant_app/widgets/speed_widget.dart';
import 'package:plant_app/widgets/temp_widget.dart';

import 'package:rainbow_color/rainbow_color.dart';

class ControlPanelPage extends StatefulWidget {
  const ControlPanelPage({
    Key? key,
  }) : super(key: key);
  @override
  _ControlPanelPageState createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with TickerProviderStateMixin {
  final DatabaseReference _databaseReferenceSensor =
      FirebaseDatabase.instance.ref("Sensor");
  final DatabaseReference _databaseReferenceSoilSensor =
      FirebaseDatabase.instance.ref("SoilSensor");
  final _databaseReference = FirebaseDatabase.instance.ref();
  final DatabaseReference _databaseReferenceState =
      FirebaseDatabase.instance.ref("State");
  final DatabaseReference _databaseReferenceStateAlarmLight =
      FirebaseDatabase.instance.ref("Alarm").child("Light");
  final DatabaseReference _databaseReferenceStateAlarmMotor =
      FirebaseDatabase.instance.ref("Alarm").child("Motor");

// Only update the name, leave the age and address!

  String _sensorTemperature = "32";
  String _sensorHumidity = "50";
  String _soilSensorHumidity = "66";

  // CollectionReference colRef = FirebaseFirestore.instance.collection("abc");

  void ConnectingSensor() async {
    print("Connecting Sensor");
    try {
      _databaseReferenceSensor.child("Temperature").onValue.listen((event) {
        final dataSnapshotSensorTemperature = event.snapshot;
        setState(() {
          _sensorTemperature = dataSnapshotSensorTemperature.value.toString();

          print(" SensorTemp = $_sensorTemperature");
        });
      });
      _databaseReferenceSensor.child("Humidity").onValue.listen((event) {
        final dataSnapshotSensorHumidity = event.snapshot;
        setState(() {
          _sensorHumidity = dataSnapshotSensorHumidity.value.toString();
          _sensorHumidity = _sensorHumidity.split(".")[0];
          print(" SensorHumidity = $_sensorHumidity");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void ConnectingSoilSensor() async {
    print("Connecting Soil Sensor");
    try {
      _databaseReferenceSoilSensor
          .child("SoilHumidity")
          .onValue
          .listen((event) {
        final dataSnapshotSoilSensorHumidity = event.snapshot;
        setState(() {
          _soilSensorHumidity = dataSnapshotSoilSensorHumidity.value.toString();
          progressVal = double.parse(_soilSensorHumidity) / 100 + 0.01;
          print(" SoilSensor Humidity = $_soilSensorHumidity");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void ConnectingAuto() async {
    print("Connecting Auto");
    try {
      _databaseReference.child("Manual").onValue.listen((event) {
        final dataSnapshotAuto = event.snapshot;
        setState(() {
          isActiveManual =
              (dataSnapshotAuto.value.toString() == "1") ? true : false;

          print(" isActiveManual = $isActiveManual");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void ConnectingLight() async {
    print("Connecting Light");
    try {
      _databaseReferenceState.child("Light").onValue.listen((event) {
        final dataSnapshotLight = event.snapshot;
        setState(() {
          isActive = (dataSnapshotLight.value.toString() == "1") ? true : false;
          print(" isActive = $isActive");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  bool isActive = false;
  static bool isActiveManual = false;
  int speed = 3;
  double temp = 50;
  double progressVal = 0.34;

  var activeColor = Rainbow(spectrum: [
    Color.fromARGB(255, 19, 179, 67),
    Color.fromARGB(255, 19, 179, 67),
  ], rangeStart: 0.0, rangeEnd: 1.0);

  @override
  void initState() {
    super.initState();
    ConnectingSensor();
    ConnectingSoilSensor();
    ConnectingAuto();
    ConnectingLight();
  }

  @override
  void dispose() {
    // _streamSubscription.cancel();
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomAppBar(title: "Manual"),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                      ), // Đẩy nút sang góc phải
                      AutoWidget(
                        isActive: isActiveManual,
                        onChanged: (val) => setState(() {
                          isActiveManual = val;
                          if (isActiveManual == true) {
                            _databaseReference.update({
                              "Manual": 1,
                            });
                          } else {
                            _databaseReference.update({
                              "Manual": 0,
                            });
                            _databaseReferenceStateAlarmLight.update({
                              "TurnOn": 0,
                            });
                            _databaseReferenceStateAlarmMotor.update({
                              "TurnOn": 0,
                            });
                          }
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // options(),
                        SizedBox(
                          height: 10,
                        ),
                        slider(),
                        Text(
                          "Soil Humandity",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        controls(),
                      ],
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

  Widget slider() {
    return SliderWidget(
      progressVal: progressVal,
      color: activeColor[progressVal],
      onChange: (value) {
        setState(() {
          temp = value;
          progressVal = normalize(value, kMinDegree, kMaxDegree);
        });
      },
    );
  }

  Widget controls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6.35,
              width: MediaQuery.of(context).size.width / 2.35,
              child: SpeedWidget(
                speed: speed,
                changeSpeed: (val) => setState(() {
                  speed = val;
                }),
                soilHumidity: _sensorHumidity,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6.35,
              width: MediaQuery.of(context).size.width / 2.35,
              child: PowerWidget(
                  isActive: isActive,
                  onChanged: (val) {
                    if (isActiveManual == false) {
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Fail!',
                          message:
                              'You need to switch to manual mode to control the light!',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      setState(
                        () {
                          isActive = val;
                          if (isActive == true) {
                            _databaseReferenceState.update({
                              "Light": 1,
                            });
                          } else {
                            _databaseReferenceState.update({
                              "Light": 0,
                            });
                          }
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 120,
          child: TempWidget(
              temp: double.parse(_sensorTemperature), changeTemp: (val) => {}),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
