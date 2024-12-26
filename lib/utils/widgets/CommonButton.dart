import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/utils.dart';


class CommonButton extends StatefulWidget {
  final String label;
  final height;
  final VoidCallback onTap;

  const CommonButton(
      {Key? key, required this.label, required this.onTap, this.height = 45.0})
      : super(key: key);

  @override
  CommonButtonState createState() => CommonButtonState();
}

class CommonButtonState extends State<CommonButton>  with SingleTickerProviderStateMixin{
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _isPressed ? 0.99 : 1.0, // Slightly smaller on press
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE91775), Color(0xFFFD663B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),


        child: MaterialButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {_isPressed = true;});
            Future.delayed(Duration(milliseconds: 100), () {
              setState(() {_isPressed = false;});
              widget.onTap();
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Text(
            widget.label,
            style: textStyleSemiBoldMedium,
          ),
        ),
      ),
    );
  }
}
