
import '../../widgets.dart';

class SeparatedColumn extends StatelessWidget {

 SeparatedColumn({
 
   
    this.textDirection,
    this.children = const <Widget>[],
    this.includeOuterSeparators = false,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.separatorBuilder,
  }) ;
  final List<Widget> children;
 
  final bool includeOuterSeparators;
  final TextDirection? textDirection;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final IndexedWidgetBuilder separatorBuilder;

  @override
  Widget build(Context context) {
    final children = <Widget>[];
    final index = includeOuterSeparators ? 1 : 0;

    if (this.children.isNotEmpty) {
      if (includeOuterSeparators) {
        children.add(separatorBuilder(context, 0));
      }

      for (var i = 0; i < this.children.length; i++) {
        children.add(this.children[i]);

        if (this.children.length - i != 1) {
          children.add(separatorBuilder(context, i + index));
        }
      }

      if (includeOuterSeparators) {
        children.add(separatorBuilder(context, this.children.length));
      }
    }

    return Column(
    
      children: children,
      mainAxisSize: mainAxisSize,
     
      verticalDirection: verticalDirection,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}