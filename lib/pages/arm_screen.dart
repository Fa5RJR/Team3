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
      home: ArmPage(categoryTitle: 'Arm'.tr()
      ),
    );
  }
}

class ArmItem {
  final String imagePath;
  final String name;
  final String size;
  final String description;
  final String priceRange;

  ArmItem({
    required this.imagePath,
    required this.name,
    required this.size,
    required this.description,
    required this.priceRange,
  });
}

class ArmPage extends StatefulWidget {
  final String categoryTitle;

  const ArmPage({super.key, required this.categoryTitle});

  @override
  State<ArmPage> createState() => _ArmPageState();
}

class _ArmPageState extends State<ArmPage> {
  TextEditingController searchController = TextEditingController();

  final List<ArmItem> allItems = [
    ArmItem(
      imagePath: 'assets/images/arm4.jpg',
      name: 'Basic Arm',
      size: 'Large',
      description: 'Standard prosthetic arm for everyday use.',
      priceRange: '1000\$ - 1500\$',
    ),
    ArmItem(
      imagePath: 'assets/images/arm2.jpg',
      name: 'Bionic Arm',
      size: 'Large',
      description: 'Advanced bionic arm with sensor control.',
      priceRange: '2000\$ - 2500\$',
    ),
    ArmItem(
      imagePath: 'assets/images/arm3.jpg',
      name: 'Light Arm',
      size: 'Small',
      description: 'Lightweight arm, ideal for children.',
      priceRange: '800\$ - 1200\$',
    ),
    ArmItem(
      imagePath: 'assets/images/arm1.jpg',
      name: 'Basic Arm',
      size: 'Medium',
      description: 'Standard prosthetic arm for everyday use.',
      priceRange: '1100\$ - 1400\$',
    ),
  ];

  List<ArmItem> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void filterSearch(String query) {
    final results = allItems.where((item) {
      final lowerQuery = query.toLowerCase();
      return item.name.toLowerCase().contains(lowerQuery) ||
          item.size.toLowerCase().contains(lowerQuery) ||
          item.description.toLowerCase().contains(lowerQuery);
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
          style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                    backgroundColor: const Color(0xFF1CB5A3),
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
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
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
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name.tr(),
                                    style:  TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(item.size.tr(), style: TextStyle(color: Colors.grey)),
                                Text(item.priceRange.tr(),
                                    style:  TextStyle(color: Colors.green)),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 32,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1CB5A3),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ArmDetailsPage(item: item),
                                        ),
                                      );
                                    },
                                    child:  Text(
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
        bottomNavigationBar:Stack(
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
                    icon: Icon(Icons.home, size: 40, color: Colors.teal),
                    onPressed: () => Navigator.pushNamed(context, "/Sign in"),
                  ),
                  IconButton(
                    icon: Icon(Icons.info, size: 40, color: Colors.teal),
                    onPressed: () => Navigator.pushNamed(context, "/aboutus"),
                  ),
                  IconButton(
                    icon: Icon(Icons.person, size: 40, color: Colors.teal),
                    onPressed: () => Navigator.pushNamed(context, ""),
                  ),
                ],
              ),
            ),
          ],
        )

    );
  }
}

class ArmDetailsPage extends StatelessWidget {
  final ArmItem item;

  const ArmDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name.tr(), style: const TextStyle(color: Colors.white)),
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
              item.description.tr(),
              style:  TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Price Range: ${item.priceRange}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
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
