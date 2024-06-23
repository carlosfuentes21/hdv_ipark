class Ubicacion {
  String? latitud;
  String? longitud;

  Ubicacion({this.latitud, this.longitud});

  Ubicacion.fromJson(Map<String, dynamic> json) {
    latitud = json['latitud'];
    longitud = json['longitud'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    return data;
  }
}
