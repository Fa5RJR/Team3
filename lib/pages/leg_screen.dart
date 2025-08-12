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
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1CB5A3),
        title: Text(
          widget.categoryTitle.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1CB5A3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: filterSearch,
                      decoration:  InputDecoration(
                        hintText: 'Search...'.tr(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1CB5A3),
                  ),
                  onPressed: () {
                    setState(() {
                      filteredItems.sort((a, b) => a.name.compareTo(b.name));
                    });
                  },
                  child:  Text("Sort by Name".tr(), style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF1CB5A3),
                  ),
                  onPressed: () {
                    setState(() {
                      filteredItems.sort((a, b) => a.priceRange.compareTo(b.priceRange));
                    });
                  },
                  child:  Text("Sort by Price".tr(), style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 10),


            Expanded(
              child: filteredItems.isEmpty
                  ?  Center(child: Text("No items found!".tr(), style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin:  EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.imagePath,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                           SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name.tr(), // ← ترجمة اسم العنصر
                                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(
                                  item.size.tr(), // ← ترجمة الحجم
                                  style:  TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  item.priceRange.tr(),
                                  style:  TextStyle(color: Colors.green),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 32,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1CB5A3),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => LegDetailsPage(item: item),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "View Details".tr(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.person, size: 40, color: Colors.teal),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.save, size: 40, color: Colors.teal),
                  onPressed: () {},
                ),
                const SizedBox(width: 60),
                IconButton(
                  icon: Icon(Icons.settings, size: 40, color: Colors.teal),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.comment, size: 40, color: Colors.teal),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            top: -28,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.home,
                size: 34,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
      appBar: AppBar(
        title: Text(item.name.tr(), style:  TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1CB5A3),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(item.imagePath, height: 200),
            const SizedBox(height: 20),
            Text(
              item.description,
              style:  TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Price Range. ${item.priceRange}',
              style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1CB5A3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {

              },
              child:  Text("Buy Now".tr(), style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
