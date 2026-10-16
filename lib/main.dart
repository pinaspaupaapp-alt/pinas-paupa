import 'package:flutter/material.dart';

void main() {
  runApp(PinasPaupaApp());
}

class PinasPaupaApp extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PinasPaupaHome());
  }
}

class PinasPaupaHome extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('Pinas Paupa'), backgroundColor: Colors.green[700], centerTitle: true),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.work, size: 100, color: Colors.green[700]),
          SizedBox(height: 20),
          Text('Pinas Paupa', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          Text('Libre APK - Success!'),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text('Searching Jobs...')));
              Navigator.push(c, MaterialPageRoute(builder: (_) => JobsPage()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
            child: Text('Search Jobs', style: TextStyle(color: Colors.white)),
          )
        ]),
      ),
    );
  }
}

class JobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('Jobs Found'), backgroundColor: Colors.green[700]),
      body: ListView(children: [
        ListTile(leading: Icon(Icons.work), title: Text('Construction Worker'), subtitle: Text('Manila - P800/day')),
        ListTile(leading: Icon(Icons.cleaning_services), title: Text('Kasambahay'), subtitle: Text('Cebu - P10k/month')),
        ListTile(leading: Icon(Icons.delivery_dining), title: Text('Rider'), subtitle: Text('Davao - P1k/day')),
        ListTile(leading: Icon(Icons.computer), title: Text('Data Entry'), subtitle: Text('Work From Home - P20k/month')),
      ]),
    );
  }
}
