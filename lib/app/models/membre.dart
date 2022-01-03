class Member {
  int? id;
  String? firstName;
  String? lastName;
  int? phoneNumber;
  int? quantite;
  int? idMaterial;
  String? state;
  DateTime? dateReturn;
  Member(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.idMaterial,
      required this.quantite,
      required this.state,
      required this.dateReturn});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'quantite': quantite,
      'idMaterial': idMaterial,
      'state': state,
      'dateReturn':
          dateReturn != null ? dateReturn!.microsecondsSinceEpoch : null
    };
  }

  static Member fromMap(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      quantite: json['quantite'],
      idMaterial: json['idMaterial'],
      state: json['state'],
      dateReturn: json['dateReturn'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(json['dateReturn'])
          : null,
    );
  }
}
