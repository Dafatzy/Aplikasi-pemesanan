import 'package:aplikasi_pemesanan/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PaymentPage extends StatefulWidget {
  final String orderType;
  final int totalAmount;

  const PaymentPage({
    super.key,
    required this.orderType,
    required this.totalAmount,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPayment = 'online';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController tableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDineIn = widget.orderType == 'Makan di Tempat';

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        leading: BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tipe Pesanan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text('Tipe Pesanan'),
                  backgroundColor: Colors.grey[200],
                ),
                Chip(
                  label: Text(widget.orderType),
                  backgroundColor: Color(0xFF1598A1),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Metode Pembayaran
            Text(
              "Metode Pembayaran",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      children: [
                        Icon(Icons.qr_code, size: 18),
                        SizedBox(width: 6),
                        Text("Pembayaran Digital"),
                      ],
                    ),
                    selected: selectedPayment == 'online',
                    onSelected: (_) {
                      setState(() => selectedPayment = 'online');
                    },
                    selectedColor: Color(0xFF1598A1),
                    labelStyle: TextStyle(
                      color:
                          selectedPayment == 'online'
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      children: [
                        Icon(Icons.store, size: 18),
                        SizedBox(width: 6),
                        Text("Bayar Di Kasir"),
                      ],
                    ),
                    selected: selectedPayment == 'cashier',
                    onSelected: (_) {
                      setState(() => selectedPayment = 'cashier');
                    },
                    selectedColor: Color(0xFF1598A1),
                    labelStyle: TextStyle(
                      color:
                          selectedPayment == 'cashier'
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

           
            Text(
              "Informasi Pembayaran",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildTextField("Nama Lengkap", nameController),
            _buildTextField("Email", emailController),
            _buildTextField("Nomor Telepon", phoneController),
            if (isDineIn) _buildTextField("Nomor Meja", tableController),
            SizedBox(height: 16),

            // QR atau Instruksi
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  selectedPayment == 'online'
                      ? Column(
                        children: [
                          Icon(Icons.qr_code_2, size: 80),
                          SizedBox(height: 8),
                          Text("Selesaikan pembayaran dengan scan QR di atas"),
                        ],
                      )
                      : Text(
                        "Bayar di kasir sesuai total pembayaran Anda.",
                        textAlign: TextAlign.center,
                      ),
            ),
            SizedBox(height: 24),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp${widget.totalAmount}",
                  style: TextStyle(
                    color: Color(0xFF1598A1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

           
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1598A1),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                  );

                  await Future.delayed(Duration(seconds: 2));

                  Navigator.pop(context);

                  Provider.of<CartProvider>(context, listen: false).clearCart();

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.scale,
                    title: 'Pembayaran Berhasil',
                    desc: 'Terima kasih! Pesanan Anda sedang diproses.',
                    btnOkText: 'Oke',
                    btnOkOnPress: () {
                      Navigator.pop(context);
                    },
                  ).show();
                },

                child: Text(
                  "BAYAR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
