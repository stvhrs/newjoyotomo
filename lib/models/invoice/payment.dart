import 'package:objectbox/objectbox.dart';

@Entity()
class Payment {
  @Id(assignable: true)
  int id;
  String name;
  double pay;
  String keterangan;
  String date;

  // Map<String, dynamic> ftrBrakes;

  Payment({
    this.id = 0,
    required this.pay,
    required this.name,
    required this.date,
    required this.keterangan,
  });
}
