class Famille {
  String? familyname;
  Famille({required this.familyname});

  Map<String, dynamic> toMap() {
    return {
      'familyname': familyname,
    };
  }

  static Famille fromMap(Map<String, dynamic> json) {
    return Famille(
      familyname: json['familyname'],
    );
  }
}
