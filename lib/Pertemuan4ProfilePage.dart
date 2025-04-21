import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Pertemuan4ProfilePage extends StatefulWidget {
  const Pertemuan4ProfilePage({super.key});

  @override
  State<Pertemuan4ProfilePage> createState() => _Pertemuan4ProfilePageState();
}

class _Pertemuan4ProfilePageState extends State<Pertemuan4ProfilePage> {
  String _nama = '';
  String _nim = '';
  String _fakultas = '';
  String _prodi = '';
  String _alamat = '';
  String _hp = '';
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('nama') ?? '';
      _nim = prefs.getString('nim') ?? '';
      _fakultas = prefs.getString('fakultas') ?? '';
      _prodi = prefs.getString('prodi') ?? '';
      _alamat = prefs.getString('alamat') ?? '';
      _hp = prefs.getString('hp') ?? '';
      final fotoPath = prefs.getString('foto');
      if (fotoPath != null && fotoPath.isNotEmpty) {
        _image = File(fotoPath);
      }
    });
  }

  Widget _buildInfo(String title, String value, IconData icon) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Color(0xFF5D504A)),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      )),
                  SizedBox(height: 4),
                  Text(value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E322D),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF6F0),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7F675B), Color(0xFF5D504A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Data Diri', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEFE6DF), Color(0xFFD8CFC7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF5D504A), width: 3),
                    ),
                    child: ClipOval(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 130,
                              height: 130,
                              color: Color(0xFFD8CFC7),
                              child: Icon(Icons.person,
                                  size: 80, color: Color(0xFF5D504A)),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfo('Nama', _nama, Icons.person),
                  _buildInfo('NIM', _nim, Icons.badge),
                  _buildInfo('Fakultas', _fakultas, Icons.school),
                  _buildInfo('Prodi', _prodi, Icons.menu_book),
                  _buildInfo('Alamat', _alamat, Icons.home),
                  _buildInfo('Nomor HP', _hp, Icons.phone),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
