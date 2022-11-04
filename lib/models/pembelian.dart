import 'package:newJoyo/models/detail_pembelian.dart';
import 'package:newJoyo/models/stock.dart';
import 'package:objectbox/objectbox.dart';

import 'detail_stock.dart';

@Entity()
class Supplier {
  @Id(assignable: true)
  int id;
  String supplier;
  final items = ToMany<DetailPembelian>();
  String desc;
  int count;
  String date;
  String pihakId;
  double totalPrice;  
final   stockItems  =ToMany<Stock>();
 final detailStockItems= ToMany<DetailStock>() ;

  Supplier({
    this.id = 0,
    required this.date,
    required this.pihakId,
    required this.supplier,
    required this.desc,
    required this.count,
    required this.totalPrice,
  });
}
