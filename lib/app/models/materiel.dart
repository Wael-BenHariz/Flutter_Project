class Materiel {
  int? id;
  String? nomMateriel;
  int? quantite;
  DateTime? dateAcqui;
  String? nomF;
  Materiel({
    required this.id,
    required this.nomMateriel,
    required this.quantite,
    required this.dateAcqui,
    required this.nomF,
  });
  Materiel.create(this.nomMateriel, this.quantite, this.dateAcqui, this.nomF);

  Map<String, dynamic> toMap() {
    return {
      'nomMateriel': nomMateriel,
      'quantite': quantite,
      'dateAcquisition': dateAcqui!.microsecondsSinceEpoch,
      'nomF': nomF,
    };
  }

  static Materiel fromMap(Map<String, dynamic> json) {
    return Materiel(
      id: json['id'],
      nomMateriel: json['nomMateriel'],
      quantite: json['quantite'],
      dateAcqui: DateTime.fromMicrosecondsSinceEpoch(json['dateAcquisition']),
      nomF: json['nomF'],
    );
  }
}
