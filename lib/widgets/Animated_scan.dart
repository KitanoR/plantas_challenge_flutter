import 'package:app_plant_shop/widgets/painter_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedScan extends StatefulWidget {
  @override
  _AnimatedScanState createState() => _AnimatedScanState();
}

class _AnimatedScanState extends State<AnimatedScan>  with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<double> _position;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000)
    );

    _position = Tween(
      begin: 0.0,
      end: 200.0
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0,1)
    ))..addListener(() {
      setState(() {});
     });  
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.rotate(
                      angle:  math.pi / 2,
                      child: buildCustomPaint(),
                    ),
                    Transform.rotate(
                      angle: - math.pi ,
                      child: buildCustomPaint(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildCustomPaint(),
                    Transform.rotate(
                      angle: - math.pi / 2,
                      child: buildCustomPaint(),
                    )
                  ],
                )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DottedBorder(
              color: Colors.white,
              dashPattern: [8,4],
              customPath: (size){
                return Path()
                  ..moveTo(0, 0)
                  ..lineTo(size.width, 0);
              },
              child: Container(
                height: _position.value,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color> [
                      Colors.white30.withAlpha(30),
                      Colors.white30
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  CustomPaint buildCustomPaint() {
    return CustomPaint(
    painter: PainterWidget(),
    child: Container(
      height: 50,
      width: 50,
    ),
  );
  }
}