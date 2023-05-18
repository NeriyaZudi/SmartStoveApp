import 'package:flutter/material.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/barGraphs/bar_graph.dart';
import 'package:smartStoveApp/barGraphs/pie_graph.dart';
import 'package:smartStoveApp/components/info_card.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';
import 'package:smartStoveApp/utilities/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 250;
  final double profileHeight = 144;

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
  final email = "neriya@gmail.com";
  final phone = "052-3112891";
  final stove = "Gold Line ATL-103";
  final url = "https://www.goldline.co.il/product/atl-103/";

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
        backgroundImage: const AssetImage('lib/images/eilon.jpg'),
        radius: profileHeight / 2,
      );

  Widget buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Eilon Yifrach',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
            InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            InfoCard(
                text: stove,
                icon: Icons.fireplace,
                onPressed: () => Utils.openLink(url: url)),
            const SizedBox(height: 20),
            Text(
              'Segmentation of usage percentages by food type',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue[500],
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 200,
              child: PieChartFoods(),
            ),
            const SizedBox(height: 50),
            Text(
              'Electricity consumption when using stoves',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue[500],
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: MyBarGraph(
                weeklyConsumption: weeklyConsumption,
              ),
            )
          ],
        ),
      ),
    );
  }
}
