import 'package:newJoyo/models/detail_stock.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Stock {
  @Id(assignable: true)
  int id;
  String name;
  String partname;
  String desc;
  final items = ToMany<DetailStock>();
  int count;

  double totalPrice;
  int date;

  Stock({
    this.id = 0,
    required this.partname,
    required this.name,
    this.date = 0,
    required this.desc,
    required this.count,
    required this.totalPrice,
    // required this.DetailStock,
  });
  // factory Stock.fromMap(Map<String, dynamic> map) {
  //   return Stock(
  //     name: map['name'],
  //     desc: map['desc'],
  //     stock: map['stock'],
  //     price: map['price'],
  //     totalPrice: map['totalPrice'],
  //     DetailStock: map['DetailStock'],
  //   );
  // }
  // static Map<String, dynamic> toMap(Stock stock) {
  //   return {
  //     'name': stock.name,
  //     'desc': stock.desc,
  //     'stock': stock.stock,
  //     'price': stock.price,
  //     'totalPrice': stock.totalPrice,
  //     'DetailStock': stock.DetailStock,
  //   };
  // }
}
