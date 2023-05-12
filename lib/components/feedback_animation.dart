import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartStoveApp/components/navigation_bar.dart';

class FeedbackAnimation extends StatefulWidget {
  const FeedbackAnimation({super.key});

  @override
  State<FeedbackAnimation> createState() => _FeedbackAnimationState();
}

class _FeedbackAnimationState extends State<FeedbackAnimation> {
  final Color firstColor = const Color.fromARGB(255, 148, 179, 174);
  final Color secondColor = const Color.fromARGB(255, 8, 67, 143);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyNavigationBar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 300,
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
                    top: 60,
                    left: 25,
                    child: Text(
                      'Cooking FeedBack',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 100,
                    left: 25,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.transparent,
                      foregroundImage: AssetImage('assets/images/app_logo.png'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Thank You !',
                    style: TextStyle(
                        color: Colors.blue.shade500,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(15, 15),
                              blurRadius: 15),
                        ]),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'You will immediately be taken to the home page',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              //const SizedBox(height: 5),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Lottie.network(
                    //'animations/cooking.json',
                    'https://assets3.lottiefiles.com/private_files/lf30_zbVEXs.json',
                    height: 480,
                    width: 300,
                    repeat: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
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
