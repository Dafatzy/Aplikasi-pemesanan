import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi_pemesanan/screenns/home_page.dart';

class PilihanMakanPage extends StatefulWidget {
  final String lokasi;

  const PilihanMakanPage({super.key, required this.lokasi});

  @override
  _PilihanMakanPageState createState() => _PilihanMakanPageState();
}

class _PilihanMakanPageState extends State<PilihanMakanPage> {
  DateTime? selectedDateTime;

  Future _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(minutes: 30)),
      firstDate: DateTime(1990),
      lastDate: DateTime(2050)
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(Duration(minutes: 30)),
        ),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });

        print("Picked DateTime: $selectedDateTime");
      }
    }
  }

  void _showInputDialog({required bool isDineIn}) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(isDineIn ? 'Makan di Tempat' : 'Ambil Sendiri'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: isDineIn ? 'Nomor Meja' : 'Nama Pengambil',
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.schedule, color: Color(0xFF1598A1)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      selectedDateTime != null
                          ? DateFormat('EEEE, dd MMM yyyy - HH:mm', 'id_ID')
                              .format(selectedDateTime!)
                          : 'Pilih Jadwal Kedatangan (Opsional)',
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedDateTime != null
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _pickDateTime();
                      setStateDialog(() {});
                    },
                    child: Text('Pilih'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1598A1),
              ),
              child: Text(
                'Lanjut',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        nama: isDineIn
                            ? 'Meja ${controller.text}'
                            : controller.text,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1598A1),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Image.asset(
              '../assets/Logo.png',
              width: 250,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Color(0xFF1598A1), size: 30),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.lokasi,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            SizedBox(height: 4),
                            Text('Sebrang gedung putih',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Text('10 m',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Pilih cara nikmati makananmu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _showInputDialog(isDineIn: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1598A1),
                            minimumSize: Size(250, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Makan di Tempat',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white)),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _showInputDialog(isDineIn: false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1598A1),
                            minimumSize: Size(250, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Di Bawa Pulang',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
