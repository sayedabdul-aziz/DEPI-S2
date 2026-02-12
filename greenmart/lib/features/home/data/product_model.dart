// From BE : get list of products as Json => List<Map> or Map
// Parsing the list of products as List<ProductModel>
// Use model in the UI

// data[0]["albums"][0]["url"]
// data[0].image

// [
// {
// "image" : "https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png",
// "name" : "Product 1",
// "price" : 10
// "quantity" : 20
//},
// {
// "image" : "https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png",
// "name" : "Product 1",
// "price" : 10
// "quantity" : 20
//}
// {
// "image" : "https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png",
// "name" : "Product 1",
// "price" : 10
// "quantity" : 20
//},
// {
// "image" : "https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png",
// "name" : "Product 1",
// "price" : 10
// "quantity" : 20
//},
// {
// "image" : "https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-png.png",
// "name" : "Product 1",
// "price" : 10
// "quantity" : 20
//}
// ]

class ProductModel {
  final String id;
  final String categoryId;
  final String image;
  final String name;
  final double price;
  final String quantityForPrice;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.image,
    required this.name,
    required this.price,
    required this.quantityForPrice,
  });
}
