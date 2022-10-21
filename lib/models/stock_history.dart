import 'package:objectbox/objectbox.dart';

@Entity()
class StockHistory {
  @Id(assignable: true)
  int id;
  String date;
  String supplier;

  int count;
  double price;
  double totalPrice;

  StockHistory({
    this.id = 0,
    required this.supplier,
    required this.date,
    required this.price,
    required this.count,
    required this.totalPrice,
    // required this.StockHistoryHistory,
  });
}
