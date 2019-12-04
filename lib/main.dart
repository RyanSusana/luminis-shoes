

import 'package:flutter/material.dart';
import 'package:luminis/elepy_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(child: ProductList()),
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // FutureBuilder can be used for Async programming, when you expect data later
      child: FutureBuilder<List<Product>>(
        future: ProductClient(
            url: "https://luminis-flutter-backend-wtihbsmtva-ew.a.run.app/")
            .getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            return ListView(
              children:
              snapshot.data.map((product) => ProductCard(product)).toList(),
            );
          } else {
            return Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard(
      this.product, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.7,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductDetail(product))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Card(
            color: Colors.blue,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Hero(
                        tag: product.variants.first.subtitle,
                        child: Image.network(product.variants.first.image),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: TextStyle(fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            // ?? is Dart's elvis operator. It basically means 'if the left side is null, use the right side'
                            product.description ?? "No description",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //  Dart supports if/else, for-loops and spread operators in Collections
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

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(product.title),
            Hero(
              tag: product.variants.first.subtitle,
              child: Image.network(product.variants.first.image),
            )
          ],
        ),
      ),
    );
  }
}
