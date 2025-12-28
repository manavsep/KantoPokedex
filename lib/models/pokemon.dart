class Pokemon {
  int id;
  String name;
  List<String> types;
  String sprite;
  bool encountered;
  bool captured;
  String cry;
  int height;
  int weight;
  Map<String,int> stats;
  List<String> abilities;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprite,
    required this.cry,
    required this.height,
    required this.weight,
    required this.stats,
    required this.abilities,
    this.encountered = false,
    this.captured = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'types': types,
    'sprite': sprite,
    'cry' : cry,
    'encountered': encountered,
    'captured': captured,
    'height' : height,
    'weight' : weight,
    'stats' : stats,
    'abilities' : abilities,
  };

  factory Pokemon.fromMap(Map map) => Pokemon(
    id: map['id'],
    name: map['name'],
    types: List<String>.from(map['types']),
    sprite: map['sprite'],
    encountered: map['encountered'],
    captured: map['captured'],
    cry: map['cry'],
    height: map['height'],
    weight: map['weight'],
    stats: Map<String,int>.from(map['stats']),
    abilities: List<String>.from(map['abilities']),
  );
}