import 'package:flutter/material.dart';

class BT6Register extends StatefulWidget {
  const BT6Register({super.key});

  @override
  State<BT6Register> createState() => _BT6RegisterState();
}

class _BT6RegisterState extends State<BT6Register> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Đăng ký thành công!")));
      //  ---> Tại đây có thể gọi API hoặc Firebase Auth để tạo tài khoản thật
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Đăng ký tài khoản")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// HỌ TÊN
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputStyle("Họ tên", Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập họ tên";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    /// EMAIL
                    TextFormField(
                      controller: _emailController,
                      decoration: _inputStyle("Email", Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập email";
                        }
                        if (!_isValidEmail(value)) {
                          return "Email không hợp lệ";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    /// PASSWORD
                    TextFormField(
                      controller: _passController,
                      obscureText: _hidePassword,
                      decoration: _inputStyle("Mật khẩu", Icons.lock).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => _hidePassword = !_hidePassword);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mật khẩu";
                        }
                        if (value.length < 6) {
                          return "Mật khẩu phải có ít nhất 6 ký tự";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    /// CONFIRM PASSWORD
                    TextFormField(
                      controller: _confirmPassController,
                      obscureText: _hideConfirmPassword,
                      decoration: _inputStyle("Xác nhận mật khẩu", Icons.lock)
                          .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _hideConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:
                                    (_confirmPassController.text ==
                                            _passController.text &&
                                        _confirmPassController.text.isNotEmpty)
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              onPressed: () {
                                setState(
                                  () => _hideConfirmPassword =
                                      !_hideConfirmPassword,
                                );
                              },
                            ),
                          ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Hãy nhập lại mật khẩu";
                        }
                        if (value != _passController.text) {
                          return "Mật khẩu xác nhận không khớp";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    /// BUTTON ĐĂNG KÝ
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _register,
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Hàm style input field — giúp code gọn và chuẩn
  InputDecoration _inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}
