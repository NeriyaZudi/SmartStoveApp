import 'package:flutter/material.dart';
import 'package:smartStoveApp/models/food.dart';

class FoodCard extends StatelessWidget {
  Food food;
  final int foodIndex;
  FoodCard({super.key, required this.food, required this.foodIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tap on $foodIndex");
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
            const SizedBox(height: 60),
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
