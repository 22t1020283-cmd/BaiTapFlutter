import 'package:flutter/material.dart';
import 'bt11_profile.dart'; // Import trang Profile
import 'package:bttonghopgk/services/bt11_auth_service.dart'; // Import Service

class BT11Login extends StatefulWidget {
  const BT11Login({super.key});

  @override
  State<BT11Login> createState() => _BT11LoginState();
}

class _BT11LoginState extends State<BT11Login> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(
    text: 'emilys',
  ); // Tài khoản demo
  final passwordController = TextEditingController(text: 'emilyspass');
  bool loading = false;
  String? errorMessage;

  Future<void> handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
      errorMessage = null;
    });

    // Gọi API đăng nhập
    final token = await AuthService.login(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => loading = false);

    if (token != null) {
      // Đăng nhập thành công -> Chuyển sang trang Profile
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BT11Profile(token: token)),
        );
      }
    } else {
      setState(() => errorMessage = 'Tên đăng nhập hoặc mật khẩu sai!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_person, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                const Text(
                  'Đăng Nhập',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sử dụng tài khoản DummyJSON',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) =>
                      v!.isEmpty ? 'Vui lòng nhập username' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) =>
                      v!.isEmpty ? 'Vui lòng nhập password' : null,
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: loading ? null : handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Đăng nhập',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Gợi ý tài khoản cho người chấm bài dễ test
                    usernameController.text = 'emilys';
                    passwordController.text = 'emilyspass';
                  },
                  child: const Text('Dùng tài khoản Demo (emilys/emilyspass)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
