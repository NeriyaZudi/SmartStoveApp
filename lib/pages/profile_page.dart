import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/barGraphs/bar_graph.dart';
import 'package:smartStoveApp/barGraphs/pie_graph.dart';
import 'package:smartStoveApp/components/info_card.dart';
import 'package:smartStoveApp/constants/foods.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/pages/reset_password_page.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';
import 'package:smartStoveApp/utilities/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color firstColor = const Color.fromARGB(255, 148, 179, 174);
  final Color secondColor = const Color.fromARGB(255, 8, 67, 143);
  final Color thirdColor = const Color.fromARGB(255, 40, 126, 238);
  final double coverHeight = 250;
  final double profileHeight = 144;
  String? userUid;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<double> weeklyConsumption = [
    4.40,
    20.50,
    10.80,
    64.70,
    98.23,
    80.6,
    5.40,
    48.0,
    76.0,
    54.9,
    13.5,
    92.3
  ];

  String email = '';
  String userName = '';
  String phone = '';
  String imgPath = '';
  String lastFood = '';
  int lastSavingTime = 0;
  final stove = STOVE;
  final url = STOVE_URL;

  void getUserId() async {
    User? user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef =
          firestore.collection('users').doc(user.email);

      DocumentSnapshot snapshot = await userDocRef.get();

      if (snapshot.exists) {
        setState(() {
          userName = snapshot.get('name');
          email = snapshot.id;
          // ignore: prefer_interpolation_to_compose_strings
          phone = '0' + snapshot.get('phone');
          imgPath = snapshot.get('img');
          lastSavingTime = snapshot.get('lastSavingTime');
          lastFood = snapshot.get('lastFood');
        });
      } else {
        //print('User document does not exist');
      }
    } else {
      //print('No user is currently logged in');
    }
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.grey[300])!,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              scale: 12,
            ),
            const SizedBox(width: 10),
            const Text(
              'Profile Page',
              style: TextStyle(color: Colors.black),
            ),
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTopProfile(top, bottom),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTopProfile(double top, double bottom) {
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverImage()),
          Positioned(
            top: top,
            child: buildProfileImage(),
          )
        ]);
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey[400],
        child: Image.asset(
          'assets/images/cover.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        backgroundColor: Colors.grey.shade700,
        backgroundImage: AssetImage(imgPath),
        radius: profileHeight / 2,
      );

  Widget buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                InfoCard(
                    text: phone, icon: Icons.phone, onPressed: () async {}),
                InfoCard(
                    text: email, icon: Icons.email, onPressed: () async {}),
                InfoCard(
                    text: stove,
                    icon: Icons.fireplace,
                    onPressed: () => Utils.openLink(url: url)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // change password button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ResetPasswordPage();
                  },
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient:
                        LinearGradient(colors: [secondColor, firstColor])),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Segmentation of usage percentages by food type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Kanit',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(
                height: 200,
                child: PieChartFoods(),
              ),
              const SizedBox(height: 50),
              buildLastSaving(),
              const SizedBox(height: 20),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient:
                        LinearGradient(colors: [secondColor, firstColor])),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Electricity consumption when using stoves',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Kanit',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: MyBarGraph(
                  weeklyConsumption: weeklyConsumption,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  buildLastSaving() {
    double savingMoney = (lastSavingTime / 60) * 0.465;
    String savingMoneyStr = savingMoney.toStringAsFixed(4);
    return Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              firstColor,
              secondColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            const Text(
              'Last Cooking Operation',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: "WixMadeforDisplay",
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'You Cooked $lastFood ',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: "WixMadeforDisplay",
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'You Saved $savingMoneyStr ₪',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: "WixMadeforDisplay",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Lottie.network(
                //'animations/cooking.json',
                'https://assets1.lottiefiles.com/private_files/lf30_0lKPGC.json',
                height: 200,
                width: 400,
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ));
  }
}
