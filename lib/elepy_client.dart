import 'dart:convert';

import 'package:http/http.dart';

class Product {
  final String id, title, description;
  final List<ProductVariant> variants;

  Product.fromJson(Map<String, dynamic> json, String baseSrc)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        variants = (json['variants'] as List ?? [])
            .map((prod) => ProductVariant.fromJson(prod, baseSrc))
            .toList();
}

class ProductVariant {
  final String subtitle, description;
  final num price;

  final String image;

  ProductVariant.fromJson(Map<String, dynamic> json, String imageBaseSrc)
      : subtitle = json['subtitle'],
        description = json["description"],
        price = json['price'],
        image = "$imageBaseSrc/" + json['image'];
}

class ProductClient extends BaseClient {
  final String url;
  final Client _innerClient;
  final String _login;

  ProductClient(
      {this.url: 'https://shoes.elepy.com',
      username: 'ryan',
      password: 'susana'})
      : _innerClient = Client(),
        _login = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = _login;
    return _innerClient.send(request);
  }

  Future<List<Product>> getProducts({int pageNumber = 1, int pageSize = 5}) {
    return this
        .get(url + "/products?pageSize=$pageSize&pageNumber=$pageNumber")
        .then((response) => (jsonDecode(response.body)["values"] as List)
            .map((product) => Product.fromJson(product, this.url))
            .toList());
  }
}
