import 'package:flutter/material.dart';

class ImageByPass extends StatelessWidget {
  final String? imageUrl;

  const ImageByPass({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _imageBypass(imageUrl);
  }

  Widget _imageBypass(String? url) {
    if (url != null)
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(url),
        fit: BoxFit.cover,
      );
    else
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
  }
}
