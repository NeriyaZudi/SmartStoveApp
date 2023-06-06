import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class EggCooking extends StatefulWidget {
  final int totalTime;
  final int turnOffTime;
  const EggCooking(
      {super.key, required this.totalTime, required this.turnOffTime});

  @override
  State<EggCooking> createState() => _EggCookingState();
}

class _EggCookingState extends State<EggCooking> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> insertSavingValues() async {
    User? user = auth.currentUser;
    if (user != null) {
      try {
        // Get a reference to the collection
        CollectionReference collectionRef =
            FirebaseFirestore.instance.collection('users');

        // Get the document reference
        DocumentReference documentRef = collectionRef.doc(user.email);

        // Update the specific field with the new value
        await documentRef.update({'lastFood': 'Rice 🍚'});
        await documentRef.update({'lastSavingTime': widget.turnOffTime});

        print('Value inserted successfully');
      } catch (e) {
        print('Error inserting value: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    insertSavingValues();
  }

  @override
  Widget build(BuildContext context) {
    return CookingPage(
      title: 'Egg Cooking Page 🥚',
      name: 'Egg 🥚',
      img: 'lib/images/egg.jpg',
      time: '10 minutes ⏲️',
      temperature: '100° 🌡️',
      totalTime: widget.totalTime,
      turnOffTime: widget.turnOffTime,
    );
  }
}
