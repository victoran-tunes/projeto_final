import 'dart:convert';
import 'package:projeto_final/costant.dart';
import 'package:projeto_final/model/model.dart';
import 'package:http/http.dart' as http;

class CepService {

  Future<Cep> getCep({String cep}) async {

    print('Cep ${cep.toString()}');

    var url = Uri.https(Constant.baseURL, Constant.endPonit+'${cep}');

    final response = await http.Client().get(url);

    if(response.statusCode != 200)
      throw Exception();

    print('body: ${response.body}');

    return parsedJson(response.body);
  }

  Cep parsedJson(final response) {
    final jsonDecode = json.decode(response);
    return Cep.fromJson(jsonDecode);
  }

}