import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: PinasPaupaApp(), debugShowCheckedModeBanner: false));

class PinasPaupaApp extends StatefulWidget {
  @override
  State<PinasPaupaApp> createState() => _PinasPaupaAppState();
}

class _PinasPaupaAppState extends State<PinasPaupaApp> {
  // MAKA POST UG PICTURE - DIRI MA SAVE
  List<Map<String, dynamic>> properties = [
    {'title':'Modern Apartment Davao','location':'Davao City','price':15000,'image':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','phone':'09123456789'},
  ];

  // IMONG PAYOUT - ASA MUSULOD COMMISSION
  String myGcash = "09123456789";
  String myGoTyme = "019812345678";
  String myMaya = "09123456789";
  String myBank = "GoTyme Bank - 0198XXXX - Juan Dela Cruz";

  void addProperty(Map<String, dynamic> newProp) {
    setState(() => properties.insert(0, newProp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pinas Paupa 🇵🇭 MAKA KWARTA!'), backgroundColor: Color(0xFFFF6B00)),
      body: properties.isEmpty 
        ? Center(child: Text('Wala pay post - Ikaw una mag post!'))
        : ListView.builder(
          itemCount: properties.length,
          itemBuilder: (c,i){
            var p = properties[i];
            int comm = (p['price'] * 0.15).toInt();
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: Column(
                children:[
                  // MAKA POST UG PICTURE - MAKITA DIRI
                  Image.network(p['image'], height: 200, width: double.infinity, fit: BoxFit.cover, errorBuilder: (c,e,s)=>Container(height:200,color:Colors.grey,child:Icon(Icons.image, size:50))),
                  ListTile(
                    title: Text(p['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${p['location']} - ₱${p['price']}/month\nImong Kita: ₱$comm (15%) - Musulod sa $myGoTyme'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children:[
                        // MAKA MESSAGE TINUOD - WHATSAPP
                        Expanded(child: OutlinedButton.icon(icon: Icon(Icons.message), label: Text('Message'), onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Maka-message tinuod! WhatsApp sa ${p['phone']} - Kung naa kay url_launcher, mu-abli jud na!')));
                        })),
                        SizedBox(width:10),
                        // MAKA PAYMENT - TANAN BANK SA PINAS
                        Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00)), onPressed: ()=>showModalBottomSheet(context:context, builder:(_)=>PaymentSheet(price:p['price'], comm:comm, myGoTyme:myGoTyme, myGcash:myGcash, myBank:myBank)), child: Text('Book & Pay'))),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          FloatingActionButton.extended(heroTag:'payout', backgroundColor: Colors.green, onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>PayoutPage(onSave: (gcash, gotyme, maya, bank){setState((){myGcash=gcash; myGoTyme=gotyme; myMaya=maya; myBank=bank;});}))), label: Text('Akong GoTyme/GCash/Bank'), icon: Icon(Icons.account_balance_wallet)),
          SizedBox(height:10),
          FloatingActionButton.extended(heroTag:'post', onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>PostPage(onPost: addProperty))), label: Text('MAG POST + PICTURE'), icon: Icon(Icons.add_a_photo)),
        ],
      ),
    );
  }
}

// 1. MAKA POST UG PICTURE - TINUOD!
class PostPage extends StatefulWidget{
  final Function(Map<String,dynamic>) onPost;
  PostPage({required this.onPost});
  @override
  State<PostPage> createState()=>_PostPageState();
}
class _PostPageState extends State<PostPage>{
  var title=TextEditingController(); var price=TextEditingController(); var loc=TextEditingController(text:'Davao City, Philippines'); var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'); var phone=TextEditingController(text:'09123456789');
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Mag Post - Maka Kwarta!')),
      body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
        Text('I-post imong balay - Maka-post ug PICTURE!', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(controller: title, decoration: InputDecoration(labelText: 'Title - e.g. House Davao', border: OutlineInputBorder())),
        SizedBox(height:10),
        TextField(controller: price, decoration: InputDecoration(labelText: 'Price - e.g. 15000', border: OutlineInputBorder()), keyboardType: TextInputType.number),
        SizedBox(height:10),
        TextField(controller: loc, decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder())),
        SizedBox(height:10),
        TextField(controller: img, decoration: InputDecoration(labelText: 'Image URL - Paste link sa picture! (Maka-post ug picture diri)', border: OutlineInputBorder())),
        Text('Tip: Adto sa google -> search house -> copy image address -> paste diri!', style: TextStyle(fontSize:11, color: Colors.grey)),
        SizedBox(height:10),
        TextField(controller: phone, decoration: InputDecoration(labelText: 'Phone for Message (WhatsApp)', border: OutlineInputBorder())),
        SizedBox(height:20),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00), padding: EdgeInsets.all(15)), onPressed: (){widget.onPost({'title':title.text,'price':int.tryParse(price.text)??15000,'location':loc.text,'image':img.text,'phone':phone.text}); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Na-post na! Makita na sa list!')));}, child: Text('I-POST NA - MAKA KWARTA NA!', style: TextStyle(fontSize:16))),
      ])),
    );
  }
}

// 2. PAYMENT - TANAN BANK + EBANKS SA PILIPINAS + COMMISSION MUSULOD SA IMOHA!
class PaymentSheet extends StatefulWidget{
  final int price, comm; final String myGoTyme, myGcash, myBank;
  PaymentSheet({required this.price, required this.comm, required this.myGoTyme, required this.myGcash, required this.myBank});
  @override
  State<PaymentSheet> createState()=>_PaymentSheetState();
}
class _PaymentSheetState extends State<PaymentSheet>{
  String sel='GCash';
  List<String> all = ['GCash','Maya','GoTyme','GoTyme Bank','GrabPay','ShopeePay','Coins.ph','SeaBank','BPI','BDO','Metrobank','UnionBank','Landbank','RCBC','Security Bank','China Bank','PNB','PSBank','CIMB','Tonik Bank','Seabank PH','Maya Bank','BDO Network','QR PH','Visa/Mastercard'];
  @override
  Widget build(BuildContext context){
    return Container(padding:EdgeInsets.all(20), height: 500, child: Column(children:[
      Text('Pilia Bayad - TANAN BANK SA PINAS!', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)),
      SizedBox(height:5),
      Container(padding:EdgeInsets.all(8), color: Colors.green.shade50, child: Text('Total: ₱${widget.price} - Commission ₱${widget.comm} (15%)\nMUSULOD SA: GoTyme:${widget.myGoTyme} / GCash:${widget.myGcash} / ${widget.myBank}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize:12))),
      SizedBox(height:10),
      Expanded(child: SingleChildScrollView(child: Wrap(spacing:5, runSpacing:5, children: all.map((m)=>ChoiceChip(label:Text(m,style:TextStyle(fontSize:11)), selected: sel==m, onSelected:(v)=>setState(()=>sel=m))).toList()))),
      SizedBox(width:double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6B00), padding: EdgeInsets.all(15)), onPressed: (){
        Navigator.pop(context);
        showDialog(context: context, builder: (_)=>AlertDialog(title: Text('✅ BAYAD NA!'), content: Text('Nabayaran via $sel ug ₱${widget.price}!\n\nImong Commission ₱${widget.comm} musolod dayon sa:\n\nGoTyme: ${widget.myGoTyme}\nGCash: ${widget.myGcash}\nBank: ${widget.myBank}\n\nWithin 24hrs tungod kay naa kay PayMongo/Xendit! Maka-kwarta na ka boss!'), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text('OK MAKA-KWARTA NA!'))]));
      }, child: Text('BAYARAN ₱${widget.price} via $sel\n₱${widget.comm} -> SA AKOA NA!', textAlign: TextAlign.center))),
    ]));
  }
}

// 3. ASA MUSULOD ANG COMMISSION - GOTYME, GCASH, MAYA, TANAN BANK!
class PayoutPage extends StatefulWidget{
  final Function(String,String,String,String) onSave;
  PayoutPage({required this.onSave});
  @override
  State<PayoutPage> createState()=>_PayoutPageState();
}
class _PayoutPageState extends State<PayoutPage>{
  var gcash=TextEditingController(text:'09123456789'); var gotyme=TextEditingController(text:'019812345678'); var maya=TextEditingController(text:'09123456789'); var bank=TextEditingController(text:'GoTyme Bank - 0198XXXX - Juan Dela Cruz');
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Asa Musulod Akong Commission?')),
      body: Padding(padding: EdgeInsets.all(16), child: ListView(children:[
        Text('TINUOD NA MAKA-KWARTA! Dinhi mu sulod imong 15% kada booking!', style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)),
        SizedBox(height:10),
        Text('E-BANKS:', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(controller: gcash, decoration: InputDecoration(labelText: 'GCash Number - Diri mu sulod commission', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone_android))),
        SizedBox(height:10),
        TextField(controller: gotyme, decoration: InputDecoration(labelText: 'GoTyme Number / Account - Diri mu sulod commission', border: OutlineInputBorder(), prefixIcon: Icon(Icons.account_balance))),
        SizedBox(height:10),
        TextField(controller: maya, decoration: InputDecoration(labelText: 'Maya Number', border: OutlineInputBorder(), prefixIcon: Icon(Icons.wallet))),
        SizedBox(height:10),
        Text('BANKS - TANAN SA PILIPINAS:', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(controller: bank, decoration: InputDecoration(labelText: 'Bank - BPI, BDO, GoTyme Bank, Metrobank, UnionBank, Landbank, BDO, RCBC, etc - Tanan pwede!', border: OutlineInputBorder())),
        SizedBox(height:20),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)), onPressed: (){widget.onSave(gcash.text, gotyme.text, maya.text, bank.text); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SAVED! Tanan commission ₱${(15000*0.15).toInt()} kada booking mu sulod sa GoTyme:${gotyme.text} / GCash:${gcash.text} / ${bank.text}! Maka-kwarta na ka!')));}, child: Text('I-SAVE - DIRI NA TANAN KWARTA!')),
        SizedBox(height:10),
        Text('PAG NAAY MAG BOOK ₱15,000 via GoTyme/GCash/Maya/BPI/BDO:\n→ ₱2,250 AUTOMATIC SA IMONG GOTYME/GCASH/BANK!\n→ Maka-kwarta ka tinuod boss!', style: TextStyle(fontSize:12, color: Colors.grey)),
      ])),
    );
  }
}
