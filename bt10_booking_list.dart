// File: lib/screens/bt10_booking_list.dart
import 'package:flutter/material.dart';

class BT10BookingList extends StatelessWidget {
  const BT10BookingList({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu giả lập (Mock Data) giống trong hình
    final List<Map<String, dynamic>> places = [
      {
        'name': 'Địa điểm 1',
        'image':
            'https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'rating': 9.5,
        'reviewCount': 95,
        'location': 'Huế • Cách bạn 0.6 km',
        'room': '1 suite riêng tư: 1 giường',
        'price': 109,
        'isBreakfastIncluded': true,
      },
      {
        'name': 'Địa điểm 2',
        'image':
            'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Cầu Vàng
        'rating': 9.2,
        'reviewCount': 34,
        'location': 'Cư Chính • Cách bạn 0.9 km',
        'room': '1 phòng khách sạn: 1 giường',
        'price': 20,
        'isBreakfastIncluded': true,
      },
      {
        'name': 'Địa điểm 3',
        'image':
            'https://plus.unsplash.com/premium_photo-1675745329954-9639d3b74bbf?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Singapore
        'rating': 8.0,
        'reviewCount': 1,
        'location': 'Cư Chính • Cách bạn 1.3 km',
        'room': '1 biệt thự nguyên căn - 1.000 m²',
        'price': 285,
        'isBreakfastIncluded': true,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // 1. HEADER: Thanh tìm kiếm giả & Ngày tháng
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.orange,
                    width: 1.5,
                  ), // Viền cam
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.black54),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Xung quanh vị trí hiện tại',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '23 thg 10 - 24 thg 10',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            // 2. FILTER BAR: Sắp xếp, Lọc, Bản đồ
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.sort, size: 18, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        'Sắp xếp',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.filter_list, size: 18, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        'Lọc',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.map, size: 18, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        'Bản đồ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${places.length} chỗ nghỉ',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 3. DANH SÁCH (LIST VIEW)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final item = places[index];
                  return _buildBookingCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CỘT TRÁI: ẢNH + BADGE
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['image'],
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        width: 110,
                        height: 110,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  if (item['isBreakfastIncluded'])
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Bao bữa sáng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),

              // CỘT PHẢI: THÔNG TIN CHI TIẾT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Hàng 1: Tên + Icon tim
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Hàng 2: Rating
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item['rating'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Xuất sắc',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '• ${item['reviewCount']} đánh giá',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Hàng 3: Địa chỉ
                    Text(
                      item['location'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),

                    // Hàng 4: Loại phòng
                    Text(
                      item['room'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Hàng 5: Giá tiền
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'US\$${item['price']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            'Đã bao gồm thuế và phí',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
