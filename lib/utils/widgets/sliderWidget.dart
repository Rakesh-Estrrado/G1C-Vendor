import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

class SlideToCompleteWidget extends StatefulWidget {
  final Function() completed;
  const SlideToCompleteWidget({super.key, required this.completed});

  @override
  _SlideToCompleteWidgetState createState() => _SlideToCompleteWidgetState();
}

class _SlideToCompleteWidgetState extends State<SlideToCompleteWidget> {
  double _dragPosition = 0.0;
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    double maxDrag = MediaQuery.of(context).size.width - 100;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragPosition += details.delta.dx;
          _dragPosition = _dragPosition.clamp(0.0, maxDrag);
        });
      },
      onHorizontalDragEnd: (details) {
        if (_dragPosition >= maxDrag) {
          widget.completed();
          setState(() {
            _dragPosition = 0.0;
          });
        } else {
          setState(() {
            _dragPosition = 0.0;
          });
        }
      },
      child: Stack(
        children: [
          gradientContainer(
            height: 45,
            child: SizedBox(
              width: 100.w,
              child: Center(
                child: Text(
                  _completed ? "Completed" : "Slide To Complete",
                  style:textStyleSemiBoldMedium,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: _dragPosition,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 6.0),
              child: Container(
                width: 60.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomImageView(
                    imagePath: icSliding),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
