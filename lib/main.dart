import 'package:flutter/material.dart';

void main() {
  runApp(PinasPaupaApp());
}

class PinasPaupaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinas Paupa',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> props = [
    {'title':'Modern Apartment Davao','location':'Davao City','price':15000,'image':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'},
    {'title':'House for Rent Makati','location':'Makati Manila','price':25000,'image':'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pinas Paupa - GoTyme Ready'), backgroundColor: Color(0xFFFF6B00)),
      body: ListView.builder(
        itemCount: props.length,
        itemBuilder: (c,i){
          var p=props[i];
          int comm=(p['price']*0.15).toInt();
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children:[
                Image.network(p['image'],height:180,width:double.infinity,fit:BoxFit.cover),
                ListTile(title:Text(p['title']),subtitle:Text('${p['location']} - ₱${p['price']} | Kita nimo: ₱$comm')),
                ElevatedButton(
                  onPressed: ()=>showModalBottomSheet(context:context,builder:(_)=>PaymentSheet(price:p['price'],comm:comm)),
                  child:Text('Book & Pay - GCash/Maya/GoTyme/Bank'),
                ),
                SizedBox(height:10),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>PayoutPage())),
        label:Text('Akong GoTyme / GCash / Bank'),
        icon:Icon(Icons.wallet),
        backgroundColor:Colors.green,
      ),
    );
  }
}

class PaymentSheet extends StatefulWidget{
  final int price; final int comm;
  PaymentSheet({required this.price, required this.comm});
  @override
  State<PaymentSheet> createState()=>_PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet>{
  String sel='GCash';
  List<String> methods=['GCash','Maya','GoTyme','GoTyme Bank','GrabPay','ShopeePay','SeaBank','BPI','BDO','Metrobank','UnionBank','Landbank','RCBC','BPI Family','PNB','CIMB','Tonik','QR PH','Visa/Mastercard'];
  
  @override
  Widget build(BuildContext context){
    return Container(
      padding:EdgeInsets.all(20),
      height:420,
      child:Column(
        children:[
          Text('Pilia Bayad - Tanan naa!',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          Text('Total ₱${widget.price} - Imong Commission ₱${widget.comm} sa imong GoTyme/GCash/Maya',style:TextStyle(color:Colors.green)),
          SizedBox(height:10),
          Expanded(child:SingleChildScrollView(child:Wrap(spacing:6,children:methods.map((m)=>ChoiceChip(label:Text(m,style:TextStyle(fontSize:12)),selected:sel==m,onSelected:(v)=>setState(()=>sel=m))).toList()))),
          SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('✅ Nabayaran via $sel! ₱${widget.comm} mu sulod sa imong GoTyme/GCash!')));Navigator.pop(context);},child:Text('BAYARAN ₱${widget.price} via $sel'))),
        ],
      ),
    );
  }
}

class PayoutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text('Asa Musulod Commission?')),
      body:Padding(
        padding:EdgeInsets.all(16),
        child:ListView(
          children:[
            Text('Dinhi mu sulod imong 15% kada booking!',style:TextStyle(fontWeight:FontWeight.bold)),
            TextField(decoration:InputDecoration(labelText:'GCash Number (09xx)',border:OutlineInputBorder())),
            SizedBox(height:10),
            TextField(decoration:InputDecoration(labelText:'GoTyme Number / Account (0198-...)',border:OutlineInputBorder())),
            SizedBox(height:10),
            TextField(decoration:InputDecoration(labelText:'Maya Number',border:OutlineInputBorder())),
            SizedBox(height:10),
            TextField(decoration:InputDecoration(labelText:'Bank: BPI, BDO, GoTyme Bank, Metrobank, UnionBank, Landbank, etc',border:OutlineInputBorder())),
            SizedBox(height:10),
            TextField(decoration:InputDecoration(labelText:'Bank Account Number',border:OutlineInputBorder())),
            SizedBox(height:10),
            TextField(decoration:InputDecoration(labelText:'Account Name',border:OutlineInputBorder())),
            SizedBox(height:20),
            ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.green,padding:EdgeInsets.all(15)),onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Saved! Ang commission mu sulod sa imong GoTyme/GCash/Maya/Bank!')));Navigator.pop(context);},child:Text('I-SAVE - DIRI NA TANAN COMMISSION!')),
          ],
        ),
      ),
    );
  }
}
