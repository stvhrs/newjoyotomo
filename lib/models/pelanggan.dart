
import 'package:objectbox/objectbox.dart';

@Entity()
class Pelanggan {
  @Id(assignable: true)
  int id;
  String pelangganId;
  String nomorHp;

  String alamat;


  Pelanggan(
      {this.id = 0,
      required this.pelangganId,
     required this.nomorHp,
      required this.alamat});
}
