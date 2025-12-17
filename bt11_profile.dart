import 'package:flutter/material.dart';
import 'package:bttonghopgk/services/bt11_auth_service.dart';

class BT11Profile extends StatefulWidget {
  final String token;
  const BT11Profile({super.key, required this.token});

  @override
  State<BT11Profile> createState() => _BT11ProfileState();
}

class _BT11ProfileState extends State<BT11Profile> {
  Map? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    setState(() => loading = true);
    final data = await AuthService.getProfile(widget.token);
    setState(() {
      user = data;
      loading = false;
    });
  }

  String _addressString(Map? address) {
    if (address == null) return '';
    final parts = <String>[];
    if (address['address'] != null) parts.add(address['address']);
    if (address['city'] != null) parts.add(address['city']);
    return parts.join(', ');
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '-',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ cá nhân')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? const Center(child: Text('Lỗi tải thông tin user'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: NetworkImage(user!['image'] ?? ''),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${user!['firstName']} ${user!['lastName']}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@${user!['username']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _infoRow('Email', user!['email']),
                          const Divider(),
                          _infoRow('Giới tính', user!['gender']),
                          const Divider(),
                          _infoRow('SĐT', user!['phone']),
                          const Divider(),
                          _infoRow('Tuổi', user!['age']?.toString()),
                          const Divider(),
                          _infoRow('Địa chỉ', _addressString(user!['address'])),
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
