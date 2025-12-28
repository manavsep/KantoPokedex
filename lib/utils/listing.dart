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
            tileColor: Color(0xFFDAD4C4),
            leading: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(pokemon.sprite),
            ),
            title: Text(
              pokemon.name.toUpperCase(),
              style: TextStyle(
                color: Color(0xFF2E2E2E),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Type(s): $types",
              style: TextStyle(
                color: Color(0xFF5E6A5E),
              ),
            ),
            trailing: Text(
              "#$id",
              style: TextStyle(
                color: Color(0xFF8B8B8B),
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
                    color:Color(0xFF6E6E6E),
                  )
              ),
              activeColor: Color(0xFF388E3C),
              checkColor: Color(0xFFFFFFFF),
              side: BorderSide(
                color: Color(0xFF7A7A7A),
                width: 2,
              ),
              tileColor: Color(0xFFDAD4C4),
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
                    color:Color(0xFF6E6E6E),
                  )
              ),
              activeColor: Color(0xFF388E3C),
              checkColor: Color(0xFFFFFFFF),
              side: BorderSide(
                color: Color(0xFF7A7A7A),
                width: 2,
              ),
              tileColor: Color(0xFFDAD4C4),
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