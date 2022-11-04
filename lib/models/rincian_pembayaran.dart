
import 'package:objectbox/objectbox.dart';

@Entity()
class RincianPembayarran {
  @Id(assignable: true)
  int id;
  String rincianPembayarranId;
  String nomorHp;
String tanggal;
  double amount;


  RincianPembayarran(
      {this.id = 0,
      required this.rincianPembayarranId,
      required this.tanggal,
     required this.nomorHp,
      required this.amount});
}
