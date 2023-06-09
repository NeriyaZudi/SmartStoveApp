// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartStoveApp/components/button_widget.dart';
import 'package:smartStoveApp/components/food_info.dart';
import 'package:smartStoveApp/components/navigation_bar.dart';
import 'package:smartStoveApp/pages/feedback_page.dart';
import 'package:smartStoveApp/utilities/notification.dart';
import 'package:smartStoveApp/utilities/show_cancel_dialog.dart';
import 'package:smartStoveApp/utilities/show_end_dialog.dart';
import 'package:smartStoveApp/utilities/show_error_dialog.dart';

class CookingPage extends StatefulWidget {
  final String title;
  final String name;
  final String img;
  final String time;
  final String temperature;
  final int totalTime;
  final int turnOffTime;
  const CookingPage({
    super.key,
    required this.title,
    required this.name,
    required this.img,
    required this.time,
    required this.temperature,
    required this.totalTime,
    required this.turnOffTime,
  });

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends State<CookingPage> {
  final Color firstColor = const Color.fromARGB(255, 148, 179, 174);
  final Color secondColor = const Color.fromARGB(255, 8, 67, 143);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int seconds = 140;
  static int stratSeconds = 140;
  Duration duration = const Duration();
  Timer? timer;
  Timer? timerTemp;
  bool isActive = true;
  BluetoothConnection? connection;
  String macAddress = "00:22:06:30:48:2D";
  String currentTemperature = '0.0';
  String receivedData = '';
  String stoveState = 'ON 🔛';

  @override
  void initState() {
    seconds = widget.totalTime * 60;
    stratSeconds = widget.totalTime * 60;
    super.initState();
    loadDevices();
    startTimer();
    startTimerTemp();
    Notifications.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  void dispose() {
    startTimerTemp();
    super.dispose();
  }

  Future<void> sendData(String data) async {
    data = data.trim();

    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      connection?.output.add(bytes);
      await connection?.output.allSent;
      if (kDebugMode) {
        print('Data sent success');
      }
      if (data == '!') {
        connection?.finish(); // Closing connection
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadDevices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
    ].request();
    PermissionStatus status = statuses[Permission.bluetooth]!;
    if (status.isGranted) {
      connectBluetooth(macAddress);
    } else {
      print('ERROR');
    }
  }

  Future connectBluetooth(String address) async {
    try {
      BluetoothConnection connect =
          await BluetoothConnection.toAddress(address);
      setState(() {
        connection = connect;
      });
      sendData('1');
      Notifications.showBigTextNotification(
        title: 'The stove is On',
        body: 'Your stoves are on, please be careful while cooking',
        fln: flutterLocalNotificationsPlugin,
      );
    } catch (exception) {
      print('Cannot connect, exception occured\n' + exception.toString());
      showErrorDialog(context, 'Bluetooth device connection error');
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds == (widget.turnOffTime * 60)) {
          setState(() {
            stoveState = 'OFF 📴';
          });
          sendData('0');
          Notifications.showBigTextNotification(
            title: 'The stove is Off',
            body: 'Please be careful, they may still be hot!',
            fln: flutterLocalNotificationsPlugin,
          );
          showEndDialog(context);
        }
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          stopTimer();
          Notifications.showBigTextNotification(
            title: 'Finish Cooking',
            body:
                'The cooking process is over, now you can take the food off the stove and eat. Have fun :)',
            fln: flutterLocalNotificationsPlugin,
          );
        }
      },
    );
  }

  void startTimerTemp() {
    const duration = Duration(seconds: 5);

    timerTemp = Timer.periodic(duration, (Timer t) {
      String receivedData = ''; // Variable to accumulate received data

      connection!.input!.listen((Uint8List data) {
        String newData = String.fromCharCodes(data);
        receivedData += newData; // Accumulate received data

        if (receivedData.contains('\n')) {
          List<String> messages =
              receivedData.split('\n'); // Split by newline character
          receivedData = messages
              .last; // Store any incomplete message for the next iteration

          for (int i = 0; i < messages.length - 1; i++) {
            String message = messages[i].trim();

            setState(() {
              currentTemperature =
                  message; // Append the temperature to the current value
            });
          }
        }
      });
    });
  }

  void stopTimer() {
    if (isActive) {
      setState(() {
        timer?.cancel();
        isActive = false;
      });
    } else {
      setState(() {
        startTimer();
        isActive = true;
      });
    }
  }

  void stopTimerTemp() {
    timerTemp?.cancel();
  }

  void cancelTimer() async {
    setState(() {
      timer?.cancel();
      isActive = false;
    });
    final isCancel = await showCancelDialog(context);
    if (isCancel) {
      Notifications.showBigTextNotification(
        title: 'Stop Cooking Process',
        body: 'The cooking process has stopped',
        fln: flutterLocalNotificationsPlugin,
      );
      setState(() {
        seconds = widget.totalTime;
      });
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const MyNavigationBar();
        },
      ));
    } else {
      setState(() {
        startTimer();
        isActive = true;
      });
    }
  }

  void navigateFeedBacKPage() {
    switch (widget.name) {
      case 'Rice 🍚':
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return FeedbackPage(
              img: 'lib/images/rice-f.png',
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
            );
          },
        ));
        break;
      case 'Egg 🥚':
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return FeedbackPage(
              img: 'lib/images/egg-f.png',
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
            );
          },
        ));
        break;
      case 'Pasta 🍝':
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return FeedbackPage(
              img: 'lib/images/pasta-f.png',
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
            );
          },
        ));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [firstColor, secondColor],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home_rounded),
                      color: Colors.white.withOpacity(0.8),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const MyNavigationBar();
                          },
                        ));
                      },
                    ),
                    const SizedBox(width: 50),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.img,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Food Type: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: secondColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildDetailsShow(),
                      const SizedBox(height: 15),
                      buildTimer(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildButtons(),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailsShow() {
    return seconds == 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      Text(
                        textAlign: TextAlign.center,
                        'We would love to receive your feedback 🙏',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: firstColor),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [secondColor, firstColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: ButtonWidget(
                          text: "Give Feedback",
                          bgcolor: Colors.transparent,
                          icon: const Icon(Icons.thumb_up),
                          onClick: () {
                            navigateFeedBacKPage();
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              FoodInfo(
                text: 'Current Temperature:   $currentTemperature 🌡️',
                icon: Icons.whatshot,
              ),
              FoodInfo(
                text: 'Stove State:   $stoveState',
                icon: Icons.toggle_on,
              ),
            ],
          );
  }

  buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 72,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(header),
        const SizedBox(height: 25),
      ],
    );
  }

  buildButtons() {
    final isCompleted = seconds == 0;
    return !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [secondColor, firstColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ButtonWidget(
                  text: isActive ? 'Pause' : 'Resume',
                  bgcolor: Colors.transparent, // Set bgcolor to transparent
                  icon: isActive
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_circle),
                  onClick: () {
                    stopTimer();
                  },
                ),
              ),
              const SizedBox(width: 30),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 244, 168, 54),
                      Colors.red.shade400
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ButtonWidget(
                  text: 'Stop',
                  bgcolor: Colors.transparent, // Set bgcolor to transparent
                  icon: const Icon(Icons.stop),
                  onClick: () {
                    cancelTimer();
                  },
                ),
              ),
            ],
          )
        : Text(
            'DONE',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: secondColor),
          );
  }

  buildTimer() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / stratSeconds,
            valueColor: AlwaysStoppedAnimation(firstColor),
            backgroundColor: secondColor,
            strokeWidth: 16,
          ),
          Center(child: buildTime()),
        ],
      ),
    );
  }

  Widget buildTime() {
    String timeStr = formatedTime(timeInSecond: seconds);
    return seconds == 0
        ? Icon(Icons.done, color: secondColor, size: 110)
        : Text(
            timeStr,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: secondColor, fontSize: 55),
          );
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }
}
