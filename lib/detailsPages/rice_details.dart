import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/details_card.dart';
import 'package:smartStoveApp/components/details_page_generic.dart';

class RiceDetails extends StatefulWidget {
  const RiceDetails({super.key});

  @override
  State<RiceDetails> createState() => _RiceDetailsState();
}

class _RiceDetailsState extends State<RiceDetails> {
  DocumentSnapshot? documentSnapshot;
  void getDocument() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot snapshot =
        await firestore.collection('foods').doc('Rice').get();

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
    return DetailsPage(
      foodIndex: 0,
      title: documentSnapshot?.get('pageTitle'),
      name: documentSnapshot?.get('name'),
      img: documentSnapshot?.get('imgDetailsPage'),
      time: documentSnapshot?.get('preparationTime'),
      temperature: documentSnapshot?.get('temperature'),
    );
  }
}
