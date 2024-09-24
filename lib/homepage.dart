import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas3/login_page.dart'; 
import 'package:tugas3/sidemenu.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fungsi untuk logout dan menghapus status login dari shared preferences
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false); 
    // Navigasi kembali ke halaman login
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context), 
          ),
        ],
      ),
      // Side menu (drawer)
      drawer: const SideMenu(), 
      // Isi dari halaman Home dengan logo dan welcome text
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/logo.png'), 
              ),
              SizedBox(height: 30),
              Text(
                'Selamat Datang Di PT. Solusi Digital Muda!',
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, 
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Subtitle Text
              Text(
                'Klik menu untuk melihat lebih banyak fitur.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54, 
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100], 
    );
  }
}
