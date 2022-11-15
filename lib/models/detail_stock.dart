import 'package:objectbox/objectbox.dart';

@Entity()
class DetailStock {
  @Id(assignable: true)
  int id;
  String date;
  String supplier;
String pihakId;
  int count;
  double buyPrice;
  double sellPrice;
  double totalPrice;

  DetailStock({
    this.id = 0,
    this.pihakId='',
    required this.supplier,
    required this.date,
    required this.sellPrice,
    required this.buyPrice,
    required this.count,
    required this.totalPrice,
    // required this.DetailStockHistory,
  });
}
