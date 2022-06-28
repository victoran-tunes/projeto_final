import 'package:flutter/material.dart';
import 'package:projeto_final/model/model.dart';
import 'package:projeto_final/repository/repository.dart';

class RegisterProduct extends StatefulWidget {

  final Product product;
  RegisterProduct({this.product});

  @override
  _RegisterProductState createState() => _RegisterProductState();
}

class _RegisterProductState extends State<RegisterProduct> {

  final ProductRepository _repository = ProductRepository();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();
  TextEditingController _cepController = new TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.product != null) {
      _nameController.text = widget.product.name.toString();
      _valueController.text = widget.product.value.toString();
      _cepController.text = widget.product.cep.toString();
      _isUpdate = true;
    }
  }

  _createFields(controller, keyboard, String hintText, int length, String message) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: new InputDecoration(
            hintText: hintText
        ),
        maxLength: length,
        validator: (value) {
          if(value.isEmpty) {
            return message;
          }
          return null;
        },
      )
    );
  }
  
  _formUI(BuildContext context) {
    return Column(
      children: [
        _createFields(_nameController, TextInputType.text, "Digite o nome do produto", 30, "Digite um nome válido"),
        _createFields(_valueController, TextInputType.number, "Digite o valor do produto", 10, "Digite um valor válido"),
        _createFields(_cepController, TextInputType.number, "Digite seu cep", 8, "Digite um cep válido")
      ],
    );
  }

  _rowForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: _formUI(context)
    );
  }

  _rowButton(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          _register(context);
          _resetFields();
        },
        style: TextButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.all(20.0),
            backgroundColor: Theme.of(context).primaryColor
        ),
        icon: Icon(Icons.add),
        label: Text(_isUpdate ? 'Alterar produto' : 'Cadastro de produto')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdate ? 'Alterar produto' : 'Cadastro de produto'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _rowForm(),
          _rowButton(context)
        ],
      ),
    );
  }

  _resetFields() => _formKey.currentState.reset();

  _register(BuildContext context) {
    print('Validou o formulario: ${_formKey.currentState.validate()}');
    if(_formKey.currentState.validate()) {

      if(_isUpdate) {
        widget.product.name = _nameController.text;
        widget.product.value = double.tryParse(_valueController.text);
        widget.product.cep = int.tryParse(_cepController.text);
        this._repository.update(widget.product);
        _showSnackBar('Produto alterado com sucesso');
      } else {
        final product = Product(
            name: _nameController.text,
            value: double.tryParse(_valueController.text),
            cep: int.tryParse(_cepController.text)
        );
        this._repository.save(product);
        _showSnackBar('Produto cadastrado com sucesso');
      }

      setState(() {
        Navigator.pop(context, true);
      });

    } else {
      _showSnackBar('Digite os campos corretamente');
    }
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),)
    );
  }

}
