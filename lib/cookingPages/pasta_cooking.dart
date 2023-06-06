import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class PastaCooking extends StatefulWidget {
  final int totalTime;
  final int turnOffTime;
  const PastaCooking(
      {super.key, required this.totalTime, required this.turnOffTime});

  @override
  State<PastaCooking> createState() => _PastaCookingState();
}

class _PastaCookingState extends State<PastaCooking> {
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
      title: 'Pasta Cooking Page 🍝',
      name: 'Pasta 🍝',
      img: 'lib/images/pasta.jpg',
      time: '8 minutes ⏲️',
      temperature: '140° 🌡️',
      totalTime: widget.totalTime,
      turnOffTime: widget.turnOffTime,
    );
  }
}
