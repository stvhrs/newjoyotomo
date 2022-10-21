import 'package:flutter/cupertino.dart';

class Kotak extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  const Kotak(
      {super.key,
      required this.child,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.zero,padding: const EdgeInsets.only(left: 4,right: 4),
      height: height,
      width: width,
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: child,
    );
  }
}
