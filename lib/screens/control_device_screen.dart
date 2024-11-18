import 'package:animated_background/animated_background.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/models/weather_model.dart';
import 'package:plant_app/services/global_varialble.dart';
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
import 'package:plant_app/widgets/transparent_card_time.dart';
import 'package:plant_app/widgets/weather_widget.dart';

import 'package:rainbow_color/rainbow_color.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class ControlDeviceScreen extends StatefulWidget {
  const ControlDeviceScreen({
    Key? key,
  }) : super(key: key);
  @override
  _ControlDeviceScreenState createState() => _ControlDeviceScreenState();
}

class _ControlDeviceScreenState extends State<ControlDeviceScreen>
    with TickerProviderStateMixin {
  final DatabaseReference _databaseReferenceState =
      FirebaseDatabase.instance.ref("State");
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final DatabaseReference _databaseReferenceStateAlarmLight =
      FirebaseDatabase.instance.ref("Alarm").child("Light");
  final DatabaseReference _databaseReferenceStateAlarmMotor =
      FirebaseDatabase.instance.ref("Alarm").child("Motor");

  void ConnectingMotor() async {
    print("Connecting Motor");
    try {
      _databaseReferenceState.child("Motor").onValue.listen((event) {
        final dataSnapshotMotor = event.snapshot;
        setState(() {
          isActiveMotor =
              (dataSnapshotMotor.value.toString() == "1") ? true : false;
          print(" isActiveMotor = $isActiveMotor");
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
          isActiveManual1 =
              (dataSnapshotAuto.value.toString() == "1") ? true : false;

          print(" isActiveManual = $isActiveManual1");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void ConnectingAlarmLight() async {
    print("Connecting AlarmLight");
    try {
      _databaseReferenceStateAlarmLight.child("Hour").onValue.listen((event) {
        final dataSnapshotLightHour = event.snapshot;
        setState(() {
          hourLight = int.parse(dataSnapshotLightHour.value.toString());
          print(" hourLight = $hourLight");
        });
      });
      _databaseReferenceStateAlarmLight.child("Minute").onValue.listen((event) {
        final dataSnapshotLightMininute = event.snapshot;
        setState(() {
          minuteLight = int.parse(dataSnapshotLightMininute.value.toString());
          print(" MinuteLight= $minuteLight");
        });
      });
      _databaseReferenceStateAlarmLight
          .child("HourEnd")
          .onValue
          .listen((event) {
        final dataSnapshotLightHourEnd = event.snapshot;
        setState(() {
          hourLightEnd = int.parse(dataSnapshotLightHourEnd.value.toString());
          print(" hourLightEnd = $hourLightEnd");
        });
      });
      _databaseReferenceStateAlarmLight
          .child("MinuteEnd")
          .onValue
          .listen((event) {
        final dataSnapshotLightMinuteEnd = event.snapshot;
        setState(() {
          minuteLightEnd =
              int.parse(dataSnapshotLightMinuteEnd.value.toString());
          print(" MininuteLightEnd = $minuteLightEnd");
        });
      });
      _databaseReferenceStateAlarmLight.child("TurnOn").onValue.listen((event) {
        final dataSnapshotLightTurnOn = event.snapshot;
        setState(() {
          TurnOnLight = int.parse(dataSnapshotLightTurnOn.value.toString());
          isActiveTimeLight = (TurnOnLight == "1") ? true : false;
          print(" TurnOnLight = $TurnOnLight");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void ConnectingAlarmMotor() async {
    print("Connecting AlarmMotor");
    try {
      _databaseReferenceStateAlarmMotor.child("Hour").onValue.listen((event) {
        final dataSnapshotMotorHour = event.snapshot;
        setState(() {
          hourMotor = int.parse(dataSnapshotMotorHour.value.toString());
          dateTimeMotor = DateTime(0, 1, 1, hourMotor, minuteMotor);
          print(" hourMotor = $hourMotor");
          print("dateTimeMotor : $dateTimeMotor");
        });
      });
      _databaseReferenceStateAlarmMotor.child("Minute").onValue.listen((event) {
        final dataSnapshotMotorMininute = event.snapshot;
        setState(() {
          minuteMotor = int.parse(dataSnapshotMotorMininute.value.toString());
          print(" MinuteMotor= $minuteMotor");
          dateTimeMotor = DateTime(0, 1, 1, hourMotor, minuteMotor);
          print("dateTimeMotor : $dateTimeMotor");
        });
      });

      _databaseReferenceStateAlarmMotor
          .child("HourEnd")
          .onValue
          .listen((event) {
        final dataSnapshotMotorHourEnd = event.snapshot;
        setState(() {
          hourMotorEnd = int.parse(dataSnapshotMotorHourEnd.value.toString());
          dateTimeMotorEnd = DateTime(0, 1, 1, hourMotorEnd, minuteMotorEnd);
          print(" hourMotorEnd = $hourMotorEnd");
          print("dateTimeMotorEnd : $dateTimeMotorEnd");
        });
      });
      _databaseReferenceStateAlarmMotor
          .child("MinuteEnd")
          .onValue
          .listen((event) {
        final dataSnapshotMotorMinuteEnd = event.snapshot;
        setState(() {
          minuteMotorEnd =
              int.parse(dataSnapshotMotorMinuteEnd.value.toString());
          dateTimeMotorEnd = DateTime(0, 1, 1, hourMotorEnd, minuteMotorEnd);
          print("dateTimeMotorEnd : $dateTimeMotorEnd");
          print(" MininuteMotorEnd = $minuteMotorEnd");
        });
      });
      dateTimeMotorEnd = DateTime(0, 1, 1, hourMotorEnd, minuteMotorEnd);
      print("dateTimeMotorEnd : $dateTimeMotorEnd");
      _databaseReferenceStateAlarmMotor.child("TurnOn").onValue.listen((event) {
        final dataSnapshotMotorTurnOn = event.snapshot;
        setState(() {
          TurnOnMotor = int.parse(dataSnapshotMotorTurnOn.value.toString());
          isActiveTimeMotor = (TurnOnMotor == "1") ? true : false;
          print(" TurnOnMotor = $TurnOnMotor");
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  DateTime dateTimeLight = DateTime.now();
  DateTime dateTimeLightEnd = DateTime.now();
  DateTime dateTimeMotor = DateTime.now();
  DateTime dateTimeMotorEnd = DateTime.now();

  int hourLight = 0;
  int minuteLight = 0;
  int hourLightEnd = 0;
  int minuteLightEnd = 0;
  int TurnOnLight = 0;
  bool isActiveTimeLight = false;
  bool isActiveTimeMotor = false;

  int hourMotor = 0;
  int minuteMotor = 0;
  int hourMotorEnd = 0;
  int minuteMotorEnd = 0;
  int TurnOnMotor = 0;

  bool isActiveManual1 = false;

  bool isActiveMotor = true;
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
    ConnectingMotor();
    ConnectingAuto();
    ConnectingAlarmLight();
    ConnectingAlarmMotor();
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
                children: [
                  const CustomAppBar(title: "Thủ Đức, Hồ Chí Minh"),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // options(),
                          WeatherWidget(),
                          // SizedBox(
                          //   height: 200,
                          // ),
                          controls(),
                        ],
                      ),
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

  Widget controls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 170,
              child: ControlMotor(
                  isActive: isActiveMotor,
                  onChanged: (val) {
                    if (isActiveManual1 == false) {
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Fail!',
                          message:
                              'You need to switch to manual mode to control the Motor!',

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
                          isActiveMotor = val;
                          if (isActiveMotor == true) {
                            _databaseReferenceState.update({
                              "Motor": 1,
                            });
                          } else {
                            _databaseReferenceState.update({
                              "Motor": 0,
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
          height: 15,
        ),
        Container(
          height: 125,
          child: Center(
            child: TransparentCardTime(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Set time for light                                             ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "On",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      // OptionWidget(
                      //   icon: 'assets/svg/time.svg',
                      //   isSelected: false,
                      //   onTap: () {},
                      //   size: 25,
                      // ),
                      TimePickerSpinnerPopUp(
                        iconSize: 25,
                        // barrierColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        mode: CupertinoDatePickerMode.time,
                        initTime: dateTimeLight,
                        onChange: (dateTime) {
                          dateTimeLight = dateTime;
                          print(dateTime);
                        },
                      ),
                      Text(
                        "Off",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      TimePickerSpinnerPopUp(
                        iconSize: 25,
                        // barrierColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        mode: CupertinoDatePickerMode.time,
                        initTime: dateTimeLightEnd,
                        onChange: (dateTimeEnd) {
                          dateTimeLightEnd = dateTimeEnd;
                          print(dateTimeEnd);
                        },
                      ),
                      Transform.scale(
                        alignment: Alignment.center,
                        scaleY: 0.8,
                        scaleX: 0.85,
                        child: CupertinoSwitch(
                          onChanged: (val) {
                            if (isActiveManual1 == false) {
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.fixed,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Fail!',
                                  message:
                                      'You need to switch to manual mode to set time for the light!',

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
                                  isActiveTimeLight = val;
                                  if (isActiveTimeLight == true) {
                                    _databaseReferenceStateAlarmLight.update({
                                      "TurnOn": 1,
                                    });
                                    hourLight = dateTimeLight.hour;
                                    _databaseReferenceStateAlarmLight.update({
                                      "Hour": hourLight,
                                    });
                                    minuteLight = dateTimeLight.minute;
                                    _databaseReferenceStateAlarmLight.update({
                                      "Minute": minuteLight,
                                    });
                                    hourLightEnd = dateTimeLightEnd.hour;
                                    _databaseReferenceStateAlarmLight.update({
                                      "HourEnd": hourLightEnd,
                                    });
                                    minuteLightEnd = dateTimeLightEnd.minute;
                                    _databaseReferenceStateAlarmLight.update({
                                      "MinuteEnd": minuteLightEnd,
                                    });
                                  } else {
                                    _databaseReferenceStateAlarmLight.update({
                                      "TurnOn": 0,
                                    });
                                  }
                                },
                              );
                            }
                          },
                          value: isActiveTimeLight,
                          activeColor: Colors.white.withOpacity(0.5),
                          trackColor: Colors.black.withOpacity(0.2),
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
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 120,
          child: Center(
            child: TransparentCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Set time for motor                                                      ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "On",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      // OptionWidget(
                      //   icon: 'assets/svg/time.svg',
                      //   isSelected: false,
                      //   onTap: () {},
                      //   size: 25,
                      // ),
                      TimePickerSpinnerPopUp(
                        iconSize: 25,
                        // barrierColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        mode: CupertinoDatePickerMode.time,
                        initTime: dateTimeMotor,
                        onChange: (dateTime) {
                          dateTimeMotor = dateTime;
                          print(dateTime);
                        },
                      ),
                      Text(
                        "Off",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      TimePickerSpinnerPopUp(
                        iconSize: 25,
                        // barrierColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        mode: CupertinoDatePickerMode.time,
                        initTime: dateTimeMotorEnd,
                        onChange: (dateTimeEnd) {
                          dateTimeMotorEnd = dateTimeEnd;
                          print(dateTimeEnd);
                        },
                      ),
                      Transform.scale(
                        alignment: Alignment.center,
                        scaleY: 0.8,
                        scaleX: 0.85,
                        child: CupertinoSwitch(
                          onChanged: (val) {
                            if (isActiveManual1 == false) {
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.fixed,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Fail!',
                                  message:
                                      'You need to switch to manual mode to set time for the Motor!',

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
                                  isActiveTimeMotor = val;
                                  if (isActiveTimeMotor == true) {
                                    _databaseReferenceStateAlarmMotor.update({
                                      "TurnOn": 1,
                                    });
                                    hourMotor = dateTimeMotor.hour;
                                    _databaseReferenceStateAlarmMotor.update({
                                      "Hour": hourMotor,
                                    });
                                    minuteMotor = dateTimeMotor.minute;
                                    _databaseReferenceStateAlarmMotor.update({
                                      "Minute": minuteMotor,
                                    });
                                    hourMotorEnd = dateTimeMotorEnd.hour;
                                    _databaseReferenceStateAlarmMotor.update({
                                      "HourEnd": hourMotorEnd,
                                    });
                                    minuteMotorEnd = dateTimeMotorEnd.minute;
                                    _databaseReferenceStateAlarmMotor.update({
                                      "MinuteEnd": minuteMotorEnd,
                                    });
                                  } else {
                                    _databaseReferenceStateAlarmMotor.update({
                                      "TurnOn": 0,
                                    });
                                  }
                                },
                              );
                            }
                          },
                          value: isActiveTimeMotor,
                          activeColor: Colors.white.withOpacity(0.5),
                          trackColor: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 0,
        ),
      ],
    );
  }
}
