
class Product {

  int id;
  String name;
  double value;
  int cep;

  Product({this.id, this.name, this.value, this.cep});

  Product.fromMap(Map<String, dynamic> map) {
    this.id = map['id_column'];
    this.name = map['name_column'];
    this.value = map['value_column'];
    this.cep = map['cep_column'];
  }

  Map<String, Object> toMap() {
    Map<String, Object> map = {
      "name_column" : this.name,
      "value_column" : this.value,
      "cep_column" : this.cep,
    };
    if(id != null) {
      map['id_column'] = this.id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, value: $value, cep: $cep}';
  }
}
