import 'package:objectbox/objectbox.dart';

@Entity()
class Spk {
  @Id(assignable: true)
  int id;
  String jtId;
  String customerName;
  String policeNumber;
  String namaKendaraan;
  String tipeKendaraan;
  int levelPekerjaan;
  String date;
  int km;
  String noPkb;
  String noRangka;
  String alamat;
  String analisa;
  String keluhanKonsumen;
  String jenisPekrjaan;
  String sukuCadang;
  String catatan;
  String namaMekanik;
  double estimasiBiyaya;
  String estimasiSelesai;
  String namaInspeektor;
  String namaAdvisor;

  Spk({
    this.id = 0,
     this.jtId='',
     this.customerName='Nama',
     this.levelPekerjaan=1,
     this.jenisPekrjaan='',
     this.noPkb='',
     this.noRangka='',
     this.tipeKendaraan='',
     this.sukuCadang='',
     this.km=0,
     this.policeNumber='',
     this.namaKendaraan='',
     this.date='DD/MM/YYYY',
     this.alamat='',
     this.analisa='',
     this.keluhanKonsumen='',
     this.catatan='',
     this.namaMekanik='',
     this.estimasiBiyaya=0.0,
     this.estimasiSelesai='0',
     this.namaAdvisor='',
     this.namaInspeektor='',
  });
}
