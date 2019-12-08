import 'package:flutter/material.dart';
import 'package:luminis/product_card.dart';

import 'elepy_client.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> _availableProducts;
  final ProductClient _client = ProductClient();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() async {
    return _client
        .getProducts()
        .then((products) => setState(() => _availableProducts = products));
  }

  @override
  Widget build(BuildContext context) {
    return _availableProducts == null
        ? Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            child: RefreshIndicator(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: _availableProducts
                    .map((product) => ProductCard(product))
                    .toList(),
              ),
              onRefresh: () => refresh(),
            ),
          );
  }
}
