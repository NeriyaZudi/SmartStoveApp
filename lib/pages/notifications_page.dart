import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<BluetoothDevice> devices = [];
  late BluetoothConnection connection;
  String macAddress = "00:22:06:30:48:2D";

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
      connection.output.add(bytes);
      await connection.output.allSent;
      if (kDebugMode) {
        print('Data sent success');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadDevices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.bluetooth,
    ].request();
    PermissionStatus status = statuses[Permission.bluetooth]!;
    if (status.isGranted) {
      // List<BluetoothDevice> scandevices =
      //     await FlutterBluetoothSerial.instance.getBondedDevices();
      // setState(() {
      //   devices = scandevices;
      // });
      print('SUC');
      // Bluetooth permission granted, proceed with your code
    } else {
      print('ERR');
      // Bluetooth permission denied, handle accordingly
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
      body: Center(
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              connectBluetooth(macAddress);
            },
            child: const Text('Connect'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              sendData('1');
            },
            child: const Text('On'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              sendData('0');
            },
            child: const Text('Off'),
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }

  Future connectBluetooth(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      if (connection.isConnected) {
        print('############### Conected ########\n');
      } else {
        print('############### NOT ########\n');
      }
      // connection.input!.listen(
      //   (Uint8List data) {},
      // );
    } catch (e) {
      print('ERRROR HEREE' + e.toString());
    }
  }
}
