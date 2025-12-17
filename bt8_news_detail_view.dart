import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BT8NewsDetailView extends StatelessWidget {
  final Map<String, dynamic> article;

  const BT8NewsDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu an toàn
    final title = article['title'] ?? 'Không có tiêu đề';
    final image = article['urlToImage'];
    final content =
        article['content'] ?? article['description'] ?? 'Không có nội dung';
    final author = article['author'] ?? 'Sưu tầm';
    final url = article['url'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết tin tức')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      const Icon(Icons.broken_image, size: 50),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tác giả: $author',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 30),
            if (url.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (await canLaunchUrlString(url)) {
                      await launchUrlString(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  icon: const Icon(Icons.language),
                  label: const Text('Đọc bài gốc tại trình duyệt'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
