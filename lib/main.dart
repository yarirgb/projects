import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalunna Skincare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'Hydrating Face Cream',
      'price': 'RP 150.000',
      'imageUrl': 'images/serum1.jpg',
    },
    {
      'id': '2',
      'name': 'Anti-Aging Serum',
      'price': 'RP. 150.OOO',
      'imageUrl': 'images/serum2.jpg',
    },
    {
      'id': '3',
      'name': 'Moisturizer skintific',
      'price': 'RP 150.000',
      'imageUrl': 'images/moist1.jpg',
    },
    {
      'id': '4',
      'name': 'Facial Wash Garnier Man',
      'price': 'RP 200.000',
      'imageUrl': 'images/facewash1.jpg',
    },
    // Add more products here
  ];

  List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalluna Skincare'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cart: cart),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      product: products[index],
                      addToCart: addToCart,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadowColor: Colors.black.withOpacity(0.2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        products[index]['imageUrl'],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          products[index]['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${products[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function addToCart;

  ProductDetailScreen({required this.product, required this.addToCart});

  // Fungsi untuk membuka WhatsApp dengan pesan tertentu
  Future<void> launchWhatsApp(String productName, String price) async {
    final phone = '082387782684'; // Ganti dengan nomor WhatsApp yang sesuai
    final message =
        'Halo, saya ingin memesan produk: $productName, harga: $price.';
    final url = 'https://wa.me/$phone?text=${Uri.encodeFull(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        backgroundColor: const Color.fromARGB(255, 241, 108, 152),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  product['imageUrl'],
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              Text(
                product['name'],
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '\$${product['price']}',
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  addToCart(product);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add_shopping_cart),
                label: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 242, 139, 173), // Menggunakan backgroundColor
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  launchWhatsApp(product['name'], product['price'].toString());
                },
                label: Text('Order via WhatsApp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Menggunakan backgroundColor
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Your Cart'),
          backgroundColor: const Color.fromARGB(255, 245, 143, 177)),
      body: cart.isEmpty
          ? Center(
              child:
                  Text('No items in your cart', style: TextStyle(fontSize: 18)))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Image.network(
                              cart[index]['imageUrl'],
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(cart[index]['name']),
                            subtitle: Text('\$${cart[index]['price']}'),
                            trailing: Icon(Icons.remove_shopping_cart),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Open WhatsApp or checkout logic
                    },
                    child: Text('Proceed to Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.pinkAccent, // Menggunakan backgroundColor
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
