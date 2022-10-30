import 'package:objectbox/objectbox.dart';

@Entity()
class Payment {
  @Id(assignable: true)
  int id;

  double pay;

  String date;

  // Map<String, dynamic> ftrBrakes;

  Payment({
    this.id = 0,
    this.pay = 0,
    this.date = '',
  });
}
