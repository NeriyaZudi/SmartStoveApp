import 'package:flutter/material.dart';
import 'package:smartStoveApp/constants/foods.dart';
import 'package:smartStoveApp/utilities/utils.dart';

class RecipeButton extends StatelessWidget {
  final int foodIndex;
  const RecipeButton({super.key, required this.foodIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (foodIndex) {
          case 0:
            Utils.openLink(url: RICE_URL);
            break;
          case 1:
            Utils.openLink(url: EGG_URL);
            break;
          case 2:
            Utils.openLink(url: PASTA_URL);
            break;
          default:
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Click here for the recipe!",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
