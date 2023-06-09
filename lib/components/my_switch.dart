import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smartStoveApp/utilities/notification.dart';

// ignore: must_be_immutable
class MySwitch extends StatefulWidget {
  BluetoothConnection? connection;
  MySwitch({super.key, required this.connection});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    Notifications.initialize(flutterLocalNotificationsPlugin);
  }

  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      widget.connection?.output.add(bytes);
      await widget.connection?.output.allSent;
      if (kDebugMode) {
        print('Data sent success');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  bool toggleValue = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        height: 40.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: toggleValue
              ? const Color.fromARGB(255, 223, 173, 11)
              : const Color.fromARGB(255, 228, 76, 38),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              curve: Curves.easeIn,
              top: 3.0,
              left: toggleValue ? 60.0 : 0.0,
              right: toggleValue ? 0.0 : 60.0,
              duration: const Duration(milliseconds: 1000),
              child: InkWell(
                onTap: toggleButton,
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: toggleValue
                        ? Icon(
                            Icons.power_settings_new,
                            color: Colors.black,
                            size: 35.0,
                            key: UniqueKey(),
                          )
                        : Icon(
                            Icons.not_interested,
                            color: Colors.black,
                            size: 35.0,
                            key: UniqueKey(),
                          )),
              ),
            )
          ],
        ),
      ),
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
      toggleValue ? sendData('1') : sendData('0');
      toggleValue
          ? Notifications.showBigTextNotification(
              title: 'The stove is On',
              body: 'Your stoves are on, please be careful !',
              fln: flutterLocalNotificationsPlugin,
            )
          : Notifications.showBigTextNotification(
              title: 'The stove is Off',
              body: 'Please be careful, they may still be hot!',
              fln: flutterLocalNotificationsPlugin,
            );
    });
  }
}
