
class Cep {

  final district;
  final city;
  final address;
  final state;

  Cep(this.district, this.city, this.address, this.state);

  String get getDistrict => district;

  String get getCity => city;

  String get getAddress => address;

  String get getState => state;

  factory Cep.fromJson(Map<String, dynamic> json) {
    return Cep(
     json['bairro'],
      json['cidade'],
      json['logradouro'],
      json['estado']
    );
  }

  @override
  String toString() {
    return '\nBairro: $district\n'
           'Cidade: $city\n'
           'Endereço: $address\n'
           'Estado: $state';
  }
}