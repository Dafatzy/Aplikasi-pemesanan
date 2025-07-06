// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_pemesanan/models/cart_item.dart';
import 'package:aplikasi_pemesanan/provider/cart_provider.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String orderType = "Makan di Tempat"; 
    final String detail = orderType == "Makan di Tempat" ? "Meja 5" : "Posisi A1";

    final cartItems = Provider.of<CartProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Pengguna'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/homeRestaurant');
          if (index == 1) Navigator.pushNamed(context, '/home');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Restoran'),
          BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tipe Pesanan: $orderType", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(orderType == "Makan di Tempat" ? "Nomor Meja: $detail" : "Posisi: $detail", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Text("Keranjang Pesanan", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(child: Text("Keranjang Anda kosong."))
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Image.asset(item.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(item.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Harga: Rp${item.price}"),
                                Text("Jumlah: ${item.quantity}"),
                                Text("Subtotal: Rp${item.subtotal}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.support_agent),
                    label: const Text("Hubungi Pelayan"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pilihanMakan');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.location_on),
                    label: const Text("Ganti Lokasi / Meja"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
