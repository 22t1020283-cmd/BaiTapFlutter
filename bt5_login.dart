import 'package:flutter/material.dart';

class BT5Login extends StatefulWidget {
  const BT5Login({super.key});

  @override
  State<BT5Login> createState() => _BT5LoginState();
}

class _BT5LoginState extends State<BT5Login> {
  // 1. Tạo Key để quản lý Form
  final _formKey = GlobalKey<FormState>();

  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Đăng nhập')),
      // Thêm SingleChildScrollView để tránh lỗi tràn màn hình khi bàn phím hiện lên
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ), // Khoảng cách phụ để đẩy form xuống giữa
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              // 2. Bao bọc nội dung bằng Form widget
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 3. Đổi TextField thành TextFormField để dùng validator
                    TextFormField(
                      controller: _userController,
                      // Logic kiểm tra tên đăng nhập
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên người dùng'; // Thông báo lỗi
                        }
                        return null; // Hợp lệ
                      },
                      decoration: InputDecoration(
                        hintText: 'Tên người dùng',
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        // Style cho thông báo lỗi
                        errorStyle: const TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _passController,
                      obscureText: _hidePassword,
                      // Logic kiểm tra mật khẩu
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu'; // Thông báo lỗi
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải hơn 6 ký tự'; // Ví dụ thêm logic
                        }
                        return null; // Hợp lệ
                      },
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          // 4. Kích hoạt kiểm tra khi bấm nút
                          if (_formKey.currentState!.validate()) {
                            // Nếu tất cả validator đều trả về null (hợp lệ)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Đăng nhập thành công: ${_userController.text}',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Tại đây bạn có thể gọi API hoặc chuyển màn hình
                          }
                        },
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Demo điền nhanh dữ liệu
                            _userController.text = "admin";
                            _passController.text = "123456";
                          },
                          child: const Text(
                            'Demo creds',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
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
}
