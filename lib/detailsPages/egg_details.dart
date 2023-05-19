import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/details_card.dart';

class EggDetails extends StatefulWidget {
  const EggDetails({super.key});

  @override
  State<EggDetails> createState() => _EggDetailsState();
}

class _EggDetailsState extends State<EggDetails> {
  DocumentSnapshot? documentSnapshot;
  void getDocument() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot snapshot =
        await firestore.collection('foods').doc('Egg').get();

    if (snapshot.exists) {
      setState(() {
        documentSnapshot = snapshot;
      });
    }
  }

  @override
  void initState() {
    getDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (documentSnapshot == null) {
      return const CircularProgressIndicator(); // or any other loading indicator
    }
    return DetailsCard(
      foodIndex: 1,
      title: documentSnapshot?.get('pageTitle'),
      name: documentSnapshot?.get('name'),
      img: documentSnapshot?.get('imgDetailsPage'),
      time: documentSnapshot?.get('preparationTime') + ' ⏲️',
      temperature: documentSnapshot?.get('temperature'),
    );
  }
}
