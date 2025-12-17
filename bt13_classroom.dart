import 'package:flutter/material.dart';

class BT13Classroom extends StatelessWidget {
  const BT13Classroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar phía trên cùng
      appBar: AppBar(
        title: const Text('Hoang Mạc'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView(
        children: [
          // 1. Hình ảnh tiêu đề
          Image.network(
            'https://images.unsplash.com/photo-1529655683826-aba9b3e77383?q=80&w=1000&auto=format&fit=crop',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),

          // 2. Phần Title (Tên địa danh và Rating)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hoang mạc Sahara',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Phía Bắc Châu phi',
                        style: TextStyle(color: Colors.grey[500], fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.star, color: Colors.red),
                const Text('41'),
              ],
            ),
          ),

          // 3. Phần Buttons (Call, Router, Share)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
              _buildButtonColumn(Colors.blue, Icons.near_me, 'Router'),
              _buildButtonColumn(Colors.blue, Icons.share, 'Share'),
            ],
          ),

          // 4. Phần Text mô tả
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Tháp đồng hồ là một loại công trình cụ thể chứa đồng hồ tháp pháo và có một hoặc nhiều mặt đồng hồ trên các bức tường bên ngoài phía trên. '
              'Nhiều tháp đồng hồ là các cấu trúc độc lập nhưng chúng cũng có thể liền kề hoặc nằm trên đỉnh của một tòa nhà khác. '
              'Tháp đồng hồ là một cảnh tượng phổ biến ở nhiều nơi trên thế giới với một số tòa nhà mang tính biểu tượng. '
              'Một ví dụ là tháp Elizabeth ở Luân Đôn (thường được gọi là Big Ben, mặc dù đúng ra tên này chỉ thuộc về tiếng chuông bên trong tòa tháp).',
              textAlign: TextAlign.justify,
              style: TextStyle(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo từng cột nút bấm
  Widget _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}