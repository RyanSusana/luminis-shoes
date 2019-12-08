import 'package:flutter/material.dart';

import 'elepy_client.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Hero(
              tag: product.variants.first.subtitle,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(product.variants.first.image),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
