import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSwitch extends StatefulWidget {
  bool toggleValue;
  CustomSwitch({super.key, required this.toggleValue});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        height: 40.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: widget.toggleValue
              ? const Color.fromARGB(255, 223, 173, 11)
              : const Color.fromARGB(255, 228, 76, 38),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              curve: Curves.easeIn,
              top: 3.0,
              left: widget.toggleValue ? 60.0 : 0.0,
              right: widget.toggleValue ? 0.0 : 60.0,
              duration: const Duration(milliseconds: 1000),
              child: InkWell(
                onTap: toggleButton,
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: widget.toggleValue
                        ? Icon(
                            Icons.done,
                            color: Colors.black,
                            size: 35.0,
                            key: UniqueKey(),
                          )
                        : Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 35.0,
                            key: UniqueKey(),
                          )),
              ),
            )
          ],
        ),
      ),
    );
  }

  toggleButton() {
    setState(() {
      widget.toggleValue = !widget.toggleValue;
    });
  }
}
