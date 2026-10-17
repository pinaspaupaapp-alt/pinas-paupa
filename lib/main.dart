import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(home:PinasPaupa(),debugShowCheckedModeBanner:false));

class PinasPaupa extends StatefulWidget{ @override State<PinasPaupa> createState()=>_S();}
class _S extends State<PinasPaupa>{
  int nav=0; bool reg=false; String gt='019812345678';
  List<Map<String,dynamic>> props=[
    // House Rent - 2 ka buok
    {'title':'Modern Apartment Davao','loc':'Davao City','price':15000,'cat':'House Rent','owner':'Anna','img':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600'},
    {'title':'Condo Cebu City','loc':'Cebu','price':18000,'cat':'House Rent','owner':'Cebu Host','img':'https://images.unsplash.com/photo-1502672023488-70e25813eb80?w=600'},
    // Airbnb - 2 ka buok
    {'title':'Airbnb Makati 2BR','loc':'Makati','price':3000,'cat':'Airbnb','owner':'Mika','img':'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=600'},
    {'title':'Airbnb Tagaytay Cabin','loc':'Tagaytay','price':4500,'cat':'Airbnb','owner':'Tagaytay Host','img':'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=600'},
    // House Sale - 2 ka buok
    {'title':'House & Lot Davao','loc':'Davao','price':2500000,'cat':'House Sale','owner':'John','img':'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=600'},
    {'title':'House & Lot Cavite','loc':'Cavite','price':3200000,'cat':'House Sale','owner':'Cavite Seller','img':'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=600'},
    // Lot Sale - 2 ka buok
    {'title':'500 sqm Lot Davao','loc':'Davao Mintal','price':800000,'cat':'Lot Sale','owner':'Lot Owner','img':'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600'},
    {'title':'1000 sqm Lot Tagaytay','loc':'Tagaytay','price':1500000,'cat':'Lot Sale','owner':'Tagaytay Lot','img':'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=600'},
    // Lot Rent - 2 ka buok
    {'title':'Commercial Lot Rent','loc':'Davao Downtown','price':20000,'cat':'Lot Rent','owner':'Commercial','img':'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600'},
    {'title':'Parking Lot Rent','loc':'Cebu IT Park','price':5000,'cat':'Lot Rent','owner':'Parking Owner','img':'https://images.unsplash.com/photo-1494526585095-c41746248156?w=600'},
    // Rent Car - 2 ka buok
    {'title':'Toyota Vios 2024 - Rent','loc':'Davao','price':2500,'cat':'Rent Car','owner':'Car Owner','img':'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600'},
    {'title':'Mitsubishi Montero Rent','loc':'Cebu','price':3500,'cat':'Rent Car','owner':'SUV Owner','img':'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=600'},
    // Food - 2 ka buok
    {'title':'Lechon Package 10pax','loc':'Davao','price':5000,'cat':'Food','owner':'Lechon Queen','img':'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600'},
    {'title':'Seafood Platter Family','loc':'Cebu','price':3500,'cat':'Food','owner':'Seafood Chef','img':'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600'},
    // Services - 2 ka buok
    {'title':'Plumbing Service 24/7','loc':'Davao','price':800,'cat':'Services','owner':'Tubero Boy','img':'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=600'},
    {'title':'Aircon Cleaning Service','loc':'Davao','price':1200,'cat':'Services','owner':'Aircon Tech','img':'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=600'},
  ];

  void openReg(){showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(20))),builder:(_)=>RegSheet(onDone:(){setState(()=>reg=true);Navigator.pop(context);}));}
  
  @override Widget build(BuildContext c){
    return Scaffold(
      backgroundColor:Color(0xFFFDF2F8),
      body: [Explore(props:props,reg:reg,gt:gt,onReg:openReg,onAdd:(m)=>setState(()=>props.insert(0,m))), Center(child:Text('Wishlists - Save your favorites')), Center(child:Text('Trips')), Center(child:Text('Messages')), Profile(name:reg?'Sonny SIMBAJON':'Guest',isReg:reg,onReg:openReg)][nav],
      floatingActionButton: nav==0?FloatingActionButton.extended(backgroundColor:Color(0xFFFF6B00),icon:Icon(Icons.add_a_photo),label:Text('MAG POST'),onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Post(onAdd:(m)=>setState(()=>props.insert(0,m)))))):null,
      bottomNavigationBar: BottomNavigationBar(currentIndex:nav,onTap:(i)=>setState(()=>nav=i),type:BottomNavigationBarType.fixed,selectedItemColor:Color(0xFFFF385C),items:[
        BottomNavigationBarItem(icon:Icon(Icons.search),label:'Explore'),
        BottomNavigationBarItem(icon:Icon(Icons.favorite_border),label:'Wishlists'),
        BottomNavigationBarItem(icon:Icon(Icons.card_travel),label:'Trips'),
        BottomNavigationBarItem(icon:Icon(Icons.chat_bubble_outline),label:'Messages'),
        BottomNavigationBarItem(icon:Icon(Icons.person),label:'Profile'),
      ]),
    );
  }
}

class Explore extends StatelessWidget{
  final List props; final bool reg; final String gt; final VoidCallback onReg; final Function(Map<String,dynamic>) onAdd;
  Explore({required this.props,required this.reg,required this.gt,required this.onReg,required this.onAdd});
  @override Widget build(BuildContext c){
    return Scaffold(
      appBar: AppBar(title:Text('Pinas Paupa 🇵🇭 - ${props.length} listings'),backgroundColor:Color(0xFF2E7D32)),
      body: ListView(children:[
        Container(margin:EdgeInsets.all(15),padding:EdgeInsets.symmetric(horizontal:15),decoration:BoxDecoration(color:Color(0xFF2E7D32),borderRadius:BorderRadius.circular(15)),child:TextField(style:TextStyle(color:Colors.white),decoration:InputDecoration(icon:Icon(Icons.search,color:Colors.white),hintText:'Search Airbnb, House, Lot, Car, Food, Services...',hintStyle:TextStyle(color:Colors.white70),border:InputBorder.none))),
        InkWell(onTap:onReg,child:Container(margin:EdgeInsets.symmetric(horizontal:15),padding:EdgeInsets.all(14),decoration:BoxDecoration(color:reg?Color(0xFFE8F5E9):Color(0xFFFFF3E0),borderRadius:BorderRadius.circular(12),border:Border.all(color:reg?Colors.green:Colors.orange)),child:Row(children:[Icon(reg?Icons.verified:Icons.app_registration,color:reg?Colors.green:Colors.orange),SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(reg?'REGISTERED NA - $gt':'Wala pa ka naka-register! REGISTER NA!',style:TextStyle(fontWeight:FontWeight.bold)),Text('Auto commission sa GoTyme/GCash/BPI/BDO',style:TextStyle(fontSize:11))])),Container(padding:EdgeInsets.symmetric(horizontal:12,vertical:6),decoration:BoxDecoration(color:reg?Colors.green:Colors.orange,borderRadius:BorderRadius.circular(8)),child:Text(reg?'OK':'REGISTER',style:TextStyle(color:Colors.white)))]))),
        Padding(padding:EdgeInsets.all(15),child:Text('Pangitaon? - 8 Categories',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))),
        Padding(padding:EdgeInsets.symmetric(horizontal:10),child:GridView.count(crossAxisCount:2,shrinkWrap:true,physics:NeverScrollableScrollPhysics(),childAspectRatio:2.6,children:[
          _cat(c,'Airbnb',Icons.home,Color(0xFFFFEBEE),Colors.red),_cat(c,'House Rent',Icons.home_work,Color(0xFFE8F5E9),Colors.green),
          _cat(c,'House Sale',Icons.house,Color(0xFFE3F2FD),Colors.blue),_cat(c,'Lot Rent',Icons.terrain,Color(0xFFFFF3E0),Colors.orange),
          _cat(c,'Lot Sale',Icons.landscape,Color(0xFFEFEBE9),Colors.brown),_cat(c,'Rent Car',Icons.directions_car,Color(0xFFF3E5F5),Colors.purple),
          _cat(c,'Food',Icons.fastfood,Color(0xFFFBE9E7),Colors.deepOrange),_cat(c,'Services',Icons.build,Color(0xFFE0F2F1),Colors.teal),
        ])),
        Padding(padding:EdgeInsets.all(15),child:Text('Popular - ${props.length} listings',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold))),
        ...props.take(6).map((p){int com=(p['price']*0.15).toInt();return Card(margin:EdgeInsets.symmetric(horizontal:15,vertical:8),child:Column(children:[Stack(children:[Image.network(p['img'],height:180,width:double.infinity,fit:BoxFit.cover,errorBuilder:(a,b,c)=>Container(height:180,color:Colors.orange.shade100,child:Center(child:Icon(Icons.image,size:50)))),Positioned(top:8,left:8,child:Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:4),decoration:BoxDecoration(color:Colors.black54,borderRadius:BorderRadius.circular(8)),child:Text(p['cat'],style:TextStyle(color:Colors.white,fontSize:11))))]),ListTile(title:Text(p['title'],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${p['loc']} - ₱${p['price']} | Kita ₱$com')),Row(children:[Expanded(child:OutlinedButton(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Chat(owner:p['owner'],title:p['title']))),child:Text('Chat'))),SizedBox(width:8),Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>Pay(price:p['price'],com:com,gt:gt)),child:Text('Book')))])]));}).toList(),
        SizedBox(height:80),
      ]),
    );
  }
  Widget _cat(BuildContext c,String t,IconData i,Color bg,Color ic){var count=props.where((e)=>e['cat']==t).length;return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Cat(cat:t,props:props,gt:gt))),child:Container(margin:EdgeInsets.all(5),decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(12),border:Border.all(color:ic.withOpacity(0.4),width:2)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(i,color:ic,size:20),SizedBox(width:4),Text(t,style:TextStyle(fontWeight:FontWeight.bold,color:ic,fontSize:12))]),Text('$count listings',style:TextStyle(fontSize:10,color:ic))])));}
}

class RegSheet extends StatefulWidget{final VoidCallback onDone;RegSheet({required this.onDone});@override State<RegSheet> createState()=>_RS();}
class _RS extends State<RegSheet>{
  var email=TextEditingController();
  @override Widget build(BuildContext context){
    return Padding(padding:EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),child:Container(padding:EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,children:[
      Container(width:40,height:5,decoration:BoxDecoration(color:Colors.grey.shade300,borderRadius:BorderRadius.circular(5))),
      SizedBox(height:15),
      Icon(Icons.home_rounded,color:Color(0xFFFF385C),size:50),
      Text('Log in or sign up',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
      SizedBox(height:15),
      TextField(controller:email,decoration:InputDecoration(labelText:'Phone or email - Sonny@gmail.com',border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)))),
      SizedBox(height:15),
      SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF385C),padding:EdgeInsets.all(16)),onPressed:(){if(email.text.isNotEmpty) widget.onDone();},child:Text('Continue',style:TextStyle(color:Colors.white)))),
      SizedBox(height:10),
      Container(padding:EdgeInsets.all(12),decoration:BoxDecoration(color:Color(0xFFF5F5F5),borderRadius:BorderRadius.circular(12)),child:Column(children:[
        Row(children:[Icon(Icons.verified,color:Colors.green,size:16),SizedBox(width:6),Expanded(child:Text('Auto commission GoTyme/GCash/BPI/BDO - 15% per booking',style:TextStyle(fontSize:11,fontWeight:FontWeight.bold)))]),
        SizedBox(height:4),
        Row(children:[Icon(Icons.payment,color:Colors.orange,size:16),SizedBox(width:6),Expanded(child:Text('GCash, Maya, GoTyme, BPI, BDO, Metrobank',style:TextStyle(fontSize:11)))]),
      ])),
    ])));
  }
}

class Cat extends StatelessWidget{final String cat;final List props;final String gt;Cat({required this.cat,required this.props,required this.gt});@override Widget build(BuildContext c){var f=props.where((e)=>e['cat']==cat).toList();return Scaffold(appBar:AppBar(title:Text('$cat - ${f.length} listings'),backgroundColor:Color(0xFF2E7D32)),body:f.isEmpty?Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.search_off,size:60),Text('Wala pay $cat'),Text('Ikaw una mag post!',style:TextStyle(fontWeight:FontWeight.bold)),SizedBox(height:10),ElevatedButton(onPressed:()=>Navigator.pop(c),child:Text('Balik - Mag Post'))])):ListView.builder(itemCount:f.length,itemBuilder:(c,i){var p=f[i];return Card(margin:EdgeInsets.all(10),child:Column(children:[Stack(children:[Image.network(p['img'],height:180,width:double.infinity,fit:BoxFit.cover,errorBuilder:(a,b,cs)=>Container(height:180,color:Colors.grey.shade300,child:Icon(Icons.image,size:50))),Positioned(top:8,left:8,child:Container(padding:EdgeInsets.all(6),decoration:BoxDecoration(color:Colors.green,borderRadius:BorderRadius.circular(6)),child:Text(p['cat'],style:TextStyle(color:Colors.white,fontSize:10))))]),ListTile(title:Text(p['title'],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${p['loc']} - ₱${p['price']}')),Padding(padding:EdgeInsets.all(8),child:Row(children:[Expanded(child:OutlinedButton(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Chat(owner:p['owner'],title:p['title']))),child:Text('Chat ${p['owner']}'))),SizedBox(width:8),Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>Pay(price:p['price'],com:(p['price']*0.15).toInt(),gt:gt)),child:Text('Book')))]))])) ;}));}}
class Profile extends StatelessWidget{final String name;final bool isReg;final VoidCallback onReg;Profile({required this.name,required this.isReg,required this.onReg});@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Profile'),backgroundColor:Colors.white,foregroundColor:Colors.black),body:ListView(children:[Card(margin:EdgeInsets.all(20),child:Padding(padding:EdgeInsets.all(20),child:Column(children:[CircleAvatar(radius:40,backgroundColor:Colors.orange.shade100,child:Text(name[0],style:TextStyle(fontSize:30))),SizedBox(height:10),Text(name,style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text(isReg?'Verified Guest - Sonny SIMBAJON':'Guest - Wala pa ka naka-register'),if(!isReg)ElevatedButton(onPressed:onReg,child:Text('REGISTER NOW'))]))),Card(margin:EdgeInsets.all(15),child:ListTile(leading:Icon(Icons.person),title:Text('Become a host'),subtitle:Text('Earn extra income - Auto commission')))]));}}
class Chat extends StatefulWidget{final String owner,title;Chat({required this.owner,required this.title});@override State<Chat> createState()=>_CS();}
class _CS extends State<Chat>{List<String> msgs=[];var ctrl=TextEditingController();@override void initState(){super.initState();msgs=['Hello ${widget.owner}, available pa ang ${widget.title}?','Yes boss available pa! Pila ka days?'];}@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Chat ${widget.owner}')),body:Column(children:[Expanded(child:ListView.builder(itemCount:msgs.length,itemBuilder:(c,i)=>Align(alignment:i%2==0?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:EdgeInsets.all(8),padding:EdgeInsets.all(12),decoration:BoxDecoration(color:i%2==0?Color(0xFF2E7D32):Colors.grey.shade200,borderRadius:BorderRadius.circular(15)),child:Text(msgs[i]))))),Padding(padding:EdgeInsets.all(8),child:Row(children:[Expanded(child:TextField(controller:ctrl,decoration:InputDecoration(hintText:'Type message...',border:OutlineInputBorder(borderRadius:BorderRadius.circular(20))))),IconButton(icon:Icon(Icons.send,color:Color(0xFF2E7D32)),onPressed:(){if(ctrl.text.isNotEmpty){setState(()=>msgs.add(ctrl.text));ctrl.clear();Future.delayed(Duration(seconds:1),()=>setState(()=>msgs.add('Copy boss! Noted - ${widget.owner}')));}})]))])));}}
class Post extends StatefulWidget{final Function(Map<String,dynamic>) onAdd;Post({required this.onAdd});@override State<Post> createState()=>_PS();}
class _PS extends State<Post>{var t=TextEditingController();var pr=TextEditingController();var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600');String cat='House Rent';List<String> samples=['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600','https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=600','https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600','https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=600'];@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('MAG POST + PICTURE - All Categories')),body:Padding(padding:EdgeInsets.all(15),child:ListView(children:[Text('Pili ug sample picture:',style:TextStyle(fontWeight:FontWeight.bold)),SizedBox(height:90,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:samples.length,itemBuilder:(c,i)=>InkWell(onTap:()=>setState(()=>img.text=samples[i]),child:Container(margin:EdgeInsets.all(5),width:90,decoration:BoxDecoration(border:Border.all(color:img.text==samples[i]?Colors.orange:Colors.grey,width:3),borderRadius:BorderRadius.circular(8)),child:ClipRRect(borderRadius:BorderRadius.circular(5),child:Image.network(samples[i],fit:BoxFit.cover)))))),SizedBox(height:10),TextField(controller:img,decoration:InputDecoration(labelText:'Picture Link - Pwede mag paste',border:OutlineInputBorder())),SizedBox(height:8),Container(height:150,decoration:BoxDecoration(border:Border.all(color:Colors.grey),borderRadius:BorderRadius.circular(8)),child:Image.network(img.text,fit:BoxFit.cover,errorBuilder:(a,b,cc)=>Center(child:Text('Invalid image link - Pili sa taas')))),SizedBox(height:10),DropdownButton<String>(value:cat,isExpanded:true,items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>cat=v!)),TextField(controller:t,decoration:InputDecoration(labelText:'Title - Ex: Toyota Vios Rent',border:OutlineInputBorder())),SizedBox(height:8),TextField(controller:pr,decoration:InputDecoration(labelText:'Price - Ex: 2500',border:OutlineInputBorder()),keyboardType:TextInputType.number),SizedBox(height:15),SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.orange,padding:EdgeInsets.all(15)),onPressed:(){widget.onAdd({'title':t.text.isEmpty?'$cat - New':t.text,'price':int.tryParse(pr.text)??15000,'loc':'Davao','cat':cat,'owner':'Ikaw','img':img.text});Navigator.pop(c);ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('✅ Na-post na sa $cat!')));},child:Text('I-POST NA SA $cat!',style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white))))])));}}
class Pay extends StatelessWidget{final int price,com;final String gt;Pay({required this.price,required this.com,required this.gt});@override Widget build(BuildContext c){return Container(padding:EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.payment,size:40,color:Colors.green),Text('Bayad ₱$price',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text('Commission ₱$com AUTO sa $gt',style:TextStyle(color:Colors.green,fontWeight:FontWeight.bold)),SizedBox(height:10),Wrap(spacing:5,children:['GCash','Maya','GoTyme','BPI','BDO','Metrobank'].map((e)=>Chip(label:Text(e),backgroundColor:Colors.orange.shade100)).toList()),SizedBox(height:15),SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF2E7D32),padding:EdgeInsets.all(15)),onPressed:(){Navigator.pop(c);ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('✅ Bayad na! ₱$com AUTO sa $gt')));},child:Text('BAYARAN ₱$price',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold))))]));}}
