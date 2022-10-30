import 'package:flutter/cupertino.dart';

class Kotak2 extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  const Kotak2(
      {super.key,
      required this.child,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: child,
    );
  }
}
