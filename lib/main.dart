import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: PinasPaupaApp(), debugShowCheckedModeBanner: false));

class PinasPaupaApp extends StatefulWidget {
  @override
  State<PinasPaupaApp> createState() => _PinasPaupaAppState();
}

class _PinasPaupaAppState extends State<PinasPaupaApp> {
  List<Map<String, dynamic>> allProps = [
    {'title':'Modern Apartment Davao','location':'Davao City','price':15000,'image':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','cat':'House Rent'},
    {'title':'Beach Lot Samal','location':'Samal Island','price':5000,'image':'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800','cat':'Lot Rent'},
    {'title':'Airbnb Condo Makati','location':'Makati','price':3000,'image':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','cat':'Airbnb'},
  ];
  List<Map<String, dynamic>> filtered = [];
  String selectedCat = 'All';
  String myGcash="09123456789"; String myGoTyme="019812345678"; String myBank="GoTyme Bank";
  bool isRegistered = false;

  @override
  void initState(){ super.initState(); filtered = allProps; }

  void filterCat(String cat){
    setState((){
      selectedCat = cat;
      if(cat=='All') filtered = allProps;
      else filtered = allProps.where((p)=>p['cat']==cat).toList();
    });
  }

  void addProp(Map<String,dynamic> p){ setState((){ allProps.insert(0,p); filterCat(selectedCat); }); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF2F8),
      appBar: AppBar(title: Text('Pinas Paupa 🇵🇭', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Color(0xFF2E7D32)),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Container(margin: EdgeInsets.all(15), padding: EdgeInsets.symmetric(horizontal:15), decoration: BoxDecoration(color: Color(0xFF2E7D32), borderRadius: BorderRadius.circular(15)), child: TextField(decoration: InputDecoration(icon: Icon(Icons.search, color: Colors.white), hintText: 'Search Airbnb, House, Lot, Servic...', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none))),
          
          // REGISTRATION COMMISSION - SEPARATE BUTTON AUTOMATIC PAYMENT
          Container(
            margin: EdgeInsets.symmetric(horizontal:15),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: isRegistered ? Colors.green.shade100 : Colors.orange.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: isRegistered ? Colors.green : Colors.orange)),
            child: Row(children:[
              Icon(isRegistered ? Icons.verified : Icons.app_registration, color: isRegistered ? Colors.green : Colors.orange),
              SizedBox(width:10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
                Text(isRegistered ? 'REGISTERED NA - AUTOMATIC PAYOUT ON!' : 'Wala pa ka naka-register!', style: TextStyle(fontWeight: FontWeight.bold, fontSize:12)),
                Text(isRegistered ? 'Commission mu-sulod auto sa GoTyme:$myGoTyme' : 'I-register para auto sulod commission sa imong GoTyme/GCash/Bank', style: TextStyle(fontSize:10)),
              ])),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: isRegistered ? Colors.green : Colors.orange),
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>RegistrationCommissionPage(onRegistered: (gcash, gotyme, bank){setState((){myGcash=gcash; myGoTyme=gotyme; myBank=bank; isRegistered=true;});}, isRegistered:isRegistered))),
                child: Text(isRegistered ? 'UPDATE' : 'REGISTER', style: TextStyle(fontSize:12)),
              ),
            ]),
          ),

          Padding(padding: EdgeInsets.all(15), child: Text('Pangitaon? - MA-PINDOT NA!', style: TextStyle(fontSize:22, fontWeight: FontWeight.bold))),
          Padding(padding: EdgeInsets.symmetric(horizontal:10), child: GridView.count(crossAxisCount:2, shrinkWrap:true, physics: NeverScrollableScrollPhysics(), childAspectRatio:2.5, children:[
            _cat('Airbnb', Icons.home, Color(0xFFFFEBEE), Colors.red),
            _cat('House Rent', Icons.home_work, Color(0xFFE8F5E9), Colors.green),
            _cat('House Sale', Icons.house, Color(0xFFE3F2FD), Colors.blue),
            _cat('Lot Rent', Icons.terrain, Color(0xFFFFF3E0), Colors.orange),
            _cat('Lot Sale', Icons.landscape, Color(0xFFEFEBE9), Colors.brown),
            _cat('Rent Car', Icons.car_rental, Color(0xFFF3E5F5), Colors.purple),
            _cat('Food', Icons.fastfood, Color(0xFFFBE9E7), Colors.deepOrange),
            _cat('Services', Icons.build, Color(0xFFE0F2F1), Colors.teal),
          ])),

          Padding(padding: EdgeInsets.all(15), child: Text('Popular Services - MA-PINDOT NA!', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold))),
          Padding(padding: EdgeInsets.symmetric(horizontal:15), child: GridView.count(crossAxisCount:4, shrinkWrap:true, physics: NeverScrollableScrollPhysics(), children:[
            _serv(Icons.ac_unit, 'Aircon'), _serv(Icons.cleaning_services, 'Cleaning'), _serv(Icons.plumbing, 'Tubero'), _serv(Icons.handyman, 'Renovation'),
            _serv(Icons.electrical_services, 'Electrical'), _serv(Icons.directions_bus, 'Mechanic'), _serv(Icons.spa, 'Manicure'), _serv(Icons.self_improvement, 'Massage'),
          ])),

          Padding(padding: EdgeInsets.all(15), child: Text('$selectedCat - ${filtered.length} ka result', style: TextStyle(fontWeight: FontWeight.bold))),
          ...filtered.map((p){
            int comm=(p['price']*0.15).toInt();
            return Card(margin: EdgeInsets.symmetric(horizontal:15, vertical:8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), child: Column(children:[
              ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(15)), child: Image.network(p['image'], height:180, width: double.infinity, fit: BoxFit.cover)),
              ListTile(title: Text(p['title']), subtitle: Text('${p['location']} - ₱${p['price']} | Kita: ₱$comm ${isRegistered ? '-> AUTO sa $myGoTyme' : '(Need Register)'}')),
              Padding(padding: EdgeInsets.all(10), child: Row(children:[
                Expanded(child: OutlinedButton.icon(icon: Icon(Icons.message), label: Text('Message'), onPressed: (){})),
                SizedBox(width:10),
                Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: isRegistered ? ()=>showModalBottomSheet(context:context, builder:(_)=>PaymentAuto(price:p['price'], comm:comm, goTyme:myGoTyme, gcash:myGcash, bank:myBank)) : ()=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('I-REGISTER SA TAAS PARA MAKA-KWARTA AUTOMATIC!'))), child: Text(isRegistered ? 'Book & Pay' : 'Need Register'))),
              ])),
            ]));
          }).toList(),
          SizedBox(height:120),
        ]),
      ),
      floatingActionButton: Column(mainAxisSize:MainAxisSize.min, children:[
        FloatingActionButton.extended(heroTag:'1', backgroundColor: isRegistered ? Colors.green : Colors.orange, icon: Icon(Icons.app_registration), label: Text(isRegistered ? 'REGISTERED ✓' : 'REGISTER COMMISSION'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>RegistrationCommissionPage(onRegistered:(a,b,c){setState((){myGcash=a; myGoTyme=b; myBank=c; isRegistered=true;});}, isRegistered:isRegistered)))),
        SizedBox(height:10),
        FloatingActionButton.extended(heroTag:'2', backgroundColor: Color(0xFFFF6B00), icon: Icon(Icons.add_a_photo), label: Text('MAG POST + PICTURE'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>PostPage(onPost:addProp)))),
      ]),
    );
  }

  Widget _cat(String title, IconData icon, Color bg, Color ic){
    bool sel = selectedCat==title;
    return InkWell(
      onTap: (){ filterCat(title); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gipili: $title - MA-PINDOT NA BOSS!'))); },
      child: Container(margin: EdgeInsets.all(5), decoration: BoxDecoration(color: sel ? ic.withOpacity(0.2) : bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: sel ? ic : ic.withOpacity(0.3), width: sel?2:1)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children:[Icon(icon, color: ic), SizedBox(width:8), Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: sel ? ic : Colors.black))])),
    );
  }
  Widget _serv(IconData icon, String name){
    return InkWell(onTap: (){ filterCat('Services'); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name - MA-PINDOT NA!'))); }, child: Column(children:[CircleAvatar(backgroundColor: Colors.white, radius:28, child: Icon(icon, color: Colors.teal)), SizedBox(height:5), Text(name, style: TextStyle(fontSize:11))]));
  }
}

// POST PAGE
class PostPage extends StatefulWidget{ final Function(Map<String,dynamic>) onPost; PostPage({required this.onPost}); @override State<PostPage> createState()=>_PostPageState(); }
class _PostPageState extends State<PostPage>{
  var title=TextEditingController(); var price=TextEditingController(); var loc=TextEditingController(text:'Davao City'); var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'); String cat='House Rent';
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Mag Post + Picture')), body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
      DropdownButton<String>(value: cat, isExpanded:true, items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged:(v)=>setState(()=>cat=v!)),
      TextField(controller:title, decoration: InputDecoration(labelText:'Title', border: OutlineInputBorder())), SizedBox(height:10),
      TextField(controller:price, decoration: InputDecoration(labelText:'Price', border: OutlineInputBorder()), keyboardType: TextInputType.number), SizedBox(height:10),
      TextField(controller:loc, decoration: InputDecoration(labelText:'Location', border: OutlineInputBorder())), SizedBox(height:10),
      TextField(controller:img, decoration: InputDecoration(labelText:'Picture URL', border: OutlineInputBorder())), SizedBox(height:20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: (){widget.onPost({'title':title.text,'price':int.tryParse(price.text)??15000,'location':loc.text,'image':img.text,'cat':cat}); Navigator.pop(context);}, child: Text('I-POST NA!')),
    ])));
  }
}

// REGISTRATION COMMISSION - AUTOMATIC PAYMENT
class RegistrationCommissionPage extends StatefulWidget{
  final Function(String,String,String) onRegistered; final bool isRegistered;
  RegistrationCommissionPage({required this.onRegistered, required this.isRegistered});
  @override
  State<RegistrationCommissionPage> createState()=>_RegistrationCommissionPageState();
}
class _RegistrationCommissionPageState extends State<RegistrationCommissionPage>{
  var gcash=TextEditingController(text:'09123456789'); var gotyme=TextEditingController(text:'019812345678'); var bank=TextEditingController(text:'GoTyme Bank - Juan Dela Cruz - 0198XXXX');
  String selPayout='GoTyme';
  List<String> methods=['GCash','Maya','GoTyme','GoTyme Bank','BPI','BDO','Metrobank','UnionBank','Landbank','RCBC','Security Bank','China Bank','PNB','BDO Network','CIMB','Tonik','SeaBank','QR PH'];
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Registration Commission - AUTOMATIC!'), backgroundColor: Colors.green),
      body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
        Container(padding:EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Text('AUTOMATIC PAYMENT COMMISSION SYSTEM', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          Text('1. Customer mag bayad ₱15,000 via GCash/Maya/GoTyme/Bank\n2. PayMongo/Xendit mu-dawat\n3. 15% = ₱2,250 AUTOMATIC mu-sulod sa imong GoTyme/GCash/Bank - Wala nay manual!', style: TextStyle(fontSize:12)),
        ])),
        SizedBox(height:15),
        Text('Asa mu-sulod AUTOMATIC imong commission?', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height:10),
        Text('Pilia imong main payout:', style: TextStyle(fontSize:12)),
        Wrap(spacing:5, children: methods.map((m)=>ChoiceChip(label:Text(m, style: TextStyle(fontSize:11)), selected: selPayout==m, onSelected:(v)=>setState(()=>selPayout=m))).toList()),
        SizedBox(height:15),
        TextField(controller: gcash, decoration: InputDecoration(labelText:'GCash Number - AUTOMATIC PAYOUT DIRI', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone_android))),
        SizedBox(height:10),
        TextField(controller: gotyme, decoration: InputDecoration(labelText:'GoTyme Number/Account - AUTOMATIC PAYOUT DIRI (MAIN)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.account_balance))),
        SizedBox(height:10),
        TextField(controller: bank, decoration: InputDecoration(labelText:'Bank Account - BPI/BDO/GoTyme/Metrobank/UnionBank/Landbank/RCBC - TANAN!', border: OutlineInputBorder(), prefixIcon: Icon(Icons.account_balance_wallet))),
        SizedBox(height:20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(16)),
          onPressed: (){
            widget.onRegistered(gcash.text, gotyme.text, bank.text);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text('✅ REGISTERED NA! AUTOMATIC NA! Tanan commission ₱2,250 per booking mu-sulod AUTO sa $selPayout:${selPayout=='GCash'?gcash.text:selPayout.contains('GoTyme')?gotyme.text:bank.text}! Maka-kwarta na ka boss!')));
          },
          child: Text(widget.isRegistered ? 'UPDATE AUTOMATIC PAYOUT!' : 'REGISTER NA - AUTOMATIC KWARTA NA!', style: TextStyle(fontSize:14, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height:10),
        Text('Human register: Pag naay mag Book & Pay, ang commission mu-sulod DAYON sa imong $selPayout - Automatic walay manual transfer!', style: TextStyle(fontSize:11, color: Colors.grey)),
      ])),
    );
  }
}

// AUTOMATIC PAYMENT SHEET - TANAN BANK
class PaymentAuto extends StatefulWidget{
  final int price, comm; final String goTyme, gcash, bank;
  PaymentAuto({required this.price, required this.comm, required this.goTyme, required this.gcash, required this.bank});
  @override
  State<PaymentAuto> createState()=>_PaymentAutoState();
}
class _PaymentAutoState extends State<PaymentAuto>{
  String sel='GCash';
  List<String> all=['GCash','Maya','GoTyme','GoTyme Bank','GrabPay','ShopeePay','SeaBank','BPI','BDO','Metrobank','UnionBank','Landbank','RCBC','Security Bank','China Bank','PNB','CIMB','Tonik','QR PH','Visa/Mastercard'];
  @override
  Widget build(BuildContext context){
    return Container(padding:EdgeInsets.all(20), height:500, child: Column(children:[
      Text('AUTOMATIC PAYMENT - TANAN BANK!', style: TextStyle(fontWeight: FontWeight.bold)),
      Container(padding:EdgeInsets.all(8), color: Colors.green.shade50, child: Text('Total ₱${widget.price} - Commission ₱${widget.comm} AUTO -> ${widget.goTyme}/${widget.gcash}', style: TextStyle(fontSize:11, color: Colors.green))),
      SizedBox(height:10),
      Expanded(child: SingleChildScrollView(child: Wrap(spacing:5, children: all.map((m)=>ChoiceChip(label:Text(m, style: TextStyle(fontSize:11)), selected: sel==m, onSelected:(v)=>setState(()=>sel=m))).toList()))),
      SizedBox(width:double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: (){Navigator.pop(context); showDialog(context:context, builder:(_)=>AlertDialog(title:Text('✅ BAYAD NA - AUTOMATIC!'), content: Text('Via $sel ₱${widget.price}\n\nCommission ₱${widget.comm} AUTOMATIC na sulod sa:\nGoTyme: ${widget.goTyme}\nGCash: ${widget.gcash}\nBank: ${widget.bank}\n\nWala nay manual - Auto na boss! Maka-kwarta na!')));}, child: Text('BAYARAN ₱${widget.price} via $sel - AUTO PAYOUT!'))),
    ]));
  }
}
