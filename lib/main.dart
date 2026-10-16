import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PinasPaupaApp());
}

class PinasPaupaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinas Paupa',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pinas Paupa - Philippines +63')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Pangitaon?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          // Categories
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _cat('Airbnb'), _cat('House Rent'), _cat('House Sale'),
                _cat('Lot Rent'), _cat('Services'),
              ],
            ),
          ),
          // Real Listings from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('properties').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                if (snapshot.data!.docs.isEmpty) return Center(child: Text('Wala pa y listing - Mag post na!'));
                
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(
                          doc['image'] ?? 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=200',
                          width: 60, height: 60, fit: BoxFit.cover,
                          errorBuilder: (c,e,s) => Icon(Icons.home, size: 60),
                        ),
                        title: Text(doc['title'] ?? 'Balay sa ${doc['location']}'),
                        subtitle: Text('${doc['location']} - ₱${doc['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.message, color: Colors.blue),
                              onPressed: () async {
                                final phone = doc['ownerPhone'] ?? '09123456789';
                                final url = 'https://wa.me/63${phone.substring(1)}?text=Hello, interested ko sa ${doc['title']}';
                                await launchUrl(Uri.parse(url));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.book_online, color: Colors.orange),
                              onPressed: () async {
                                await FirebaseFirestore.instance.collection('bookings').add({
                                  'propertyId': doc.id,
                                  'title': doc['title'],
                                  'price': doc['price'],
                                  'status': 'pending',
                                  'createdAt': FieldValue.serverTimestamp(),
                                  'commission': (doc['price'] is int ? doc['price'] * 0.1 : 1500),
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Booked! Commission ₱${(doc['price']*0.1).toInt()} imoha boss!'))
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PostPropertyPage())),
        label: Text('Mag Post ug Balay + Kwarta'),
        icon: Icon(Icons.add_a_photo),
      ),
    );
  }
  
  Widget _cat(String name) {
    return Container(
      width: 80, margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(12)),
      child: Center(child: Text(name, textAlign: TextAlign.center)),
    );
  }
}

class PostPropertyPage extends StatelessWidget {
  final _title = TextEditingController();
  final _price = TextEditingController();
  final _location = TextEditingController(text: 'Davao City, Philippines');
  final _image = TextEditingController(text: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mag Post - Maka Kwarta!')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _title, decoration: InputDecoration(labelText: 'Title (e.g. Modern Apartment Davao)')),
            TextField(controller: _price, decoration: InputDecoration(labelText: 'Price (e.g. 15000)'), keyboardType: TextInputType.number),
            TextField(controller: _location, decoration: InputDecoration(labelText: 'Location')),
            TextField(controller: _image, decoration: InputDecoration(labelText: 'Image URL')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('properties').add({
                  'title': _title.text,
                  'price': int.tryParse(_price.text) ?? 15000,
                  'location': _location.text,
                  'image': _image.text,
                  'ownerPhone': '09123456789',
                  'rating': 4.9,
                  'createdAt': FieldValue.serverTimestamp(),
                });
                Navigator.pop(context);
              },
              child: Text('I-POST NA - MAKA KWARTA NA!'),
            ),
          ],
        ),
      ),
    );
  }
}
