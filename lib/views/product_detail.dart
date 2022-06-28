import 'package:flutter/material.dart';
import 'package:projeto_final/model/model.dart';
import 'package:projeto_final/service/service.dart';

class ProductDetail extends StatefulWidget {

  final Product product;
  ProductDetail({this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String _id;
  String _name;
  String _value;
  String _cep;
  String _data = "";
  bool _progress = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       _id = widget.product.id.toString();
       _name = widget.product.name.toString();
       _value = widget.product.value.toString();
       _cep = widget.product.cep.toString();
  }

  _rowButton(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          _search(context,'${_cep}');
        },
        icon: Icon(Icons.location_pin),
        label: Text('Ver endereço completo')
    );
  }

  _rowProgress() {
    return _progress ? CircularProgressIndicator() : Text('');
  }

  _rowProduct() {
    return Column(
      children: [
           Text('Id do Produto: ${_id}', style: TextStyle(fontSize: 18)),
           Text('Nome do Produto: ${_name}', style: TextStyle(fontSize: 18)),
           Text('Valor do Produto: ${_value}', style: TextStyle(fontSize: 18)),
           Text('Cep do Produto: ${_cep}', style: TextStyle(fontSize: 18))
      ],
    );
  }

  _rowResult() {
    return Row(
      children: [
         Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 100),
              child: Text('Endereço: ${_data}', style: TextStyle(
                  fontSize: 20.0
              ),
              ),
            )
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do produto'),
         centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _rowProduct(),
          _rowButton(context),
          _rowProgress(),
          _rowResult()
        ],
      ),
    );
  }

  _search(BuildContext context, String yourCep) async {
    var cepService = CepService();

    setState(() {
      _progress = true;
    });

    Cep cep = await cepService.getCep(cep: yourCep);

    setState(() {
      _data = cep.toString();
      _progress = false;
      print('${cep.toString()}');
    });
  }

}