import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/components/food_card.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/models/food.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoad = false;
  List<Food> foodTypes = [];
  void getDocuments() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Food> foods = [];
    QuerySnapshot querySnapshot = await firestore.collection('foods').get();

    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> documentList = querySnapshot.docs;
      for (DocumentSnapshot snapshot in documentList) {
        Food f = Food(
          index: snapshot.get('index'),
          name: snapshot.id,
          preparationTime: snapshot.get('preparationTime'),
          description: snapshot.get('description'),
          imagePath: snapshot.get('imagePath'),
        );
        foods.add(f);
      }
      foods.sort((a, b) => a.index.compareTo(b.index));
    }
    setState(() {
      foodTypes = foods;
      isLoad = true;
    });
  }

  @override
  void initState() {
    getDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                'Home Page',
                style: TextStyle(color: Colors.black),
              ),
              //const Icon(Icons.home),
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
        // message pick dish
        body: isLoad
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Text(
                        'Pick a dish and start cooking',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Food Options 🍲',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        food: foodTypes[index],
                        foodIndex: index,
                      );
                    },
                  )),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0, left: 25, right: 25),
                    child: Divider(
                      color: Colors.white,
                    ),
                  )
                ],
              )
            : Center(child: CircularProgressIndicator.adaptive()));
  }
}
