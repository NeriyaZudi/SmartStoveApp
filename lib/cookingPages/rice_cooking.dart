import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class RiceCooking extends StatefulWidget {
  final int totalTime;
  final int turnOffTime;
  const RiceCooking(
      {super.key, required this.totalTime, required this.turnOffTime});

  @override
  State<RiceCooking> createState() => _RiceCookingState();
}

class _RiceCookingState extends State<RiceCooking> {
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
      title: 'Rice Cooking Page 🍚',
      name: 'Rice 🍚',
      img: 'lib/images/rice.jpg',
      time: '20 minutes ⏲️',
      temperature: '120° 🌡️',
      totalTime: widget.totalTime,
      turnOffTime: widget.turnOffTime,
    );
  }
}
