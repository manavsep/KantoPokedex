class Pokemon {
  int id;
  String name;
  List<String> types;
  String sprite;
  bool encountered;
  bool captured;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprite,
    this.encountered = false,
    this.captured = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'types': types,
    'sprite': sprite,
    'encountered': encountered,
    'captured': captured,
  };

  factory Pokemon.fromMap(Map map) => Pokemon(
    id: map['id'],
    name: map['name'],
    types: List<String>.from(map['types']),
    sprite: map['sprite'],
    encountered: map['encountered'],
    captured: map['captured'],
  );
}