import 'package:flutter/material.dart';

class Pertemuan2 extends StatefulWidget {
  const Pertemuan2({super.key});

  @override
  State<Pertemuan2> createState() => _Pertemuan2State();
}

class _Pertemuan2State extends State<Pertemuan2> {
  String selectedFilter = 'Semua';
  int selectedNavIndex = 0;
  final PageController _pageController = PageController();
  int _currentBanner = 0;

  final List<Map<String, String>> banners = [
    {
      'title': 'New Collection',
      'subtitle': 'Discount 50% for the first transaction',
    },
    {'title': 'Summer Sale', 'subtitle': 'Buy 1 Get 1 Free for selected items'},
    {'title': 'Member Deal', 'subtitle': 'Extra 10% for registered users'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            _buildTopBar(),
            _buildSearchBar(),
            _buildBannerCarousel(),
            const SizedBox(height: 20),
            _buildCategoryRow(),
            const SizedBox(height: 20),
            _buildFlashSaleHeader(),
            const SizedBox(height: 10),
            _buildFilterButtons(),
            const SizedBox(height: 10),
            _buildProductGrid(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.location_on, color: Colors.brown),
              SizedBox(width: 5),
              Text(
                'Semarang, Jawa Tengah',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifikasi ditekan')),
              );
            },
            child: const Icon(Icons.notifications_none, color: Colors.brown),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.brown.shade100),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.brown,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) => setState(() => _currentBanner = index),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.brown.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      banner['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(banner['subtitle']!),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Shop Now clicked')),
                        );
                      },
                      child: const Text('Shop Now'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _currentBanner == index
                        ? Colors.brown
                        : Colors.brown.shade200,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCategoryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('See All', style: TextStyle(color: Colors.brown)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Column(
                children: [Icon(Icons.checkroom, size: 40), Text('T-Shirt')],
              ),
              Column(
                children: [Icon(Icons.accessibility, size: 40), Text('Pant')],
              ),
              Column(
                children: [Icon(Icons.dry_cleaning, size: 40), Text('Dress')],
              ),
              Column(
                children: [Icon(Icons.shopping_bag, size: 40), Text('Jacket')],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Flash Sale',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: const [
              Text('Closing in : '),
              Text('02', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(' : '),
              Text('12', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(' : '),
              Text('56', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterButton('Semua'),
            const SizedBox(width: 8),
            _buildFilterButton('Terbaru'),
            const SizedBox(width: 8),
            _buildFilterButton('Popular'),
            const SizedBox(width: 8),
            _buildFilterButton('Termurah'),
            const SizedBox(width: 8),
            _buildFilterButton('Termahal'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
        children: List.generate(4, (index) => _buildProductCard(index)),
      ),
    );
  }

  Widget _buildProductCard(int index) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Klik produk ${index + 1}')));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                height: 140,
                width: double.infinity,
                color: Colors.brown.shade100,
                child: const Icon(Icons.image, size: 50, color: Colors.brown),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Brown Jacket',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      SizedBox(width: 4),
                      Text(
                        '4.9',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$83.97',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            final icons = [
              Icons.home,
              Icons.local_offer,
              Icons.favorite_border,
              Icons.message_outlined,
              Icons.person_outline,
            ];
            return IconButton(
              icon: Icon(
                icons[index],
                color: selectedNavIndex == index ? Colors.white : Colors.grey,
              ),
              onPressed: () => setState(() => selectedNavIndex = index),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final bool isSelected = selectedFilter == label;
    return ElevatedButton(
      onPressed: () => setState(() => selectedFilter = label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.brown : Colors.brown.shade100,
        foregroundColor: isSelected ? Colors.white : Colors.brown,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
      child: Text(label),
    );
  }
}
