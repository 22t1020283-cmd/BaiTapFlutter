import 'package:flutter/material.dart';

import 'bt7_shop_api..dart';
import 'bt7_shop_model.dart'; // Đảm bảo tên file Model đúng (hoặc myproduct.dart tùy tên bạn đặt)

class BT7Shop extends StatefulWidget {
  const BT7Shop({super.key});

  @override
  State<BT7Shop> createState() => _BT7ShopState();
}

class _BT7ShopState extends State<BT7Shop> {
  List<Product> _allProducts = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final products = await Api().getAllProducts();
      final cats = <String>{};
      for (var p in products) {
        cats.add(p.category);
      }
      setState(() {
        _allProducts = products;
        _categories = ['All', ...cats.toList()..sort()];
        _selectedCategory = 'All';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  List<Product> get _filteredProducts {
    return _allProducts.where((p) {
      final matchesCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Product Store',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Error: $_error'))
          : Column(
              children: [
                _buildSearchAndFilter(),
                Expanded(
                  child: _filteredProducts.isEmpty
                      ? const Center(child: Text('Không có sản phẩm'))
                      : GridView.builder(
                          padding: const EdgeInsets.all(12),
                          // SỬA 1: Dùng MaxCrossAxisExtent thay vì FixedCrossAxisCount
                          // Giúp thẻ không bị quá to trên Web, tự động chia nhiều cột
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    220, // Độ rộng tối đa của 1 thẻ
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio:
                                    0.68, // Tỉ lệ chiều cao/rộng hợp lý hơn
                              ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) =>
                              _buildProductCard(_filteredProducts[index]),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Tìm sản phẩm...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categories.map((c) {
                final bool selected = c == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = c),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? Colors.deepPurple : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: Center(
                      child: Text(
                        c.toUpperCase(),
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.deepPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần hình ảnh
          Expanded(
            flex: 3, // Hình ảnh chiếm 3 phần không gian
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                12,
              ), // Thêm padding để ảnh không sát lề
              child: Image.network(
                p.image,
                fit: BoxFit
                    .contain, // SỬA 2: Dùng contain để hiển thị trọn vẹn sản phẩm
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
          ),
          // Phần thông tin
          Expanded(
            flex: 2, // Thông tin chiếm 2 phần
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Căn đều trên dưới
                children: [
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${p.price}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          Text(
                            ' ${p.rate} (${p.count})',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
