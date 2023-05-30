// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartStoveApp/components/custom_switch.dart';
import 'package:smartStoveApp/components/food_info.dart';
import 'package:smartStoveApp/utilities/utils.dart';

class DetailsPage extends StatefulWidget {
  final int foodIndex;
  final String title;
  final String name;
  final String img;
  final String time;
  final String temperature;
  DetailsPage({
    super.key,
    required this.foodIndex,
    required this.title,
    required this.name,
    required this.img,
    required this.time,
    required this.temperature,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Color firstColor = const Color.fromARGB(255, 148, 179, 174);
  final Color secondColor = const Color.fromARGB(255, 8, 67, 143);
  final Color thirdColor = const Color.fromARGB(255, 40, 126, 238);
  bool onValue = false;
  bool offValue = false;
  double riceAmountValue = 500;
  double waterAmountValue = 1600;
  int heatLevel = 1;
  bool isCover = false;
  bool isMixing = false;
  final double riceAmountMin = 100;
  final double riceAmountMax = 1000;
  final double waterAmountMin = 500;
  final double waterAmountMax = 3000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        firstColor,
                        secondColor,
                      ]),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ]),
                ),
              ),
              Positioned(
                top: 50,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 60,
                left: 40,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 90,
                left: 25,
                child: Text(
                  'Select Cooking Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const Positioned(
                top: 110,
                left: 25,
                child: Text(
                  'And Parameters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Positioned(
                top: 125,
                left: 25,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage(widget.img),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FoodInfo(
                  text: 'Food Type:   ${widget.name}',
                  icon: Icons.food_bank_sharp,
                ),
                FoodInfo(
                  text: 'Cooking Time:  ${widget.time}',
                  icon: Icons.food_bank_sharp,
                ),
                FoodInfo(
                  text: 'Cooking Temperature:   ${widget.temperature}',
                  icon: Icons.food_bank_sharp,
                ),
                const SizedBox(height: 10),
                buildCookingParams(),
                const SizedBox(height: 10),
                buildControlSection(),
                const SizedBox(height: 15),
              ],
            ),
          )
        ],
      )),
    );
  }

  buildControlSection() {
    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 206, 228, 13),
            Color.fromARGB(255, 214, 134, 15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text(
            '🎛️     Automatic Stove Control     🎛️',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Automatic Ignition ',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: onValue,
                activeColor: Colors.white,
                onChanged: (onChanged) {
                  setState(() {
                    onValue = onChanged;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Automatic Shutdown ',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: offValue,
                activeColor: Colors.white,
                onChanged: (onChanged) {
                  setState(() {
                    offValue = onChanged;
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  buildCookingParams() {
    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            firstColor,
            thirdColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text(
            'Cooking Parameters',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 10),
          buildAmountSlider(),
          buildWaterAmountSlider(),
          buildHeatLevelSlider(),
          buildSwitches(),
        ],
      ),
    );
  }

  Widget buildSideLabel(double value, bool isRice) {
    return isRice
        ? Text(
            '${value.round()}g',
            style: TextStyle(
              fontSize: 14,
              color: Colors.amberAccent.shade200,
            ),
          )
        : Text(
            '${value.round()}ml',
            style: TextStyle(
              fontSize: 14,
              color: Colors.amberAccent.shade200,
            ),
          );
  }

  Widget buildAmountSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Amount of ${widget.name} : ${riceAmountValue.round()}g',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            buildSideLabel(riceAmountMin, true),
            Expanded(
              child: SliderTheme(
                data: const SliderThemeData(
                  valueIndicatorColor: Colors.amberAccent,
                ),
                child: Slider(
                  value: riceAmountValue,
                  min: riceAmountMin,
                  max: riceAmountMax,
                  activeColor: Colors.amberAccent,
                  inactiveColor: Colors.white24,
                  divisions: 1000,
                  thumbColor: Colors.amberAccent,
                  label: '${riceAmountValue.round()}g',
                  onChanged: (value) => setState(() {
                    riceAmountValue = value;
                  }),
                ),
              ),
            ),
            buildSideLabel(riceAmountMax, true),
          ],
        ),
      ],
    );
  }

  Widget buildWaterAmountSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Amount of Water💧: ${waterAmountValue.round()}ml',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            buildSideLabel(riceAmountMin, false),
            Expanded(
              child: SliderTheme(
                data: const SliderThemeData(
                  valueIndicatorColor: Colors.amberAccent,
                ),
                child: Slider(
                  value: waterAmountValue,
                  min: waterAmountMin,
                  max: waterAmountMax,
                  activeColor: Colors.amberAccent,
                  inactiveColor: Colors.white24,
                  divisions: 3000,
                  thumbColor: Colors.amberAccent,
                  label: '${waterAmountValue.round()}ml',
                  onChanged: (value) => setState(() {
                    waterAmountValue = value;
                  }),
                ),
              ),
            ),
            buildSideLabel(riceAmountMax, false),
          ],
        ),
      ],
    );
  }

  Widget buildHeatLevelSlider() {
    final levels = ['0', '1', '2', '3', '4'];
    const double min = 0;
    final double max = levels.length - 1.0;
    final divisions = levels.length - 1;
    const inactiveColor = Colors.white54;
    const activeColor = Colors.amberAccent;
    const double thumbRadius = 14;
    const double tickMarkRadius = 10;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Stove Heat Level 🔥: ${heatLevel.round()}',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(levels, (index, label) {
              const selectedColor = Colors.white;
              final unselectedColor = Colors.white.withOpacity(0.3);
              final isSelected = index <= heatLevel;
              final color = isSelected ? selectedColor : unselectedColor;
              return buildLabels(label: label, color: color);
            }),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: const SliderThemeData(
                  valueIndicatorColor: activeColor,
                  trackHeight: 5,
                  inactiveTickMarkColor: inactiveColor,
                  inactiveTrackColor: inactiveColor,
                  thumbColor: activeColor,
                  activeTickMarkColor: activeColor,
                  activeTrackColor: activeColor,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: thumbRadius,
                    enabledThumbRadius: thumbRadius,
                  ),
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    disabledThumbRadius: thumbRadius,
                    enabledThumbRadius: thumbRadius,
                  ),
                  tickMarkShape:
                      RoundSliderTickMarkShape(tickMarkRadius: tickMarkRadius),
                ),
                child: Slider(
                  value: heatLevel.toDouble(),
                  min: min,
                  max: max,
                  divisions: divisions,
                  onChanged: (value) => setState(() {
                    heatLevel = value.toInt();
                  }),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSwitches() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Is Cover ?',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            CustomSwitch(
              toggleValue: isCover,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Is Mixing ?',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            CustomSwitch(
              toggleValue: isMixing,
            ),
          ],
        )
      ],
    );
  }

  Widget buildLabels({required String label, required Color color}) {
    return Container(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            .copyWith(color: color),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 300);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
