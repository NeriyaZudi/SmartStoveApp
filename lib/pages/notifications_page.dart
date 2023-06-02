// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/components/my_switch.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/utilities/show_error_dialog.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Color firstColor = const Color.fromARGB(255, 223, 173, 11);
  final Color secondColor = const Color.fromARGB(255, 228, 76, 38);
  BluetoothConnection? connection;
  String macAddress = "00:22:06:30:48:2D";
  dynamic currentTemperature;
  bool isTurnOnAlert = false;
  bool isTurnOffAlert = false;
  bool isfinishCookingAlert = false;

  @override
  void initState() {
    super.initState();
    loadDevices();
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
      if (data == '2') {
        connection?.input?.listen((data) {
          // Convert the received bytes to a string
          dynamic receivedNumber = data[0];
          setState(() {
            currentTemperature = receivedNumber;
          });

          // Handle the received data
          print('Received data: $receivedNumber');
        }).onDone(() {
          // Connection has been closed
          print('Connection closed');
        });
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
    } catch (exception) {
      print('Cannot connect, exception occured\n' + exception.toString());
      showErrorDialog(context, 'Bluetooth device connection error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.grey[300])!,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              scale: 12,
            ),
            const SizedBox(width: 10),
            const Text(
              'Notifications Page',
              style: TextStyle(color: Colors.black),
            ),
            const Icon(Icons.notification_add_rounded),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                //ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (context) => false,
                );
              }
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        firstColor,
                        secondColor,
                      ]),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ]),
                ),
              ),
              const Positioned(
                top: 10,
                left: 15,
                child: Text(
                  'Stove Control',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 45,
                left: 15,
                child: Text(
                  'Control your stove',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 60,
                left: 15,
                child: Text(
                  'And manage your notifications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 80,
                left: 15,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage('assets/images/stove.png'),
                ),
              ),
            ]),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bluetooth Connection',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                connectBluetooth(macAddress);
                              },
                              icon: const Icon(Icons.bluetooth_connected),
                              label: const Text('Connect'),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                sendData('!');
                              },
                              icon: const Icon(Icons.bluetooth_disabled),
                              label: const Text('Disconnect'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    secondColor, // Set the background color
                                foregroundColor:
                                    Colors.white, // Set the text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stove Control',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        MySwitch(connection: connection),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Manage Notifications 🔔',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: firstColor,
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        CheckboxListTile(
                          value: isfinishCookingAlert,
                          onChanged: (value) {
                            setState(() {
                              isfinishCookingAlert = value!;
                            });
                          },
                          activeColor: Colors.green,
                          title: Text(
                            'End Of Cooking',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: secondColor,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ),
                          subtitle: Text(
                            'Cooking completion alert',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          value: isTurnOnAlert,
                          onChanged: (value) {
                            setState(() {
                              isTurnOnAlert = value!;
                            });
                          },
                          activeColor: Colors.green,
                          title: Text(
                            'Turn on the stove',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: secondColor,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ),
                          subtitle: Text(
                            'Alert when the stove turns on',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          value: isTurnOffAlert,
                          onChanged: (value) {
                            setState(() {
                              isTurnOffAlert = value!;
                            });
                          },
                          activeColor: Colors.green,
                          title: Text(
                            'Turn off the stove',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: secondColor,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ),
                          subtitle: Text(
                            'Alert when the stove turns off',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     sendData('2');
            //   },
            //   child: const Text('Read Temperature'),
            // ),
            // const SizedBox(height: 10),
            // Text(
            //   'Current Temperature : $currentTemperature°',
            //   style: TextStyle(
            //     color: Colors.red.shade500,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 300);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
