// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/button_widget.dart';
import 'package:smartStoveApp/components/feedback_animation.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final Color firstColor = const Color.fromARGB(255, 148, 179, 174);

  final Color secondColor = const Color.fromARGB(255, 8, 67, 143);

  final commentController = TextEditingController();

  double foodRating = 4.0;
  double appRating = 4.0;
  double timeRating = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: double.infinity,
                  height: 310,
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
                top: 90,
                left: 25,
                child: Text(
                  'We would love to hear your opinion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 110,
                left: 25,
                child: Text(
                  'About the cooking process',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 130,
                left: 25,
                child: Text(
                  'And the final result',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 145,
                left: 25,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage('lib/images/rice-f.png'),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Rate The Final Food Result',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                const SizedBox(height: 5),
                SmoothStarRating(
                  rating: foodRating,
                  starCount: 5,
                  size: 45,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  spacing: 2.0,
                  onRated: (val) {
                    setState(() {
                      foodRating = val;
                    });
                  },
                ),
                // const SizedBox(height: 10),
                // const Text(
                //   'Rate The Cooking Time',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 16,
                //     fontWeight: FontWeight.w400,
                //     fontFamily: 'Ubuntu',
                //   ),
                // ),
                // const SizedBox(height: 5),
                // SmoothStarRating(
                //   rating: timeRating,
                //   starCount: 5,
                //   size: 45,
                //   filledIconData: Icons.star,
                //   halfFilledIconData: Icons.star_half,
                //   defaultIconData: Icons.star_border,
                //   spacing: 2.0,
                //   onRated: (val) {
                //     setState(() {
                //       timeRating = val;
                //     });
                //   },
                // ),
                const SizedBox(height: 10),
                const Text(
                  'Rate Our Smart Stove App',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                const SizedBox(height: 5),
                SmoothStarRating(
                  rating: foodRating,
                  starCount: 5,
                  size: 45,
                  color: const Color.fromARGB(216, 214, 195, 22),
                  borderColor: const Color.fromARGB(216, 214, 195, 22),
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  spacing: 2.0,
                  onRated: (val) {
                    setState(() {
                      foodRating = val;
                    });
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: commentController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: '🖊️ Leave Your Comment Here...',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                ButtonWidget(
                  text: "Send Feedback",
                  bgcolor: Colors.blue.shade600,
                  icon: const Icon(Icons.send),
                  onClick: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const FeedbackAnimation()));
                  },
                ),
              ],
            ),
          ),
          Stack(
            children: [
              RotatedBox(
                quarterTurns: 6,
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 200,
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
              ),
              const Positioned(
                top: 68,
                left: 220,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage('assets/images/app_logo.png'),
                ),
              ),
            ],
          )
        ],
      )),
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

List<Widget> getStars() {
  List<Widget> childs = [];
  for (var i = 0; i < 5; i++) {
    childs.add(IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.star_border_outlined,
          color: Colors.blue[500],
          size: 30,
        )));
  }
  return childs;
}
