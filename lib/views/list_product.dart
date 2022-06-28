import 'package:flutter/material.dart';
import 'package:projeto_final/model/model.dart';
import 'package:projeto_final/repository/repository.dart';
import 'package:projeto_final/views/product_detail.dart';
import 'package:projeto_final/views/views.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {

  ProductRepository _repository;

  _title(Product product) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('${product.name.toString()}'),
            )
          ],
        )
      ],
    );
  }

  _subtitle(Product product) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.monetization_on_outlined),
              Text('${product.value}')
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_pin),
              Text('${product.cep}')
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._repository = ProductRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seus produtos'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: this._repository.fetchAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {

          final List<Product> products = snapshot.data;

          if(snapshot.hasData){
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final Product product = products[index];
                return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.delete_forever),
                    ),
                    key: ValueKey<int>(product.id),
                    onDismissed: (DismissDirection direction) async {
                      await this._repository.delete(product);
                      setState(() {
                        snapshot.data.remove(snapshot.data[index]);
                      });
                    },
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          print('voce escolheu ${product.toString()}');
                          _showAlert(
                              'Você deseja ver detalhes e/ou alterar?',
                              button1: 'Ver detalhes',
                              button2: 'Alterar',
                              button1Function: () {
                                print('detalhes');
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => ProductDetail(product: product,)
                                    )
                                );

                              },
                              button2Function: () async {
                                print('alterar');
                                Navigator.of(context).pop();
                                final reloadPage = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => RegisterProduct(product: product,)
                                    )
                                );
                                _reloadPage(reloadPage);
                              }
                          );
                        },
                        title: _title(product),
                        subtitle: _subtitle(product),
                        leading: CircleAvatar(backgroundColor: Colors.deepPurple,),
                      ),
                    )
                );
              },
            );
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  _reloadPage(bool reloadPage) {
    if(reloadPage) {
      setState(() {
        print('vai att a tela no retorno do alterar');
      });
    }
  }

  _showAlert(String message, {String title, String button1, String button2, Function button1Function, Function button2Function}) {
    AlertDialog alert = AlertDialog(
      title: Text(title ?? 'Atenção'),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () {
              button1Function();
            },
            child: Text(button1 ?? 'Sim')
        ),
        TextButton(
            onPressed: () {
              button2Function();
            },
            child: Text(button2 ?? 'Não')
        )
      ],
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alert;
    });
  }

}
