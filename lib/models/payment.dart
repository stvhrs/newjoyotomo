import 'package:objectbox/objectbox.dart';

@Entity()
class Payment {
  @Id(assignable: true)
  int id;

  double pay;
  String keterangan;
  String date;
  double saldo;

  // Map<String, dynamic> ftrBrakes;

  Payment({
    this.id = 0,
    this.saldo=1,
    this.pay = 0,
    this.keterangan = '',
    this.date = '',
  });
}
