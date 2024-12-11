import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation<Alignment> _circleAnimation;
  late AnimationController _animationController;

  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final dx = details.primaryDelta ?? 0.0;
    setState(() {
      isDragging = true;
      if (dx > 0) {
        _animationController.value =
            (_animationController.value + (dx / 55)).clamp(0.0, 1.0);
      } else {
        _animationController.value =
            (_animationController.value + (dx / 55)).clamp(0.0, 1.0);
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    isDragging = false;
    if (_animationController.value >= 0.5) {
      _animationController.forward();
      widget.onChanged(true);
    } else {
      _animationController.reverse();
      widget.onChanged(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await HapticFeedback.selectionClick();
          if (_animationController.isCompleted) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
          widget.onChanged(!widget.value);
        },
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: 45.0,
              height: 22.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: _circleAnimation.value == Alignment.centerLeft
                    ? inActiveTrack
                    : switchGreen,
              ),
              child: Align(
                alignment: _circleAnimation.value,
                child: SizedBox(
                  height: 22, // Adjusted to match container height
                  width: 22, // Adjusted to match container height
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Card(
                      elevation: 4,
                      shape: const CircleBorder(),
                      margin: EdgeInsets.zero, // Removes any default margin
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
