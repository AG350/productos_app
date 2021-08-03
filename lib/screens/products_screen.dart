import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(imgUrl: product.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                  top: 60,
                  right: 25,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_sharp,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            _ProductForm(
              product: product,
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () {
          //TODO: Guardar productos
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  final Product product;

  const _ProductForm({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecorations(),
        child: Form(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _genericTextEditing(product.name),
              decoration: InputDecorations.authInputDecorations(
                hintText: 'Nombre del producto',
                labelText: 'Nombre:',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _genericTextEditing(product.price),
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecorations(
                hintText: '\$150,00',
                labelText: 'Precio:',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SwitchListTile.adaptive(
              value: product.available,
              title: Text('Disponible'),
              activeColor: Colors.indigo,
              onChanged: (value) {},
            ),
          ],
        )),
      ),
    );
  }

  BoxDecoration _buildBoxDecorations() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(0, 5),
                blurRadius: 7)
          ]);
}

TextEditingController _genericTextEditing(String text) {
  final TextEditingController _txtController = TextEditingController();
  _txtController.value = TextEditingValue(text: text);
  return _txtController;
}
