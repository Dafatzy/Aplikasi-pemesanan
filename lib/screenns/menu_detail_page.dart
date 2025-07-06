import 'package:aplikasi_pemesanan/models/cart_item.dart';
import 'package:aplikasi_pemesanan/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class MenuDetailPage extends StatefulWidget {
  final String name;
  final String price;
  final String imagePath;

  const MenuDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  _MenuDetailPageState createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  String selectedRice = 'Nasi Putih';
  List<String> selectedExtras = [];
  int quantity = 1;

  void toggleExtra(String extra) {
    setState(() {
      if (selectedExtras.contains(extra)) {
        selectedExtras.remove(extra);
      } else {
        selectedExtras.add(extra);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1598A1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.name.toUpperCase(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                RatingBarIndicator(
                  rating: 5.0,
                  itemBuilder:
                      (context, index) => Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 24.0,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 8),
                Text("5.0", style: TextStyle(fontSize: 16)),
                Spacer(),
                Text(
                  widget.price,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 8),
            Text(
              'AYAM BAKAR DENGAN BUMBU RAHASIA HANYA ADA DI SINI',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'PILIH JENIS NASI (WAJIB):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children:
                  ['Nasi Putih', 'Nasi Merah', 'Nasi Uduk'].map((rice) {
                    return RadioListTile<String>(
                      title: Text(rice),
                      value: rice,
                      groupValue: selectedRice,
                      onChanged: (value) {
                        setState(() {
                          selectedRice = value!;
                        });
                      },
                    );
                  }).toList(),
            ),
            SizedBox(height: 8),
            Text(
              'TAMBAHAN PELENGKAP (OPSIONAL):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Sambal Ekstra'),
              value: selectedExtras.contains('Sambal Ekstra'),
              onChanged: (_) => toggleExtra('Sambal Ekstra'),
            ),
            CheckboxListTile(
              title: Text('Kerupuk'),
              value: selectedExtras.contains('Kerupuk'),
              onChanged: (_) => toggleExtra('Kerupuk'),
            ),
            CheckboxListTile(
              title: Text('Lalapan'),
              value: selectedExtras.contains('Lalapan'),
              onChanged: (_) => toggleExtra('Lalapan'),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL ORDER',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1598A1),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  final item = CartItem(
                    name: widget.name,
                    price: widget.price,
                    imagePath: widget.imagePath,
                    quantity: quantity,
                    subtotal: '',
                  );
                  Provider.of<CartProvider>(
                    context,
                    listen: false,
                  ).addToCart(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(' ditambahkan ke keranjang!'),
                      backgroundColor: Color(0xFF1598A1),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Text(
                  'TAMBAH KE KERANJANG',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
