import 'package:newJoyo/models/invoice.dart';
import 'package:newJoyo/models/mpi.dart';
import 'package:newJoyo/models/realization.dart';
import 'package:newJoyo/models/spk.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Penyuplai {
  @Id(assignable: true)
  int id;
  String penyuplaiId;
  String nomorHp;

  String alamat;


  Penyuplai(
      {this.id = 0,
      required this.penyuplaiId,
     required this.nomorHp,
      required this.alamat});
}
