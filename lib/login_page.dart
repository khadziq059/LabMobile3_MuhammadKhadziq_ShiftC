import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginFailed = false;

  // Simpan username ke shared preferences
  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
  }

  // Simpan login status
  void _setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', status);
  }

  // Fungsi untuk menangani proses login
  void _handleLogin() async {
    setState(() {
      _isLoginFailed = false;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (_usernameController.text == 'admin' && _passwordController.text == 'admin123') {
      _saveUsername();
      _setLoginStatus(true);

      // Pindah ke halaman utama setelah login
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      setState(() {
        _isLoginFailed = true;
      });
    }
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String placeholder,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: placeholder,
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan tombol login
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _handleLogin, 
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.blue, 
        ),
        child: const Text(
          'Login', 
          style: TextStyle(fontSize: 18, color: Colors.white), 
        ),
      ),
    );
  }

  // Widget untuk menampilkan pesan error login
  Widget _buildLoginError() {
    return _isLoginFailed
        ? const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Username atau Password salah!',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset( 
              'assets/login.jpg', 
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Selamat Datang Kembali!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            _buildTextInput(
              controller: _usernameController,
              placeholder: 'Masukkan username Anda',
            ),
            _buildTextInput(
              controller: _passwordController,
              placeholder: 'Masukkan password Anda',
              isPassword: true,
            ),
            const SizedBox(height: 20),
            _buildLoginButton(),
            _buildLoginError(),
          ],
        ),
      ),
    );
  }
}
