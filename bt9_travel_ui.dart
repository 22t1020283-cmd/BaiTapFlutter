// File: lib/screens/bt9_travel_ui.dart
import 'package:flutter/material.dart';

class BT9TravelUI extends StatelessWidget {
  const BT9TravelUI({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách ảnh mẫu (bạn có thể thay bằng link khác)
    final List<String> imagePaths = [
      'https://plus.unsplash.com/premium_photo-1719955781545-c60219441bfc?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Vịnh Hạ Long
      'https://images.unsplash.com/photo-1741138327956-dfa75763b50d?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Cầu Vàng Đà Nẵng
      'https://plus.unsplash.com/premium_photo-1697729432930-3f11644e9184?q=80&w=1469&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Singapore Merlion
      'https://plus.unsplash.com/premium_photo-1661962643046-198516c2bec0?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Núi Phú Sĩ Nhật Bản
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // Sử dụng SafeArea để tránh bị tai thỏ che mất nội dung
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Phần Header: Welcome và Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(221, 172, 26, 26),
                        ),
                      ),
                      Text(
                        'Charlie',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(221, 172, 26, 26),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none, size: 28),
                        color: Colors.black54,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings_outlined, size: 28),
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Thanh tìm kiếm (Search Bar)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. Tiêu đề "Saved Places"
              const Text(
                'Saved Places',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // 4. Lưới hình ảnh (2 hàng, 2 cột)
              Column(
                children: [
                  // Hàng 1
                  Row(
                    children: [
                      _buildImageCard(imagePaths[0]),
                      const SizedBox(width: 20),
                      _buildImageCard(imagePaths[1]),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Hàng 2
                  Row(
                    children: [
                      _buildImageCard(imagePaths[2]),
                      const SizedBox(width: 20),
                      _buildImageCard(imagePaths[3]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget con để xây dựng từng thẻ hình ảnh
  Widget _buildImageCard(String imageUrl) {
    return Expanded(
      child: Container(
        height: 120, // Chiều cao cố định cho ảnh
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        // ClipRRect để bo tròn góc ảnh
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover, // Ảnh phủ kín khung
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey.shade200,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
