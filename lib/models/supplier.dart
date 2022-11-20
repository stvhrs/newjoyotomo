import 'package:objectbox/objectbox.dart';

@Entity()
class Penyuplai {
  @Id(assignable: true)
  int id;
  String namaPenyuplai;
  String nomorHp;
  int date;
  String alamat;

  Penyuplai(
      {this.id = 0,
      required this.namaPenyuplai,
      required this.date,
      required this.nomorHp,
      required this.alamat});
}
