import 'package:hive/hive.dart';
import 'package:kantopokedex/models/pokemon.dart';

class LocalStorage{
  static final box = Hive.box("pokedex");

  static void addPoke(Pokemon p){
    box.put(p.id,p.toMap());
  }

  static Pokemon? getPoke(int id){
    final data = box.get(id);
    return data!=null?Pokemon.fromMap(data):null;
  }
}