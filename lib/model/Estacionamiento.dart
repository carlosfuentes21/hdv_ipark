
class Estacionamiento {
  int? id;
  String? name;
  double? latitude;
  double? longitude;
  String? tariff;
  String? schedule;
  String? addresss;
  int? availablePlaces;
  bool? state;
  double? distanceKm;

  Estacionamiento(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.tariff,
      this.schedule,
      this.addresss,
      this.availablePlaces,
      this.state,
      this.distanceKm});

  Estacionamiento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    tariff = json['tariff'];
    schedule = json['schedule'];
    addresss = json['addresss'];
    availablePlaces = json['availablePlaces'];
    state = json['state'];
    distanceKm = json['distanceKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['tariff'] = this.tariff;
    data['schedule'] = this.schedule;
    data['addresss'] = this.addresss;
    data['availablePlaces'] = this.availablePlaces;
    data['state'] = this.state;
    data['distanceKm'] = this.distanceKm;
    return data;
  }
}
