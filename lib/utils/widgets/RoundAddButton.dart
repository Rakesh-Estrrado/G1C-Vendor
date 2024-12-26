import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/colors.dart';

class RoundAddButton extends StatefulWidget {
  final VoidCallback onTap;

  const RoundAddButton(
      {Key? key, required this.onTap})
      : super(key: key);

  @override
  RoundAddButtonState createState() => RoundAddButtonState();
}

class RoundAddButtonState extends State<RoundAddButton>  with SingleTickerProviderStateMixin{
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {_isPressed = true;});
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {_isPressed = false;});
          widget.onTap();
        });
      },
      child: Transform.scale(
        scale: _isPressed ? 0.99 : 1.0, // Slightly smaller on press
        child: Container(
          height: 55,width: 55,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color(0xFFE91775), Color(0xFFFD663B)],),
          ),
          child: Icon(Icons.add, size: 35, color: white),
        ),
      ),
    );
  }
}
