import 'package:flutter/material.dart';
import 'package:kantopokedex/models/pokemon.dart';
import 'package:kantopokedex/services/poke_api.dart';
import 'package:kantopokedex/storage/local_storage.dart';
import 'package:kantopokedex/utils/listing.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {

  List<Pokemon> pokemons=[];
  bool isLoading=false;
  List<Pokemon> database=[];

  final List<String> types = [
    "All Types",
    "Bug",
    "Dark",
    "Dragon",
    "Electric",
    "Fairy",
    "Fighting",
    "Fire",
    "Flying",
    "Ghost",
    "Grass",
    "Ground",
    "Ice",
    "Normal",
    "Poison",
    "Psychic",
    "Rock",
    "Steel",
    "Water",
  ];
  final List<String> status = [
    "All",
    "Encountered",
    "Captured",
    "Not encountered",
    "Not captured",
  ];

  String searchQuery = '';
  String selectedType = '';
  String statusPoke='';


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
    setState(() {
      searchQuery = query;
      applyFilters();
    });
  }
  void filterByType(String type) {
    setState(() {
      if (type == "All Types") {
        selectedType = '';  // Reset to show all Pokémon types
      } else {
        selectedType = type;  // Apply selected type
      }
      applyFilters();
    });
  }
  void filterByStatus(String stat){
    setState(() {
      statusPoke=stat;
      applyFilters();
    });
  }


  void applyFilters() {
    List<Pokemon> filteredList = database;

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((pokemon) =>
      pokemon.name.toLowerCase().contains(searchQuery.toLowerCase())||pokemon.id.toString().contains(searchQuery)).toList();
    }

    if (selectedType.isNotEmpty) {
      filteredList = filteredList.where((pokemon) =>
          pokemon.types.contains(selectedType)).toList();
    }

    if (statusPoke=="Encountered"){
      filteredList = filteredList.where((pokemon) =>
      pokemon.encountered==true).toList();
    }else if (statusPoke=="Not encountered"){
      filteredList = filteredList.where((pokemon) =>
      pokemon.encountered==false).toList();
    }else if (statusPoke=="Captured"){
      filteredList = filteredList.where((pokemon) =>
      pokemon.captured==true).toList();
    }else if (statusPoke=="Not captured"){
      filteredList = filteredList.where((pokemon) =>
      pokemon.captured==false).toList();
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
      applyFilters();
    });
  }

  void captureBox(bool value,int id){
    setState(() {
      final p = database.firstWhere((p) => p.id == id);
      p.captured = value;
      LocalStorage.addPoke(p);
      applyFilters();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                  child: Container(
                    width: 150,
                    color: Colors.white70,
                    child: DropdownMenu(
                      onSelected: (value){
                        filterByType(value!);
                      },
                      menuHeight: 500,
                      initialSelection: "All Types",
                      dropdownMenuEntries: types.map((type)=>
                          DropdownMenuEntry<String>(value: type, label:type)).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Container(
                    width:150,
                    color: Colors.white70,
                    child: DropdownMenu(
                      onSelected: (value){
                        filterByStatus(value!);
                      },
                      menuHeight: 250,
                      initialSelection: "All",
                      dropdownMenuEntries: status.map((s)=>
                          DropdownMenuEntry<String>(value: s, label:s)).toList(),
                    ),
                  ),
                ),
              ],
            ),
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
                    return Listing(
                        pokemon: pokemon,
                        types: types,
                        id: id,
                        encounterBox: encounterBox,
                        captureBox: captureBox
                    );
                  }
              ),
            ),
            SizedBox(height: 50),
          ],
        )
    );
  }
}