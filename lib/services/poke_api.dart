import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:kantopokedex/models/pokemon.dart";
import 'package:kantopokedex/utils/titlecase.dart';

class PokeApi {
  static Future<Pokemon> fetchPokemon(int id)async{
    final url = "https://pokeapi.co/api/v2/pokemon/$id";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    return Pokemon(
      id: id,
      name: data["name"],
      types: List<String>.from(data["types"].map((t) => Titlecase.titleCase(t['type']['name']))),
      sprite: data["sprites"]["front_default"],
      cry: data["cries"]?["latest"]??"",
      height: data["height"],
      weight: data["weight"],
      stats: {
        for(final e in data["stats"])
          Titlecase.titleCase(e["stat"]["name"]):e["base_stat"] as int,
      },
      abilities: List<String>.from(data["abilities"].map((t) {
        final nameAbility = Titlecase.titleCase(t["ability"]["name"]);
        return t["is_hidden"] ? "$nameAbility (Hidden)" : nameAbility;
      })),
    );
  }
}