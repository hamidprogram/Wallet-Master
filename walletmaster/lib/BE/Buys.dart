import 'package:hive/hive.dart';

part 'Buys.g.dart';

@HiveType(typeId: 1)
class Buy{

  @HiveField(0)
  String buytitle;

  @HiveField(1)
  String mony;

  @HiveField(2)
  String date;

  Buy(this.buytitle,this.mony,this.date);
}