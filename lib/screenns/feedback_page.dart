import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Ambil dari Kamera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedImage = File(picked.path);
                      });
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Pilih dari Galeri'),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedImage = File(picked.path);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }


  void _submitFeedback() {
    final feedbackText = _feedbackController.text.trim();

    if (feedbackText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap isi feedback terlebih dahulu'),
          backgroundColor: Color(0xFF1598A1),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Feedback berhasil dikirim!'),
        backgroundColor: Color(0xFF1598A1),
        duration: Duration(seconds: 1),
      ),
    );

    _feedbackController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kirim Feedback'),
        backgroundColor: Color(0xFF1598A1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berikan Masukan Anda:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tulis masukan atau saran di sini...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Unggah Gambar Pendukung (Opsional):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _selectedImage != null
                ? Image.file(
                  _selectedImage!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
                : Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Icon(Icons.image, size: 80, color: Colors.grey),
                ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.add_a_photo),
                label: Text('Pilih Gambar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1598A1),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitFeedback,
                child: Text('Kirim'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1598A1),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
