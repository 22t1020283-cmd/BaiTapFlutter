import 'package:flutter/material.dart';

class BT2Courses extends StatelessWidget {
  const BT2Courses({super.key});

  void _showCourseDetails(BuildContext context, Map<String, String> course) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Chi tiết môn học',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Tên môn:', course['title']!),
              const SizedBox(height: 12),
              _buildDetailRow('Mã môn:', course['code']!),
              const SizedBox(height: 12),
              _buildDetailRow('Số học viên:', course['students']!),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Đóng',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = [
      {
        'title': 'XML và ứng dụng - Nhóm 1',
        'code': '2025-2026.1.TIN4583.001',
        'students': '58 học viên',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.006',
        'students': '55 học viên',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.005',
        'students': '52 học viên',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.004',
        'students': '50 học viên',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.003',
        'students': '52 học viên',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course['code']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course['students']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () => _showCourseDetails(context, course),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
