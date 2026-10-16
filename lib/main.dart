import 'package:flutter/material.dart';
void main() => runApp(PinasPaupaApp());
class PinasPaupaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainHome());
  }
}
class MainHome extends StatelessWidget {
  final cats = [
    {'t':'Airbnb','i':Icons.home,'c':Color(0xFFE53935),'l':Color(0xFFFFEBEE)},
    {'t':'House Rent','i':Icons.house,'c':Color(0xFF2E7D32),'l':Color(0xFFE8F5E9)},
    {'t':'House Sale','i':Icons.home_work,'c':Color(0xFF1565C0),'l':Color(0xFFE3F2FD)},
    {'t':'Lot Rent','i':Icons.landscape,'c':Color(0xFFEF6C00),'l':Color(0xFFFFF3E0)},
    {'t':'Lot Sale','i':Icons.terrain,'c':Color(0xFF6D4C41),'l':Color(0xFFEFEBE9)},
    {'t':'Rent Car','i':Icons.car_rental,'c':Color(0xFF6A1B9A),'l':Color(0xFFF3E5F5)},
    {'t':'Food','i':Icons.fastfood,'c':Color(0xFFFF3D00),'l':Color(0xFFFBE9E7)},
    {'t':'Services','i':Icons.handyman,'c':Color(0xFF00897B),'l':Color(0xFFE0F2F1)},
  ];
  final servs = [
    {'t':'Aircon','i':Icons.ac_unit,'c':Color(0xFF03A9F4)},
    {'t':'Cleaning','i':Icons.cleaning_services,'c':Color(0xFF00ACC1)},
    {'t':'Tubero','i':Icons.plumbing,'c':Color(0xFFFF6F00)},
    {'t':'Renovation','i':Icons.construction,'c':Color(0xFF5D4037)},
    {'t':'Electrical','i':Icons.electrical_services,'c':Color(0xFFFFB300)},
    {'t':'Mechanic','i':Icons.car_repair,'c':Color(0xFF424242)},
    {'t':'Manicure','i':Icons.spa,'c':Color(0xFFEC407A)},
    {'t':'Massage','i':Icons.self_improvement,'c':Color(0xFFAB47BC)},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pinas Paupa 🇵🇭'), backgroundColor: Color(0xFF2E7D32)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Color(0xFF2E7D32), borderRadius: BorderRadius.circular(12)), child: Row(children: [Icon(Icons.search, color: Colors.white), SizedBox(width: 10), Text('Search Airbnb, House, Lot, Services...', style: TextStyle(color: Colors.white70))])),
          SizedBox(height: 16),
          Text('Pangitaon?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          GridView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: cats.length, itemBuilder: (ctx, i) {
            var c = cats[i];
            return InkWell(onTap: () { if (c['t'] == 'Services') { Navigator.push(context, MaterialPageRoute(builder: (_) => ServPage(s: servs))); } else { Navigator.push(context, MaterialPageRoute(builder: (_) => ListPage(title: c['t'] as String, color: c['c'] as Color))); } }, child: Container(decoration: BoxDecoration(color: c['l'] as Color, borderRadius: BorderRadius.circular(12), border: Border.all(color: c['c'] as Color)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(c['i'] as IconData, color: c['c'] as Color), SizedBox(width: 8), Text(c['t'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))])));}),
          SizedBox(height: 20),
          Text('Popular Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          GridView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.9, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: servs.length, itemBuilder: (ctx, i) {
            var s = servs[i];
            return InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListPage(title: s['t'] as String, color: s['c'] as Color))), child: Column(children: [CircleAvatar(backgroundColor: (s['c'] as Color).withOpacity(0.15), radius: 28, child: Icon(s['i'] as IconData, color: s['c'] as Color)), SizedBox(height: 4), Text(s['t'] as String, textAlign: TextAlign.center, style: TextStyle(fontSize: 11))]));
          }),
        ]),
      ),
    );
  }
}
class ListPage extends StatelessWidget {
  final String title; final Color color;
  ListPage({required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title), backgroundColor: color), body: ListView.builder(itemCount: 6, itemBuilder: (ctx, i) { return Card(margin: EdgeInsets.all(8), child: ListTile(leading: Icon(Icons.image, size: 40, color: color), title: Text('$title #${i+1}'), subtitle: Text('Tizimin - P${(i+1)*1500}/mo'), trailing: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Color(0xFFFF6F00), borderRadius: BorderRadius.circular(6)), child: Text('BOOK', style: TextStyle(color: Colors.white, fontSize: 10))), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(title: '$title #${i+1}', color: color))))); }), floatingActionButton: FloatingActionButton(backgroundColor: color, onPressed: () {}, child: Icon(Icons.add)));
  }
}
class ServPage extends StatelessWidget {
  final List s; ServPage({required this.s});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('All Services'), backgroundColor: Color(0xFF00897B)), body: GridView.builder(padding: EdgeInsets.all(12), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: s.length, itemBuilder: (ctx, i) { var v = s[i]; return InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListPage(title: v['t'] as String, color: v['c'] as Color))), child: Card(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(v['i'] as IconData, size: 40, color: v['c'] as Color), SizedBox(height: 8), Text(v['t'] as String, style: TextStyle(fontWeight: FontWeight.bold))]))); }));
  }
}
class DetailPage extends StatelessWidget {
  final String title; final Color color;
  DetailPage({required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title), backgroundColor: color), body: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(height: 180, color: color.withOpacity(0.2), child: Center(child: Icon(Icons.image, size: 80, color: color))), SizedBox(height: 12), Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), Text('Owner: Juan - 09123456789'), SizedBox(height: 20), Row(children: [Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: BorderSide(color: color)), onPressed: () {}, child: Text('Message', style: TextStyle(color: color)))), SizedBox(width: 10), Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6F00)), onPressed: () {}, child: Text('Book Now', style: TextStyle(color: Colors.white))))])])));
  }
}
