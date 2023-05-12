// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/button_widget.dart';
import 'package:smartStoveApp/components/navigation_bar.dart';
import 'package:smartStoveApp/utilities/show_cancel_dialog.dart';

class CookingPage extends StatefulWidget {
  final String title;
  final String name;
  final String img;
  final String time;
  final String temperature;
  const CookingPage({
    super.key,
    required this.title,
    required this.name,
    required this.img,
    required this.time,
    required this.temperature,
  });

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends State<CookingPage> {
  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Duration duration = Duration();
  Timer? timer;
  bool isActive = true;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          stopTimer();
        }
      },
    );
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

  void cancelTimer() async {
    setState(() {
      timer?.cancel();
      isActive = false;
    });
    final isCancel = await showCancelDialog(context);
    if (isCancel) {
      setState(() {
        seconds = maxSeconds;
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

  void toogleAction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const MyNavigationBar();
              },
            ));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Food Type: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    buildDetailsShow(),
                    const SizedBox(height: 15),
                    buildTimer(),
                    const SizedBox(height: 30),
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
                            color: Colors.blue.shade600),
                      ),
                      const SizedBox(height: 15),
                      ButtonWidget(
                        text: "Give Feedback",
                        bgcolor: Colors.blue.shade600,
                        icon: const Icon(Icons.thumb_up),
                        onClick: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Current Temperature: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Stove State: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.temperature,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ],
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
              ButtonWidget(
                text: isActive ? 'Pause' : 'Resume',
                bgcolor: Colors.blue.shade600,
                icon: isActive
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_circle),
                onClick: () {
                  stopTimer();
                },
              ),
              const SizedBox(width: 30),
              ButtonWidget(
                text: 'Stop',
                bgcolor: Colors.red.shade500,
                icon: const Icon(Icons.stop),
                onClick: () {
                  cancelTimer();
                },
              ),
            ],
          )
        : const Text(
            'DONE',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.greenAccent),
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
            value: 1 - seconds / maxSeconds,
            valueColor: const AlwaysStoppedAnimation(Colors.greenAccent),
            backgroundColor: Colors.blue[500],
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
        ? const Icon(Icons.done, color: Colors.greenAccent, size: 110)
        : Text(
            timeStr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[500],
                fontSize: 55),
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
