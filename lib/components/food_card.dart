import 'package:flutter/material.dart';
import 'package:smartStoveApp/detailsPages/egg_details.dart';
import 'package:smartStoveApp/detailsPages/pasta_details.dart';
import 'package:smartStoveApp/detailsPages/rice_details.dart';
import 'package:smartStoveApp/models/food.dart';
import 'package:smartStoveApp/pages/feedback_page.dart';

class FoodCard extends StatelessWidget {
  Food food;
  final int foodIndex;
  FoodCard({super.key, required this.food, required this.foodIndex});

  void navigateToFoodPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const RiceDetails();
          },
        ));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const EggDetails();
          },
        ));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const PastaDetails();
          },
        ));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToFoodPage(context, foodIndex);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 25),
        width: 280,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // food picture
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(food.imagePath)),
            const SizedBox(height: 30),
            //name +  start bottton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //name
                  Text(
                    food.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          food.preparationTime,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.timer_outlined,
                          color: Colors.blue,
                          size: 26,
                        ),
                      ])
                ],
              ),
            ),
            const SizedBox(height: 20),
            //description
            Text(
              food.description,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
