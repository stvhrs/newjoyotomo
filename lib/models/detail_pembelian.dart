import 'package:objectbox/objectbox.dart';

@Entity()
class DetailPembelian {
  @Id(assignable: true)
  int id;
  String partName;
  String name;
  String pihakId;
  int count;
  double price;
  double totalPrice;

  DetailPembelian({
    this.id = 0,
    required this.name,
    this.pihakId = '',
    required this.partName,
    required this.count,
    required this.price,
    required this.totalPrice,
  });
}
