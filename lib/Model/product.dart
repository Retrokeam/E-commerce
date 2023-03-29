class Product{
  int id;
  String name ;
  String image ;
  double price ;
  bool isFavorite ;
  bool isSelected ;
  Product({required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.isFavorite,
    this.isSelected = false,});
}