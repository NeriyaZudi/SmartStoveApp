import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/details_card.dart';

class PastaDetails extends StatefulWidget {
  const PastaDetails({super.key});

  @override
  State<PastaDetails> createState() => _PastaDetailsState();
}

class _PastaDetailsState extends State<PastaDetails> {
  DocumentSnapshot? documentSnapshot;
  void getDocument() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot snapshot =
        await firestore.collection('foods').doc('Pasta').get();

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
      foodIndex: 2,
      title: documentSnapshot?.get('pageTitle'),
      name: documentSnapshot?.get('name'),
      img: documentSnapshot?.get('imgDetailsPage'),
      time: documentSnapshot?.get('preparationTime') + ' ⏲️',
      temperature: documentSnapshot?.get('temperature'),
    );
  }
}
