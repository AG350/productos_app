import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//
import 'package:provider/provider.dart';
import 'package:productos_app/providers/product_form_provider.dart';
//
import 'package:productos_app/services/services.dart';
//
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductFormBody(productService: productService),
    );
  }
}

class _ProductFormBody extends StatelessWidget {
  const _ProductFormBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(imgUrl: productService.selectedProduct.picture),
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
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 100,
                        );
                        if (pickedFile == null) {
                          print('no selecciono nada');
                          return;
                        }

                        print('Tenemos imagen ${pickedFile.path}');
                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      },
                      icon: Icon(
                        Icons.camera_alt_sharp,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Icon(Icons.save_outlined),
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;
                final String? imageUrl = await productService.uploadImage();
                if (imageUrl != null) productForm.product.picture = imageUrl;
                await productService.saveOrCreateProduct(productForm.product);
              },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecorations(),
        child: Form(
          key: productFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return ' El nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecorations(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: product.price.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}')),
                ],
                onChanged: (value) => double.tryParse(value) == null
                    ? product.price = 0
                    : product.price = double.parse(value),
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
                onChanged: productFormProvider.updateAvailability,
              ),
            ],
          ),
        ),
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
