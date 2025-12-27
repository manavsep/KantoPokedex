import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:kantopokedex/models/pokemon.dart";

class PokeApi {
  static Future<Pokemon> fetchPokemon(int id)async{
    final url = "https://pokeapi.co/api/v2/pokemon/$id";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    return Pokemon(
      id: id,
      name: data["name"],
      types: List<String>.from(data["types"].map((t) => t['type']['name'])),
      sprite: data["sprites"]["front_default"],
    );
  }
}