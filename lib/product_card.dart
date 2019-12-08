import 'package:flutter/material.dart';
import 'package:luminis/product_detail.dart';

import 'elepy_client.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard(
    this.product, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductDetail(product))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Card(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                CaptionImage(product: product),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          // ?? is Dart's elvis operator. It basically means 'if the left side is null, use the right side'
                          product.description ?? "No description",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      //  Dart supports if/else, for-loops and spread operators in Collection declarations
                      if (product.variants.length > 1) ...[
                        Text(
                          "Available in ${product.variants.length} variants",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          "Starts at €${product.variants.first.price.toStringAsFixed(2)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ] else
                        Text(
                          "€${product.variants.first.price.toStringAsFixed(2)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CaptionImage extends StatelessWidget {
  const CaptionImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: Hero(
            tag: product.variants.first.subtitle ?? "",
            child: Image.network(product.variants.first.image),
          ),
        ),
      ),
    );
  }
}
