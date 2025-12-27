import 'package:flutter/material.dart';
import 'package:kantopokedex/models/pokemon.dart';
import 'package:kantopokedex/services/poke_api.dart';
import 'package:kantopokedex/storage/local_storage.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {

  List<Pokemon> pokemons=[];
  bool isLoading=false;
  List<Pokemon> database=[];
  List<Pokemon> filtered=[];


  @override
  void initState(){
    super.initState();
    loadData();
  }

  Future<void> loadData()async{
    setState(() {
      isLoading=true;
    });
    List<Pokemon> poke=[];
    for(int i=1;i<=151;i++){
      Pokemon? stored = LocalStorage.getPoke(i);
      if (stored==null) {
        Pokemon instance = await PokeApi.fetchPokemon(i);
        LocalStorage.addPoke(instance);
        poke.add(instance);
      }else{
        poke.add(stored);
      }
    }
    setState(() {
      pokemons = poke;
      database = pokemons;
      isLoading=false;
    });
  }

  void searchPokedex(String query){
    List<Pokemon> filteredList = database;
    if (query.isNotEmpty) {
      filteredList = filteredList.where((pokemon) =>
      pokemon.name.toLowerCase().contains(query.toLowerCase())||pokemon.id.toString().contains(query)).toList();
    }
    setState(() {
      pokemons = filteredList;
    });
  }

  void encounterBox(bool value,int id){
    setState(() {
      final p = database.firstWhere((p) => p.id == id);
      p.encountered = value;
      LocalStorage.addPoke(p);
    });
  }

  void captureBox(bool value,int id){
    setState(() {
      final p = database.firstWhere((p) => p.id == id);
      p.captured = value;
      LocalStorage.addPoke(p);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
              "Kanto Pokédex",
              style:TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              )
          ),
          centerTitle: true,
        ),
        body:Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (value){
                    searchPokedex(value);
                  },
                ),
              ),
            ),
            SizedBox(height:4),
            Expanded(
              child: isLoading
                  ?Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              )
                  :ListView.builder(
                  itemCount: pokemons.length,
                  itemBuilder: (context,index){
                    final pokemon = pokemons[index];
                    final types = (pokemon.types).join(", ").toUpperCase();
                    final id=pokemon.id.toString();
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                )
                            ),
                            tileColor: Colors.green,
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(pokemon.sprite),
                            ),
                            title: Text(
                              pokemon.name.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Type(s): $types",
                              style: TextStyle(
                                color: Colors.grey[200],
                              ),
                            ),
                            trailing: Text(
                              "#$id",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          CheckboxListTile(
                              title: Text(
                                  "Encountered",
                                  style: TextStyle(
                                    color:Colors.grey[200],
                                  )
                              ),
                              tileColor: Colors.green,
                              value: pokemon.encountered,
                              onChanged: (value){
                                int idno = int.parse(id);
                                encounterBox(value!, idno);
                              }
                          ),
                          CheckboxListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  )
                              ),
                              title: Text(
                                  "Captured",
                                  style: TextStyle(
                                    color:Colors.grey[200],
                                  )
                              ),
                              tileColor: Colors.green,
                              value: pokemon.captured,
                              onChanged: (value){
                                int idno = int.parse(id);
                                captureBox(value!, idno);
                              }
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        )
    );
  }
}