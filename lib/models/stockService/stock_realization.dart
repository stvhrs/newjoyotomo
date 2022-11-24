import 'package:newJoyo/models/stock.dart';

import 'package:objectbox/objectbox.dart';

@Entity()
class StockRalization {
  @Id(assignable: true)
  int id;
  String name;
  String partname;
  String desc;
  ToOne<Stock> realization = ToOne<Stock>();
  int count;
  double price;
 
  double toalPrice;
  double sellPrice;
 bool done;
  StockRalization({
    this.id = 0,
    this.partname='partname',
   this.name='name',
 this.desc='dest',
    this.price=0.0,
    this.count=1,
   this.sellPrice=0,
   
    this.toalPrice=0.0,
    this.done=false
 
    // required this.stockRalizationHistory,
  });
  // factory StockRalization.fromMap(Map<String, dynamic> map) {
  //   return StockRalization(
  //     name: map['name'],
  //     desc: map['desc'],
  //     stockRalization: map['stockRalization'],
  //     price: map['price'],
  //     servicePrice: map['servicePrice'],
  //     stockRalizationHistory: map['stockRalizationHistory'],
  //   );
  // }
  // static Map<String, dynamic> toMap(StockRalization stockRalization) {
  //   return {
  //     'name': stockRalization.name,
  //     'desc': stockRalization.desc,
  //     'stockRalization': stockRalization.stockRalization,
  //     'price': stockRalization.price,
  //     'servicePrice': stockRalization.servicePrice,
  //     'stockRalizationHistory': stockRalization.stockRalizationHistory,
  //   };
  // }
}
