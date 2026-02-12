import 'package:greenmart/features/home/data/product_model.dart';

List<ProductModel> offers = [
  ProductModel(
    id: '1',
    categoryId: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png',
    name: 'Apple',
    price: 10.0,
    quantityForPrice: "1kg",
  ),
  ProductModel(
    id: '2',
    categoryId: '1',
    image:
        'https://i.pinimg.com/originals/38/1f/ae/381fae890b6d2e3aef851949e261a13a.png',
    name: 'Banana',
    price: 20.0,
    quantityForPrice: "1kg",
  ),
  ProductModel(
    id: '3',
    categoryId: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png',
    name: 'Orange',
    price: 30.0,
    quantityForPrice: "1kg",
  ),

  ProductModel(
    id: '4',
    categoryId: '1',
    image: 'https://pngimg.com/d/orange_PNG777.png',
    name: 'Carrot',
    price: 10.0,
    quantityForPrice: "1kg",
  ),
];

List<ProductModel> bestSelling = [
  ProductModel(
    id: '2',
    categoryId: '1',
    image:
        'https://i.pinimg.com/originals/38/1f/ae/381fae890b6d2e3aef851949e261a13a.png',
    name: 'Banana',
    price: 20.0,
    quantityForPrice: "1kg",
  ),

  ProductModel(
    id: '3',
    categoryId: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png',
    name: 'Orange',
    price: 30.0,
    quantityForPrice: "1kg",
  ),

  ProductModel(
    id: '4',
    categoryId: '1',
    image: 'https://pngimg.com/d/orange_PNG777.png',
    name: 'Carrot',
    price: 10.0,
    quantityForPrice: "1kg",
  ),
  ProductModel(
    id: '1',
    categoryId: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png',
    name: 'Apple',
    price: 10.0,
    quantityForPrice: "1kg",
  ),
];

List<ProductModel> allProducts = [
  ProductModel(
    id: '3',
    categoryId: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png',
    name: 'Orange',
    price: 30.0,
    quantityForPrice: "1kg",
  ),
  ProductModel(
    id: '2',
    categoryId: '1',
    image:
        'https://i.pinimg.com/originals/38/1f/ae/381fae890b6d2e3aef851949e261a13a.png',
    name: 'Banana',
    price: 20.0,
    quantityForPrice: "1kg",
  ),

  ProductModel(
    id: '1',
    categoryId: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png',
    name: 'Apple',
    price: 10.0,
    quantityForPrice: "1kg",
  ),

  ProductModel(
    id: '4',
    categoryId: '2',
    image: 'https://pngimg.com/d/orange_PNG777.png',
    name: 'Carrot',
    price: 10.0,
    quantityForPrice: "1kg",
  ),
];

List<ProductModel> getProductsByCategoryId(String categoryId) {
  return allProducts
      .where((product) => product.categoryId == categoryId)
      .toList();
  // List<ProductModel> filteredProducts = [];

  // for (var product in allProducts) {
  //   if (product.categoryId == categoryId) {
  //     filteredProducts.add(product);
  //   }
  // }
  // return filteredProducts;
}

List<ProductModel> getProductsByName(String searchKey) {
  return allProducts
      .where((product) => product.name.toLowerCase().contains(searchKey))
      .toList();
}
