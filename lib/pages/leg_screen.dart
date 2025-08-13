import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryPage(categoryTitle: 'Leg'.tr(),
    )
    );
  }
}

class LegItem {
  final String imagePath;
  final String name;
  final String size;
  final String description;
  final String priceRange;

  LegItem({
    required this.imagePath,
    required this.name,
    required this.size,
    required this.description,
    required this.priceRange,
  });
}

class CategoryPage extends StatefulWidget {
  final String categoryTitle;

   CategoryPage({super.key, required this.categoryTitle});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController searchController = TextEditingController();

  final List<LegItem> allItems = [
    LegItem(
      imagePath: 'assets/images/leg1.jpg',
      name: 'Bionic Leg',
      size: 'Large',
      description: 'Advanced leg with sensors and mobility support.'
      ,
      priceRange: '150\$ - 300\$',
    ),
    LegItem(
      imagePath: 'assets/images/leg2.jpg',
      name: 'Waterproof Leg',
      size: 'Medium',
      description: 'Perfect for swimming and wet conditions.',
      priceRange: '200\$ - 350\$',
    ),
    LegItem(
      imagePath: 'assets/images/leg3.jpg',
      name: 'Carbon Fiber Leg',
      size: 'Small',
      description: 'Lightweight and strong, ideal for athletes.',
      priceRange: '250\$ - 400\$',
    ),
    LegItem(
      imagePath: 'assets/images/leg4.jpg',
      name: 'Waterproof Leg',
      size: 'Large',
      description: 'Lightweight and strong, ideal for athletes.',
      priceRange: '180\$ - 320\$',
    ),
    LegItem(
      imagePath: 'assets/images/leg5.jpg',
      name: 'Carbon Fiber Leg',
      size: 'Small',
      description: 'Lightweight and strong, ideal for athletes.',
      priceRange: '220\$ - 370\$',
    ),
  ];

  List<LegItem> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void filterSearch(String query) {
    final lowerQuery = query.toLowerCase();

     final results = allItems.where((item) {
      final name = item.name.tr().toLowerCase();
      final size = item.size.tr().toLowerCase();
      final description = item.description.tr().toLowerCase();

      return name.contains(lowerQuery) ||
          size.contains(lowerQuery) ||
          description.contains(lowerQuery);
    }).toList();

    setState(() {
      filteredItems = results;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0A2152)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          widget.categoryTitle.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF0A2152),
            fontSize: 24,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: Color(0xFF0A2152)),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterSearch,
                    decoration: InputDecoration(
                      hintText: 'Search products...'.tr(),
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Sort Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildSortButton(
                        'Sort by Name'.tr(),
                        Icons.sort_by_alpha,
                        () {
                          setState(() {
                            filteredItems.sort((a, b) => a.name.compareTo(b.name));
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSortButton(
                        'Sort by Price'.tr(),
                        Icons.attach_money,
                        () {
                          setState(() {
                            filteredItems.sort((a, b) => a.priceRange.compareTo(b.priceRange));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Products List
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No items found!".tr(),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return _buildProductCard(item, context);
                    },
                  ),
          ),
          
          // Bottom Navigation
          _buildBottomNavigation(context),
        ],
      ),
    );
  }
  
  Widget _buildSortButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
  
  Widget _buildProductCard(LegItem item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.teal.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2152),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.size.tr(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.priceRange.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LegDetailsPage(item: item),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "View Details".tr(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                onTap: () => Navigator.pushNamed(context, "/Sign in"),
              ),
              _buildNavItem(
                icon: Icons.info_outline_rounded,
                label: 'About',
                onTap: () => Navigator.pushNamed(context, '/aboutus'),
              ),
              _buildNavItem(
                icon: Icons.email_outlined,
                label: 'Contact',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LegDetailsPage extends StatelessWidget {
  final LegItem item;

  const LegDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0A2152)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          item.name.tr(),
          style: const TextStyle(
            color: Color(0xFF0A2152),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Product Details
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name.tr(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0A2152),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.size.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2152),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        'Price Range: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        item.priceRange,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Buy Now Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Buy Now".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
