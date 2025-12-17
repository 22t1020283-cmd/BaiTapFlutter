import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'bt8_news_detail_view.dart';

const String _apiKey = '07355ed029d84f41b8e63b81e9e74b93';

class BT8NewsList extends StatefulWidget {
  const BT8NewsList({super.key});

  @override
  State<BT8NewsList> createState() => _BT8NewsListState();
}

class _BT8NewsListState extends State<BT8NewsList> {
  final Dio _dio = Dio();
  List<dynamic> _articles = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Gọi API lấy tin tức công nghệ
      final url =
          'https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=$_apiKey';
      final resp = await _dio.get(url);

      if (resp.statusCode == 200 && resp.data['articles'] != null) {
        setState(() {
          _articles = resp.data['articles'];
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body hiển thị danh sách
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Lỗi: $_error'))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                final article = _articles[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: SizedBox(
                      width: 80,
                      height: 80,
                      child: article['urlToImage'] != null
                          ? Image.network(
                              article['urlToImage'],
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image),
                    ),
                    title: Text(
                      article['title'] ?? 'No Title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(article['publishedAt'] ?? ''),
                    onTap: () {
                      // QUAN TRỌNG: Chuyển sang màn hình chi tiết của BT8
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BT8NewsDetailView(article: article),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
