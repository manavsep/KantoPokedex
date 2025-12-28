import 'package:flutter/material.dart';
import 'package:kantopokedex/models/pokemon.dart';
import 'package:kantopokedex/pages/poke_detail_page.dart';

class Listing extends StatelessWidget {
  final Pokemon pokemon;
  final String types;
  final String id;
  final Function(bool, int) encounterBox;
  final Function(bool, int) captureBox;

  const Listing({
    super.key,
    required this.pokemon,
    required this.types,
    required this.id,
    required this.encounterBox,
    required this.captureBox,
  });

  @override
  Widget build(BuildContext context) {
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
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>PokeDetailPage(
                  pokemon: pokemon,
                  encounterBox: encounterBox,
                  captureBox: captureBox,
                )),
              );
            },
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
}