import 'package:flutter/cupertino.dart';

class Kotak2 extends StatelessWidget {
  final Widget child;
 
  const Kotak2(
      {super.key,
      required this.child,
 } );

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: child,
    );
  }
}
