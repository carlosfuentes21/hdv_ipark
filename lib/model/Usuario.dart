class Usuario {
  String? rut;
  String? digVer;
  String? mail;
  String? nombres;
  String? apellidos;
  String? telefono;
  String? claveAcceso;
  String? ciudad;
  String? estado;
  String? imeiCelular;
  String? serieCelular;
  int? keySession;
  int? id;

  Usuario.secundario(
      {this.rut,
      this.digVer,
      this.mail,
      this.nombres,
      this.apellidos,
      this.telefono,
      this.claveAcceso,
      this.ciudad,
      this.estado,
      this.imeiCelular,
      this.serieCelular,
      this.keySession,
      this.id});

  Usuario.primario(
      {this.rut,
      this.digVer,
      this.mail,
      this.nombres,
      this.apellidos,
      this.telefono,
      this.ciudad,
      this.estado,
      this.keySession,
      this.id});

  Usuario.fromJson(Map<String, dynamic> json) {
    keySession = json['keySession'];
    rut = json['rut'];
    digVer = json['digVer'];
    mail = json['mail'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    telefono = json['telefono'];
    ciudad = json['ciudad'];
    estado = json['estado'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keySession'] = this.keySession;
    data['rut'] = this.rut;
    data['digVer'] = this.digVer;
    data['mail'] = this.mail;
    data['nombres'] = this.nombres;
    data['apellidos'] = this.apellidos;
    data['telefono'] = this.telefono;
    data['ciudad'] = this.ciudad;
    data['estado'] = this.estado;
    data['id'] = this.id;
    return data;
  }
}
