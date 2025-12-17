import 'package:flutter/material.dart';

class BT12SimpleUI extends StatelessWidget {
  const BT12SimpleUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thêm AppBar để biết đang ở bài nào
      appBar: AppBar(centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.end, // Căn phải giống code bạn gửi
        children: const [
          Center(
            child: Text(
              "Hello World",
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10), // Khoảng cách nhỏ
          Padding(
            padding: EdgeInsets.only(
              right: 20.0,
            ), // Căn lề phải một chút cho đẹp
            child: Icon(
              Icons.heart_broken,
              size: 40,
              color: Color.fromARGB(255, 153, 71, 99),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(
              "Chúng tôi là lớp LTDD-Nhóm 5", // Sửa chính tả Moblie -> Mobile
              style: TextStyle(
                color: Color.fromARGB(255, 51, 113, 164),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
