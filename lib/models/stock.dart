import 'package:newJoyo/models/stock_history.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Stock {
  @Id(assignable: true)
  int id;
  String name;
  String partname;
  String desc;
   final items = ToMany<StockHistory>();
  int count;
double lastPrice;
  double totalPrice;
  

  Stock({
    this.id = 0,
   
    required this.partname,
    required this.name,
    required this.desc,
    required this.lastPrice,
    required this.count,
    required this.totalPrice,
    // required this.stockHistory,
  });
  // factory Stock.fromMap(Map<String, dynamic> map) {
  //   return Stock(
  //     name: map['name'],
  //     desc: map['desc'],
  //     stock: map['stock'],
  //     price: map['price'],
  //     totalPrice: map['totalPrice'],
  //     stockHistory: map['stockHistory'],
  //   );
  // }
  // static Map<String, dynamic> toMap(Stock stock) {
  //   return {
  //     'name': stock.name,
  //     'desc': stock.desc,
  //     'stock': stock.stock,
  //     'price': stock.price,
  //     'totalPrice': stock.totalPrice,
  //     'stockHistory': stock.stockHistory,
  //   };
  // }
}
