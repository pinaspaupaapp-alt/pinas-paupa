import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: PinasPaupaApp(), debugShowCheckedModeBanner: false));

class PinasPaupaApp extends StatefulWidget { @override State<PinasPaupaApp> createState() => _PinasPaupaAppState(); }

class _PinasPaupaAppState extends State<PinasPaupaApp> {
  List<Map<String, dynamic>> allProps = [
    {'title':'Modern Apartment Davao','location':'Davao City','price':15000,'image':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','cat':'House Rent','owner':'Anna - 09123456789'},
    {'title':'Beach Lot Samal 500sqm','location':'Samal Island','price':5000,'image':'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800','cat':'Lot Rent','owner':'Jun - 09123456780'},
    {'title':'Airbnb Condo Makati','location':'Makati Manila','price':3000,'image':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','cat':'Airbnb','owner':'Mika - 09123456781'},
    {'title':'House Sale Davao 3BR','location':'Mintal Davao','price':2500000,'image':'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800','cat':'House Sale','owner':'Pedro - 09123456782'},
    {'title':'Innova Rent Car','location':'Davao City','price':2500,'image':'https://images.unsplash.com/photo-1550355291-bbee04a92027?w=800','cat':'Rent Car','owner':'RentCar Davao - 09123456783'},
    {'title':'Lechon Food Package','location':'Davao City','price':8000,'image':'https://images.unsplash.com/photo-1544025162-d76694265947?w=800','cat':'Food','owner':'Lutong Bahay - 09123456784'},
    {'title':'Aircon Cleaning Service','location':'Davao City','price':800,'image':'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=800','cat':'Services','owner':'Tubero Davao - 09123456785'},
  ];
  String myGcash="09123456789"; String myGoTyme="019812345678"; String myBank="GoTyme Bank"; bool isRegistered=false;

  void addProp(Map<String,dynamic> p){ setState(()=>allProps.insert(0,p)); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF2F8),
      appBar: AppBar(title: Text('Pinas Paupa 🇵🇭'), backgroundColor: Color(0xFF2E7D32)),
      body: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
        Container(margin: EdgeInsets.all(15), padding: EdgeInsets.symmetric(horizontal:15), decoration: BoxDecoration(color: Color(0xFF2E7D32), borderRadius: BorderRadius.circular(15)), child: TextField(decoration: InputDecoration(icon: Icon(Icons.search, color: Colors.white), hintText: 'Search...', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none))),
        
        Container(margin: EdgeInsets.symmetric(horizontal:15), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: isRegistered?Colors.green.shade100:Colors.orange.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: isRegistered?Colors.green:Colors.orange)), child: Row(children:[
          Icon(isRegistered?Icons.verified:Icons.app_registration, color: isRegistered?Colors.green:Colors.orange),
          SizedBox(width:10),
          Expanded(child: Text(isRegistered?'REGISTERED - AUTO PAYOUT SA ${myGoTyme}':'I-register para auto sulod commission', style: TextStyle(fontSize:11, fontWeight: FontWeight.bold))),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: isRegistered?Colors.green:Colors.orange), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>RegistrationPage(onReg:(a,b,c){setState((){myGcash=a; myGoTyme=b; myBank=c; isRegistered=true;});}))), child: Text(isRegistered?'UPDATE':'REGISTER')),
        ])),

        Padding(padding: EdgeInsets.all(15), child: Text('Pangitaon? - I-CLICK PARA MU-ABLI!', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.symmetric(horizontal:10), child: GridView.count(crossAxisCount:2, shrinkWrap:true, physics: NeverScrollableScrollPhysics(), childAspectRatio:2.6, children:[
          _cat('Airbnb', Icons.home, Color(0xFFFFEBEE), Colors.red),
          _cat('House Rent', Icons.home_work, Color(0xFFE8F5E9), Colors.green),
          _cat('House Sale', Icons.house, Color(0xFFE3F2FD), Colors.blue),
          _cat('Lot Rent', Icons.terrain, Color(0xFFFFF3E0), Colors.orange),
          _cat('Lot Sale', Icons.landscape, Color(0xFFEFEBE9), Colors.brown),
          _cat('Rent Car', Icons.car_rental, Color(0xFFF3E5F5), Colors.purple),
          _cat('Food', Icons.fastfood, Color(0xFFFBE9E7), Colors.deepOrange),
          _cat('Services', Icons.build, Color(0xFFE0F2F1), Colors.teal),
        ])),

        Padding(padding: EdgeInsets.all(15), child: Text('Popular Services - I-CLICK!', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.symmetric(horizontal:10), child: GridView.count(crossAxisCount:4, shrinkWrap:true, physics: NeverScrollableScrollPhysics(), children:[
          _serv('Aircon', Icons.ac_unit), _serv('Cleaning', Icons.cleaning_services), _serv('Tubero', Icons.plumbing), _serv('Renovation', Icons.handyman),
          _serv('Electrical', Icons.electrical_services), _serv('Mechanic', Icons.directions_bus), _serv('Manicure', Icons.spa), _serv('Massage', Icons.self_improvement),
        ])),
        SizedBox(height:120),
      ])),
      floatingActionButton: Column(mainAxisSize:MainAxisSize.min, children:[
        FloatingActionButton.extended(heroTag:'reg', backgroundColor: Colors.green, icon: Icon(Icons.wallet), label: Text(isRegistered?'REGISTERED ✓':'REGISTER COMMISSION'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>RegistrationPage(onReg:(a,b,c){setState((){myGcash=a; myGoTyme=b; myBank=c; isRegistered=true;});})))),
        SizedBox(height:10),
        FloatingActionButton.extended(heroTag:'post', backgroundColor: Color(0xFFFF6B00), icon: Icon(Icons.add_a_photo), label: Text('MAG POST + PICTURE'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>PostPage(onPost:addProp)))),
      ]),
    );
  }

  Widget _cat(String title, IconData icon, Color bg, Color ic){
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>CategoryOpenPage(cat:title, props:allProps, isRegistered:isRegistered, myGcash:myGcash, myGoTyme:myGoTyme, myBank:myBank))),
      child: Container(margin: EdgeInsets.all(5), decoration: BoxDecoration(color:bg, borderRadius: BorderRadius.circular(12), border: Border.all(color:ic.withOpacity(0.3))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children:[Icon(icon, color:ic), SizedBox(width:6), Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize:13))])),
    );
  }
  Widget _serv(String name, IconData icon){
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>CategoryOpenPage(cat:'Services', props:allProps.where((p)=>p['cat']=='Services' || name.toLowerCase().contains(p['title'].toLowerCase())).toList(), isRegistered:isRegistered, myGcash:myGcash, myGoTyme:myGoTyme, myBank:myBank, serviceName:name))),
      child: Column(children:[CircleAvatar(backgroundColor:Colors.white, radius:28, child: Icon(icon, color: Colors.teal)), SizedBox(height:4), Text(name, style: TextStyle(fontSize:11))]),
    );
  }
}

// KANA MA-OPEN NA PAGE - MAKA INSERT PICTURE + MAKA CHAT + BOOK & PAY
class CategoryOpenPage extends StatelessWidget{
  final String cat; final List<Map<String,dynamic>> props; final bool isRegistered; final String myGcash, myGoTyme, myBank; final String? serviceName;
  CategoryOpenPage({required this.cat, required this.props, required this.isRegistered, required this.myGcash, required this.myGoTyme, required this.myBank, this.serviceName});
  @override
  Widget build(BuildContext context){
    var filtered = cat=='All'?props:props.where((p)=>p['cat']==cat || (serviceName!=null && p['title'].toLowerCase().contains(serviceName!.toLowerCase()))).toList();
    return Scaffold(
      appBar: AppBar(title: Text('$cat ${serviceName??''} - ${filtered.length} result'), backgroundColor: Color(0xFF2E7D32)),
      body: filtered.isEmpty ? Center(child: Text('Wala pay $cat - Ikaw una mag post!')) :
      ListView.builder(itemCount: filtered.length, itemBuilder: (c,i){
        var p=filtered[i]; int comm=(p['price']*0.15).toInt();
        return Card(margin: EdgeInsets.all(10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), child: Column(children:[
          ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(15)), child: Image.network(p['image'], height:200, width: double.infinity, fit: BoxFit.cover, errorBuilder:(a,b,c)=>Container(height:200, color: Colors.grey.shade300, child: Icon(Icons.image)))),
          ListTile(title: Text(p['title'], style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('${p['location']} - ₱${p['price']} | Kita: ₱$comm\nOwner: ${p['owner']}')),
          Padding(padding: EdgeInsets.all(10), child: Row(children:[
            Expanded(child: OutlinedButton.icon(icon: Icon(Icons.chat), label: Text('Chat'), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>ChatPage(owner:p['owner'], title:p['title'], image:p['image']))))),
            SizedBox(width:8),
            Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: isRegistered ? ()=>showModalBottomSheet(context:context, builder:(_)=>PaySheet(price:p['price'], comm:comm, goTyme:myGoTyme, gcash:myGcash, bank:myBank)) : ()=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('I-REGISTER SA UNA PARA MAKA-PAY AUTOMATIC!'))), child: Text(isRegistered?'Book & Pay':'Need Register'))),
          ])),
        ]));
      }),
      floatingActionButton: FloatingActionButton.extended(icon: Icon(Icons.add_a_photo), label: Text('Mag Post ug $cat + Picture'), backgroundColor: Color(0xFFFF6B00), onPressed: ()=>Navigator.pop(context)),
    );
  }
}

// CHAT PAGE - TINUOD MAKA CHAT!
class ChatPage extends StatefulWidget{
  final String owner, title, image; ChatPage({required this.owner, required this.title, required this.image});
  @override
  State<ChatPage> createState()=>_ChatPageState();
}
class _ChatPageState extends State<ChatPage>{
  List<String> msgs=['Hello! Available pa ni ${DateTime.now().hour}:${DateTime.now().minute}?']; var ctrl=TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(widget.owner), backgroundColor: Color(0xFF2E7D32), leading: CircleAvatar(backgroundImage: NetworkImage(widget.image)), actions: [IconButton(icon: Icon(Icons.call), onPressed: (){})]),
      body: Column(children:[
        Container(padding: EdgeInsets.all(10), color: Colors.grey.shade100, child: Row(children:[Image.network(widget.image, width:60, height:60, fit: BoxFit.cover), SizedBox(width:10), Expanded(child: Text(widget.title)) ])),
        Expanded(child: ListView.builder(itemCount: msgs.length, itemBuilder: (c,i)=>Align(alignment: i%2==0?Alignment.centerRight:Alignment.centerLeft, child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: i%2==0?Color(0xFF2E7D32):Colors.grey.shade200, borderRadius: BorderRadius.circular(15)), child: Text(msgs[i], style: TextStyle(color: i%2==0?Colors.white:Colors.black)))))),
        Padding(padding: EdgeInsets.all(10), child: Row(children:[
          Expanded(child: TextField(controller: ctrl, decoration: InputDecoration(hintText: 'Maka-chat tinuod - type message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))))),
          IconButton(icon: Icon(Icons.send, color: Color(0xFF2E7D32)), onPressed: (){ if(ctrl.text.isNotEmpty){ setState(()=>msgs.add(ctrl.text)); ctrl.clear(); Future.delayed(Duration(seconds:1), ()=>setState(()=>msgs.add('Yes boss available pa! Kanus-a nimo i-book? Maka GoTyme/GCash/Bank ta!'))); }}),
        ])),
      ]),
    );
  }
}

// POST PAGE - MAKA INSERT PICTURE!
class PostPage extends StatefulWidget{ final Function(Map<String,dynamic>) onPost; PostPage({required this.onPost}); @override State<PostPage> createState()=>_PostPageState(); }
class _PostPageState extends State<PostPage>{
  var title=TextEditingController(); var price=TextEditingController(); var loc=TextEditingController(text:'Davao City'); var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'); String cat='House Rent';
  String selectedImage='https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800';
  List<String> sampleImages=[
    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
    'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
    'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800',
    'https://images.unsplash.com/photo-1550355291-bbee04a92027?w=800',
    'https://images.unsplash.com/photo-1544025162-d76694265947?w=800',
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Mag Post + Insert Picture')), body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
      Text('PILIA PICTURE - MAKA INSERT NA!', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height:10),
      Container(height:180, child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(selectedImage, width: double.infinity, fit: BoxFit.cover))),
      SizedBox(height:10),
      Text('Pilia sample picture (mao ni maka-insert picture):'),
      SizedBox(height:5),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: sampleImages.map((im)=>InkWell(onTap: ()=>setState((){selectedImage=im; img.text=im;}), child: Container(margin: EdgeInsets.all(5), decoration: BoxDecoration(border: Border.all(color: selectedImage==im?Colors.orange:Colors.grey, width: selectedImage==im?3:1), borderRadius: BorderRadius.circular(8)), child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(im, width:80, height:80, fit: BoxFit.cover))))).toList())),
      SizedBox(height:10),
      ElevatedButton.icon(icon: Icon(Icons.photo_library), label: Text('Maka-insert picture - Gallery (Sample ra karon)'), onPressed: ()=>setState(()=>selectedImage=sampleImages[1])),
      Text('Note: Sa sunod, ma-connect nato sa phone gallery para tinuod na picture gikan sa imong phone!', style: TextStyle(fontSize:10, color: Colors.grey)),
      SizedBox(height:15),
      DropdownButton<String>(value: cat, isExpanded:true, items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged:(v)=>setState(()=>cat=v!)),
      TextField(controller:title, decoration: InputDecoration(labelText:'Title', border: OutlineInputBorder())), SizedBox(height:10),
      TextField(controller:price, decoration: InputDecoration(labelText:'Price', border: OutlineInputBorder()), keyboardType: TextInputType.number), SizedBox(height:10),
      TextField(controller:loc, decoration: InputDecoration(labelText:'Location', border: OutlineInputBorder())), SizedBox(height:10),
      TextField(controller:img, decoration: InputDecoration(labelText:'Image URL', border: OutlineInputBorder())),
      SizedBox(height:20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00), padding: EdgeInsets.all(15)), onPressed: (){widget.onPost({'title':title.text,'price':int.tryParse(price.text)??15000,'location':loc.text,'image':selectedImage,'cat':cat,'owner':'Ikaw - $loc'}); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Na-post na! Naa nay picture! Makita na sa $cat!')));}, child: Text('I-POST NA + PICTURE!')),
    ])));
  }
}

class RegistrationPage extends StatefulWidget{ final Function(String,String,String) onReg; RegistrationPage({required this.onReg}); @override State<RegistrationPage> createState()=>_RegistrationPageState(); }
class _RegistrationPageState extends State<RegistrationPage>{
  var gcash=TextEditingController(text:'09123456789'); var gotyme=TextEditingController(text:'019812345678'); var bank=TextEditingController(text:'GoTyme Bank - Juan'); String sel='GoTyme';
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Register Commission - Automatic'), backgroundColor: Colors.green), body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
      Container(padding: EdgeInsets.all(12), color: Colors.green.shade50, child: Text('AUTOMATIC: Pag naay mag Book ₱15k, ₱2,250 AUTO sulod sa imong GoTyme/GCash/Bank!', style: TextStyle(fontSize:12, fontWeight: FontWeight.bold, color: Colors.green))),
      SizedBox(height:10),
      Wrap(spacing:5, children: ['GCash','Maya','GoTyme','GoTyme Bank','BPI','BDO','Metrobank','UnionBank','Landbank','RCBC'].map((m)=>ChoiceChip(label:Text(m), selected: sel==m, onSelected:(v)=>setState(()=>sel=m))).toList()),
      SizedBox(height:10),
      TextField(controller:gcash, decoration: InputDecoration(labelText:'GCash', border: OutlineInputBorder())), SizedBox(height:10),
      TextField(controller:gotyme, decoration: InputDecoration(labelText:'GoTyme', border: OutlineInputBorder())), SizedBox(height:10),
      TextField(controller:bank, decoration: InputDecoration(labelText:'Bank', border: OutlineInputBorder())), SizedBox(height:20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)), onPressed: (){widget.onReg(gcash.text, gotyme.text, bank.text); Navigator.pop(context);}, child: Text('REGISTER AUTOMATIC PAYOUT!')),
    ])));
  }
}

class PaySheet extends StatefulWidget{ final int price, comm; final String goTyme, gcash, bank; PaySheet({required this.price, required this.comm, required this.goTyme, required this.gcash, required this.bank}); @override State<PaySheet> createState()=>_PaySheetState(); }
class _PaySheetState extends State<PaySheet>{
  String sel='GCash'; List<String> all=['GCash','Maya','GoTyme','GoTyme Bank','BPI','BDO','Metrobank','UnionBank','Landbank','RCBC','QR PH','Visa'];
  @override
  Widget build(BuildContext context){
    return Container(padding: EdgeInsets.all(20), height:400, child: Column(children:[
      Text('AUTOMATIC PAY - Commission ₱${widget.comm} -> ${widget.goTyme}', style: TextStyle(fontWeight: FontWeight.bold)),
      Expanded(child: SingleChildScrollView(child: Wrap(spacing:5, children: all.map((m)=>ChoiceChip(label:Text(m, style: TextStyle(fontSize:11)), selected: sel==m, onSelected:(v)=>setState(()=>sel=m))).toList()))),
      SizedBox(width:double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: (){Navigator.pop(context); showDialog(context:context, builder:(_)=>AlertDialog(title:Text('✅ AUTOMATIC NA!'), content: Text('Via $sel ₱${widget.price}\nCommission ₱${widget.comm} AUTO sulod sa GoTyme:${widget.goTyme}/GCash:${widget.gcash}'))));}, child: Text('BAYARAN ₱${widget.price} via $sel'))),
    ]));
  }
}
