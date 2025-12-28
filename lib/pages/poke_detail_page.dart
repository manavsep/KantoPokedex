import 'package:flutter/material.dart';
import 'package:kantopokedex/models/pokemon.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:kantopokedex/pages/pokedex_page.dart';

class PokeDetailPage extends StatefulWidget {
  final Pokemon pokemon;
  final Function(bool, int) encounterBox;
  final Function(bool, int) captureBox;

  const PokeDetailPage({
    super.key,
    required this.pokemon,
    required this.encounterBox,
    required this.captureBox,
  });

  @override
  State<PokeDetailPage> createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  final AudioPlayer player = AudioPlayer();

  Map<String,dynamic> colorType={
    "Bug" : Colors.lightGreen,
    "Dark" : Colors.black,
    "Dragon" : Colors.red[700],
    "Electric" : Colors.amber,
    "Fairy" : Colors.pinkAccent,
    "Fighting" : Colors.red[300],
    "Fire" : Colors.deepOrangeAccent,
    "Flying" : Colors.cyan,
    "Ghost" : Colors.purple,
    "Grass" : Colors.greenAccent,
    "Ground" : Colors.brown,
    "Ice" : Colors.lightBlueAccent,
    "Normal" : Colors.grey,
    "Poison" : Colors.green[900],
    "Psychic" : Colors.purple[900],
    "Rock" : Colors.brown[900],
    "Steel" : Colors.blueGrey,
    "Water" : Colors.blue,
  };

  List<String> useWhitetxt =["Dark","Fairy","Flying","Ground","Poison","Psychic","Rock","Steel","Water"];


  @override
  void initState(){
    super.initState();
    playCry();
  }

  void playCry(){
    if (widget.pokemon.cry.isNotEmpty){
      player.play(UrlSource(widget.pokemon.cry));
    }
  }

  @override
  void dispose(){
    player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final po = widget.pokemon;

    return Scaffold(
      backgroundColor: Color(0xFFF0EAD6),
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text(
            po.name.toUpperCase(),
            style:TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            )
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context)=>PokedexPage()),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.white)
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height:20),
          Center(
            child: CircleAvatar(
              radius:104,
              backgroundColor: Colors.red,
              child: CircleAvatar(
                backgroundImage: NetworkImage(po.sprite),
                radius: 100,
              ),
            ),
          ),
          SizedBox(height:20),
          Center(
            child: Text(
              "#${po.id} - ${po.name.toUpperCase()}",
              style: TextStyle(
                color: Color(0xFF2E2E2E),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          Divider(
            height: 60,
            thickness: 2,
            color: Color(0xFFC8C2B0),
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Type(s) : ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2E2E),
                ),
              ),
              Wrap(
                spacing: 5,
                children: po.types.map((t){
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorType[t],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      t,
                      style: TextStyle(
                        color: useWhitetxt.contains(t) ? Colors.white : Colors.black,
                        fontSize: 20,
                      ),
                    )
                  );
                }).toList(),
              ),
            ],
          ),
          Divider(
            height: 40,
            indent: 80,
            endIndent: 80,
            thickness: 2,
            color: Color(0xFFC8C2B0),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Column(
              children: [
                Text(
                  "Height :   ${po.height.toDouble()/10} m",
                  style: TextStyle(
                    fontSize: 20,
                    color:Color(0xFF4A4A4A),
                    fontWeight: FontWeight.bold,
                  )
                ),
                Text(
                    "Weight :   ${po.weight.toDouble()/10} kg",
                    style: TextStyle(
                      fontSize: 20,
                      color:Color(0xFF4A4A4A),
                      fontWeight: FontWeight.bold,
                    )
                ),
              ],
            ),
          ),
          Divider(
            height: 40,
            indent: 80,
            endIndent: 80,
            thickness: 2,
            color: Color(0xFFC8C2B0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Text(
                  "Stats : ",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 2, 0),
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: po.stats.entries.map((t){
                    return TableRow(
                      children: [
                        Text(
                          t.key,
                          style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          t.value.toString(),
                          style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              Divider(
                height: 40,
                indent: 80,
                endIndent: 80,
                thickness: 2,
                color: Color(0xFFC8C2B0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Text(
                      "Abilities : ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2E2E),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: po.abilities.map((t){
                      final bool isHidden = t.contains("(Hidden)");
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "\u2022 $t",
                          style: TextStyle(
                            color: isHidden?Colors.red[800]:Color(0xFF6E6E6E),
                            fontSize: 20,
                            fontStyle: isHidden?FontStyle.italic:FontStyle.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Divider(
                    height: 40,
                    indent: 80,
                    endIndent: 80,
                    thickness: 2,
                    color: Color(0xFFC8C2B0),
                  ),
                  Wrap(
                    children: [
                      CheckboxListTile(
                          title: Text(
                              "Encountered :",
                              style: TextStyle(
                                fontSize: 20,
                                color:Color(0xFF6E6E6E),
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          value: po.encountered,
                          activeColor: Color(0xFF388E3C),
                          checkColor: Color(0xFFFFFFFF),
                          side: BorderSide(
                            color: Color(0xFF7A7A7A),
                            width: 2,
                          ),
                          onChanged: (value){
                            setState(() {
                              po.encountered=value!;
                            });
                            widget.encounterBox(value!, po.id);
                          }
                      ),
                      CheckboxListTile(
                          title: Text(
                              "Captured :",
                              style: TextStyle(
                                fontSize: 20,
                                color:Color(0xFF6E6E6E),
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          value: po.captured,
                          activeColor: Color(0xFF388E3C),
                          checkColor: Color(0xFFFFFFFF),
                          side: BorderSide(
                            color: Color(0xFF7A7A7A),
                            width: 2,
                          ),
                          onChanged: (value){
                            setState(() {
                              po.captured=value!;
                            });
                            widget.captureBox(value!, po.id);
                          }
                      ),
                    ],
                  ),
                  Divider(
                    height: 60,
                    thickness: 2,
                    color: Color(0xFFC8C2B0),
                  ),
                  SizedBox(height:40),
                ]
              ),
            ]
          )
        ],
      ),
    );
  }
}
