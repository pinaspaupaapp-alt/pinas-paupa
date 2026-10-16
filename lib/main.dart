import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: PinasPaupaApp(), debugShowCheckedModeBanner: false));

class PinasPaupaApp extends StatefulWidget {
  @override
  State<PinasPaupaApp> createState() => _PinasPaupaAppState();
}

class _PinasPaupaAppState extends State<PinasPaupaApp> {
  List<Map<String, dynamic>> properties = [
    {'title':'Modern Apartment Davao','location':'Davao City','price':15000,'image':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','phone':'09123456789','cat':'House Rent'},
  ];
  String myGcash="09123456789"; String myGoTyme="019812345678"; String myMaya="09123456789"; String myBank="GoTyme Bank";
  String search="";
  
  void addProperty(Map<String, dynamic> p){ setState(()=>properties.insert(0,p)); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF2F8),
      appBar: AppBar(title: Text('Pinas Paupa 🇵🇭', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Color(0xFF2E7D32), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            // SEARCH BAR - GWAPO
            Container(margin: EdgeInsets.all(15), padding: EdgeInsets.symmetric(horizontal:15), decoration: BoxDecoration(color: Color(0xFF2E7D32), borderRadius: BorderRadius.circular(15)), child: TextField(onChanged:(v)=>setState(()=>search=v), style: TextStyle(color: Colors.white), decoration: InputDecoration(icon: Icon(Icons.search, color: Colors.white), hintText: 'Search Airbnb, House, Lot, Services...', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none))),
            
            Padding(padding: EdgeInsets.symmetric(horizontal:15), child: Text('Pangitaon?', style: TextStyle(fontSize:22, fontWeight: FontWeight.bold))),
            SizedBox(height:10),
            // CATEGORIES - GWAPO NGA DAAN
            Padding(padding: EdgeInsets.symmetric(horizontal:10), child: GridView.count(crossAxisCount:2, shrinkWrap:true, physics: NeverScrollableScrollPhysics(), childAspectRatio:2.5, children:[
              _catCard(Icons.home, 'Airbnb', Color(0xFFFFEBEE), Colors.red),
              _catCard(Icons.home_work, 'House Rent', Color(0xFFE8F5E9), Colors.green),
              _catCard(Icons.house, 'House Sale', Color(0xFFE3F2FD), Colors.blue),
              _catCard(Icons.terrain, 'Lot Rent', Color(0xFFFFF3E0), Colors.orange),
              _catCard(Icons.landscape, 'Lot Sale', Color(0xFFEFEBE9), Colors.brown),
              _catCard(Icons.car_rental, 'Rent Car', Color(0xFFF3E5F5), Colors.purple),
              _catCard(Icons.fastfood, 'Food', Color(0xFFFBE9E7), Colors.deepOrange),
              _catCard(Icons.build, 'Services', Color(0xFFE0F2F1), Colors.teal),
            ])),
            
            Padding(padding: EdgeInsets.all(15), child: Text('Popular Services', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.symmetric(horizontal:15), child: GridView.count(crossAxisCount:4, shrinkWrap:true, physics: NeverScrollableScrollPhysics(), children:[
              _service(Icons.ac_unit, 'Aircon'), _service(Icons.cleaning_services, 'Cleaning'), _service(Icons.plumbing, 'Tubero'), _service(Icons.handyman, 'Renovation'),
              _service(Icons.electrical_services, 'Electrical'), _service(Icons.directions_bus, 'Mechanic'), _service(Icons.spa, 'Manicure'), _service(Icons.self_improvement, 'Massage'),
            ])),
            
            Padding(padding: EdgeInsets.all(15), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text('Available Now - Maka Kwarta!', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)), Text('Commission 15% -> ${myGoTyme}', style: TextStyle(fontSize:11, color: Colors.green))])),

            // LISTINGS - NA-APIL ANG PICTURE - FIX NA DILI NA PANGIT
            ...properties.where((p)=>search.isEmpty || p['title'].toLowerCase().contains(search.toLowerCase())).map((p){
              int comm=(p['price']*0.15).toInt();
              return Card(margin: EdgeInsets.symmetric(horizontal:15, vertical:8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), elevation:3, child: Column(children:[
                ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(15)), child: Image.network(p['image'], height:200, width:double.infinity, fit: BoxFit.cover, errorBuilder:(c,e,s)=>Container(height:200, color: Colors.grey.shade300, child: Icon(Icons.image, size:50)))),
                ListTile(title: Text(p['title'], style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('${p['location']} • ${p['cat']} - ₱${p['price']}/mo\nImong Kita: ₱$comm (15%) -> ${myGoTyme}/${myGcash}')),
                Padding(padding: EdgeInsets.symmetric(horizontal:10, vertical:5), child: Row(children:[
                  Expanded(child: OutlinedButton.icon(icon: Icon(Icons.message), label: Text('Message'), onPressed: ()=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Maka-message tinuod: ${p['phone']} via WhatsApp!'))))),
                  SizedBox(width:10),
                  Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: ()=>showModalBottomSheet(context:context, builder:(_)=>PaymentSheet(price:p['price'], comm:comm, myGoTyme:myGoTyme, myGcash:myGcash, myBank:myBank)), child: Text('Book & Pay'))),
                ])),
                SizedBox(height:5),
              ]));
            }).toList(),
            SizedBox(height:100),
          ],
        ),
      ),
      floatingActionButton: Column(mainAxisSize:MainAxisSize.min, children:[
        FloatingActionButton.extended(heroTag:'bank', backgroundColor: Colors.green, icon: Icon(Icons.wallet), label: Text('Akong GoTyme/GCash/Bank'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>PayoutPage(onSave:(a,b,c,d){setState((){myGcash=a; myGoTyme=b; myMaya=c; myBank=d;});})))),
        SizedBox(height:10),
        FloatingActionButton.extended(heroTag:'post', backgroundColor: Color(0xFFFF6B00), icon: Icon(Icons.add_a_photo), label: Text('MAG POST + PICTURE'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>PostPage(onPost: addProperty)))),
      ]),
    );
  }

  Widget _catCard(IconData icon, String title, Color bg, Color ic){
    return Container(margin: EdgeInsets.all(5), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: ic.withOpacity(0.3))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children:[Icon(icon, color: ic), SizedBox(width:8), Text(title, style: TextStyle(fontWeight: FontWeight.bold))] ));
  }
  Widget _service(IconData icon, String name){
    return Column(children:[CircleAvatar(backgroundColor: Colors.white, radius:30, child: Icon(icon, color: Colors.teal)), SizedBox(height:5), Text(name, style: TextStyle(fontSize:12))]);
  }
}

class PostPage extends StatefulWidget{
  final Function(Map<String,dynamic>) onPost; PostPage({required this.onPost});
  @override
  State<PostPage> createState()=>_PostPageState();
}
class _PostPageState extends State<PostPage>{
  var title=TextEditingController(); var price=TextEditingController(); var loc=TextEditingController(text:'Davao City'); var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'); var phone=TextEditingController(text:'09123456789'); String cat='House Rent';
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Mag Post + Picture')), body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
      DropdownButton<String>(value: cat, isExpanded:true, items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged:(v)=>setState(()=>cat=v!)),
      TextField(controller:title, decoration: InputDecoration(labelText:'Title', border: OutlineInputBorder())),
      SizedBox(height:10),
      TextField(controller:price, decoration: InputDecoration(labelText:'Price', border: OutlineInputBorder()), keyboardType: TextInputType.number),
      SizedBox(height:10),
      TextField(controller:loc, decoration: InputDecoration(labelText:'Location', border: OutlineInputBorder())),
      SizedBox(height:10),
      TextField(controller:img, decoration: InputDecoration(labelText:'Picture URL - Paste link sa picture!', border: OutlineInputBorder())),
      Text('Tip: Google -> search house -> long press image -> copy image address -> paste diri!', style: TextStyle(fontSize:11)),
      SizedBox(height:10),
      TextField(controller:phone, decoration: InputDecoration(labelText:'Phone for Message', border: OutlineInputBorder())),
      SizedBox(height:20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00), padding: EdgeInsets.all(15)), onPressed: (){widget.onPost({'title':title.text,'price':int.tryParse(price.text)??15000,'location':loc.text,'image':img.text,'phone':phone.text,'cat':cat}); Navigator.pop(context);}, child: Text('I-POST NA!')),
    ])));
  }
}

class PaymentSheet extends StatefulWidget{
  final int price, comm; final String myGoTyme, myGcash, myBank;
  PaymentSheet({required this.price, required this.comm, required this.myGoTyme, required this.myGcash, required this.myBank});
  @override
  State<PaymentSheet> createState()=>_PaymentSheetState();
}
class _PaymentSheetState extends State<PaymentSheet>{
  String sel='GCash';
  List<String> all=['GCash','Maya','GoTyme','GoTyme Bank','GrabPay','ShopeePay','SeaBank','BPI','BDO','Metrobank','UnionBank','Landbank','RCBC','Security Bank','China Bank','PNB','CIMB','Tonik','QR PH','Visa/Mastercard'];
  @override
  Widget build(BuildContext context){
    return Container(padding:EdgeInsets.all(20), height:480, child: Column(children:[
      Text('Bayad - TANAN BANK SA PINAS!', style: TextStyle(fontWeight: FontWeight.bold)),
      Container(padding:EdgeInsets.all(8), color: Colors.green.shade50, child: Text('Total ₱${widget.price} - Commission ₱${widget.comm}\nMusulod sa: GoTyme:${widget.myGoTyme} / GCash:${widget.myGcash}', style: TextStyle(color:Colors.green, fontSize:12))),
      SizedBox(height:10),
      Expanded(child: SingleChildScrollView(child: Wrap(spacing:5, children: all.map((m)=>ChoiceChip(label:Text(m,style:TextStyle(fontSize:11)), selected: sel==m, onSelected:(v)=>setState(()=>sel=m))).toList()))),
      SizedBox(width:double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: (){Navigator.pop(context); showDialog(context:context, builder:(_)=>AlertDialog(title:Text('✅ BAYAD NA!'), content: Text('Via $sel ₱${widget.price}\nCommission ₱${widget.comm} -> ${widget.myGoTyme}/${widget.myGcash}/${widget.myBank} sulod na!')));}, child: Text('BAYARAN ₱${widget.price} via $sel'))),
    ]));
  }
}

class PayoutPage extends StatefulWidget{
  final Function(String,String,String,String) onSave; PayoutPage({required this.onSave});
  @override
  State<PayoutPage> createState()=>_PayoutPageState();
}
class _PayoutPageState extends State<PayoutPage>{
  var gcash=TextEditingController(text:'09123456789'); var gotyme=TextEditingController(text:'019812345678'); var maya=TextEditingController(text:'09123456789'); var bank=TextEditingController(text:'GoTyme Bank - Juan Dela Cruz');
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Akong Commission Asa Musulod?')), body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
      Text('Dinhi mu sulod imong 15% kada booking!', style: TextStyle(fontWeight: FontWeight.bold)),
      TextField(controller:gcash, decoration: InputDecoration(labelText:'GCash Number', border: OutlineInputBorder())),
      SizedBox(height:10),
      TextField(controller:gotyme, decoration: InputDecoration(labelText:'GoTyme Number/Account', border: OutlineInputBorder())),
      SizedBox(height:10),
      TextField(controller:maya, decoration: InputDecoration(labelText:'Maya Number', border: OutlineInputBorder())),
      SizedBox(height:10),
      TextField(controller:bank, decoration: InputDecoration(labelText:'Bank - BPI/BDO/GoTyme/Metrobank/UnionBank etc - TANAN!', border: OutlineInputBorder())),
      SizedBox(height:20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)), onPressed: (){widget.onSave(gcash.text, gotyme.text, maya.text, bank.text); Navigator.pop(context);}, child: Text('I-SAVE - DIRI NA TANAN KWARTA!')),
    ])));
  }
}
