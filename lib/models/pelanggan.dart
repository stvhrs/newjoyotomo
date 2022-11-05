import 'package:objectbox/objectbox.dart';

@Entity()
class Pelanggan {
  @Id(assignable: true)
  int id;
  String namaPelanggan;
  String nomorHp;
  int date;
  String alamat;

  Pelanggan(
      {this.id = 0,
      required this.namaPelanggan,
      required this.date,
      required this.nomorHp,
      required this.alamat});
}
  