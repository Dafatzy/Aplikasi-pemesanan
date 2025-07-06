class CartItem {
  final String name;
  final String price;
  final String imagePath;
  final String subtotal;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.subtotal,
    this.quantity = 1,
  });
}
