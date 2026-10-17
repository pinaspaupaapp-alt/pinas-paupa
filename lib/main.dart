import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(home:PinasPaupa(),debugShowCheckedModeBanner:false));

class PinasPaupa extends StatefulWidget{ @override State<PinasPaupa> createState()=>_S();}
class _S extends State<PinasPaupa>{
  int nav=0; bool reg=false; String gt='019812345678';
  List<Map<String,dynamic>> props=[
    {'title':'Modern Apartment Davao','loc':'Davao City','price':15000,'cat':'House Rent','owner':'Anna','img':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600'},
    {'title':'Airbnb Makati 2BR','loc':'Makati','price':3000,'cat':'Airbnb','owner':'Mika','img':'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=600'},
    {'title':'House & Lot Davao','loc':'Davao','price':2500000,'cat':'House Sale','owner':'John','img':'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=600'},
    {'title':'500 sqm Lot Davao','loc':'Mintal','price':800000,'cat':'Lot Sale','owner':'Lot Owner','img':'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600'},
    {'title':'Commercial Lot Rent','loc':'Davao','price':20000,'cat':'Lot Rent','owner':'Commercial','img':'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600'},
    {'title':'Toyota Vios Rent','loc':'Davao','price':2500,'cat':'Rent Car','owner':'Car Owner','img':'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600'},
    {'title':'Lechon Package','loc':'Davao','price':5000,'cat':'Food','owner':'Lechon Queen','img':'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600'},
    // SERVICES - FULL HOME SERVICE LIST - 12 NA KABUOK!
    {'title':'Plumbing / Tubero 24/7','loc':'Davao','price':800,'cat':'Services','owner':'Tubero Boy','img':'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=600'},
    {'title':'Aircon Cleaning & Repair','loc':'Davao','price':1200,'cat':'Services','owner':'Aircon Tech','img':'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=600'},
    {'title':'House Cleaning Service','loc':'Davao','price':1000,'cat':'Services','owner':'Clean House','img':'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=600'},
    {'title':'Electrical - Electrician','loc':'Davao','price':700,'cat':'Services','owner':'Electrician','img':'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=600'},
    {'title':'Renovation & Construction','loc':'Davao','price':5000,'cat':'Services','owner':'Foreman','img':'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=600'},
    {'title':'Mechanic - Auto Repair','loc':'Davao','price':800,'cat':'Services','owner':'Mechanic','img':'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=600'},
    {'title':'Manicure Pedicure Home Service','loc':'Davao','price':500,'cat':'Services','owner':'Nail Tech','img':'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=600'},
    {'title':'Massage Home Service','loc':'Davao','price':600,'cat':'Services','owner':'Massage Therapist','img':'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=600'},
    {'title':'Laundry Home Service','loc':'Davao','price':300,'cat':'Services','owner':'Laundry Queen','img':'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=600'},
    {'title':'Gardening & Landscaping','loc':'Davao','price':800,'cat':'Services','owner':'Gardener','img':'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=600'},
    {'title':'Painting Service','loc':'Davao','price':1500,'cat':'Services','owner':'Painter','img':'https://images.unsplash.com/photo-1562259949-e8e7689d7828?w=600'},
    {'title':'Welding & Steel Works','loc':'Davao','price':1200,'cat':'Services','owner':'Welder','img':'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?w=600'},
  ];

  void openReg(){showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(20))),builder:(_)=>RegSheet(onDone:(){setState(()=>reg=true);Navigator.pop(context);}));}

  @override Widget build(BuildContext c){
    List<String> titles=['Pinas Paupa 🇵🇭','Wishlists','Trips','Messages','Profile'];
    return Scaffold(
      appBar:AppBar(title:Text(titles[nav]),backgroundColor:Color(0xFF2E7D32)),
      body: nav==0 ? ExploreContent(props:props,reg:reg,gt:gt,onReg:openReg) : nav==1 ? Center(child:Text('Wishlists')) : nav==2 ? Center(child:Text('Trips')) : nav==3 ? Center(child:Text('Messages')) : ProfileContent(name:reg?'Sonny SIMBAJON':'Guest',isReg:reg,onReg:openReg),
      floatingActionButton: nav==0 ? FloatingActionButton.extended(backgroundColor:Color(0xFFFF6B00),icon:Icon(Icons.add_a_photo),label:Text('MAG POST'),onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>PostPage(onAdd:(m)=>setState(()=>props.insert(0,m)))))) : null,
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

class ExploreContent extends StatelessWidget{
  final List props; final bool reg; final String gt; final VoidCallback onReg;
  ExploreContent({required this.props,required this.reg,required this.gt,required this.onReg});
  @override Widget build(BuildContext c){
    return ListView(children:[
      Container(margin:EdgeInsets.all(15),padding:EdgeInsets.symmetric(horizontal:15),decoration:BoxDecoration(color:Color(0xFF2E7D32),borderRadius:BorderRadius.circular(15)),child:TextField(style:TextStyle(color:Colors.white),decoration:InputDecoration(icon:Icon(Icons.search,color:Colors.white),hintText:'Search...',hintStyle:TextStyle(color:Colors.white70),border:InputBorder.none))),
      InkWell(onTap:onReg,child:Container(margin:EdgeInsets.symmetric(horizontal:15),padding:EdgeInsets.all(14),decoration:BoxDecoration(color:reg?Color(0xFFE8F5E9):Color(0xFFFFF3E0),borderRadius:BorderRadius.circular(12),border:Border.all(color:reg?Colors.green:Colors.orange)),child:Row(children:[Icon(reg?Icons.verified:Icons.app_registration,color:reg?Colors.green:Colors.orange),SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(reg?'REGISTERED NA':'Wala pa ka naka-register!'),Text('Auto commission GoTyme/GCash - 15%',style:TextStyle(fontSize:11))])),Container(padding:EdgeInsets.symmetric(horizontal:12,vertical:6),decoration:BoxDecoration(color:reg?Colors.green:Colors.orange,borderRadius:BorderRadius.circular(8)),child:Text(reg?'OK':'REGISTER',style:TextStyle(color:Colors.white)))]))),
      Padding(padding:EdgeInsets.all(15),child:Text('Pangitaon? - 8 Categories',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold))),
      Padding(padding:EdgeInsets.symmetric(horizontal:10),child:GridView.count(crossAxisCount:2,shrinkWrap:true,physics:NeverScrollableScrollPhysics(),childAspectRatio:2.6,children:[
        _cat(c,'Airbnb',Icons.home,Color(0xFFFFEBEE),Colors.red),_cat(c,'House Rent',Icons.home_work,Color(0xFFE8F5E9),Colors.green),
        _cat(c,'House Sale',Icons.house,Color(0xFFE3F2FD),Colors.blue),_cat(c,'Lot Rent',Icons.terrain,Color(0xFFFFF3E0),Colors.orange),
        _cat(c,'Lot Sale',Icons.landscape,Color(0xFFEFEBE9),Colors.brown),_cat(c,'Rent Car',Icons.directions_car,Color(0xFFF3E5F5),Colors.purple),
        _cat(c,'Food',Icons.fastfood,Color(0xFFFBE9E7),Colors.deepOrange),_cat(c,'Services',Icons.build,Color(0xFFE0F2F1),Colors.teal),
      ])),
      Padding(padding:EdgeInsets.all(15),child:Text('Popular - ${props.length} listings',style:TextStyle(fontWeight:FontWeight.bold))),
      ...props.take(6).map((p){int com=(p['price']*0.15).toInt();return Card(margin:EdgeInsets.symmetric(horizontal:15,vertical:8),child:Column(children:[Image.network(p['img'],height:160,width:double.infinity,fit:BoxFit.cover,errorBuilder:(a,b,cc)=>Container(height:160,color:Colors.grey.shade300,child:Icon(Icons.image))),ListTile(title:Text(p['title'],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${p['loc']} - ₱${p['price']} | Kita ₱$com')),Row(children:[Expanded(child:OutlinedButton(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ChatPage(owner:p['owner'],title:p['title']))),child:Text('Chat'))),SizedBox(width:8),Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>PaySheet(price:p['price'],com:com,gt:gt)),child:Text('Book')))])]));}).toList(),
    ]);
  }
  Widget _cat(BuildContext c,String t,IconData i,Color bg,Color ic){var count=props.where((e)=>e['cat']==t).length;return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>CatPage(cat:t,props:props,gt:gt))),child:Container(margin:EdgeInsets.all(5),decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(12),border:Border.all(color:ic.withOpacity(0.4))),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(i,color:ic,size:16),SizedBox(width:4),Text(t,style:TextStyle(fontWeight:FontWeight.bold,color:ic,fontSize:11))]),Text('$count listings',style:TextStyle(fontSize:9,color:ic))])));}
}

// REGISTER WITH OTP - 2 STEPS!
class RegSheet extends StatefulWidget{final VoidCallback onDone;RegSheet({required this.onDone});@override State<RegSheet> createState()=>_RS;}
class _RS extends State<RegSheet>{
  int step=0;
  var email=TextEditingController(text:'reysimbajon1982@gmail.com');
  var otp=TextEditingController();
  int seconds=60;
  @override void initState(){super.initState(); _startTimer();}
  void _startTimer(){Future.delayed(Duration(seconds:1),(){if(mounted && step==1 && seconds>0){setState(()=>seconds--);_startTimer();}});}

  @override Widget build(BuildContext context){
    return Padding(padding:EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),child:Container(padding:EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,children:[
      Container(width:40,height:5,decoration:BoxDecoration(color:Colors.grey.shade300,borderRadius:BorderRadius.circular(5))),
      SizedBox(height:15),
      Icon(Icons.home_rounded,color:Color(0xFFFF385C),size:50),
      if(step==0)...[
        Text('Log in or sign up',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
        SizedBox(height:15),
        TextField(controller:email,decoration:InputDecoration(labelText:'Phone or email',border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)))),
        SizedBox(height:15),
        SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF385C),padding:EdgeInsets.all(16)),onPressed:(){setState(()=>step=1);seconds=60;_startTimer();},child:Text('Continue',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)))),
        SizedBox(height:10),
        Container(padding:EdgeInsets.all(12),decoration:BoxDecoration(color:Color(0xFFF5F5F5),borderRadius:BorderRadius.circular(12)),child:Column(children:[
          Row(children:[Icon(Icons.verified,color:Colors.green,size:16),SizedBox(width:6),Expanded(child:Text('Auto commission GoTyme/GCash - 15%',style:TextStyle(fontSize:11,fontWeight:FontWeight.bold)))]),
          Row(children:[Icon(Icons.payment,color:Colors.orange,size:16),SizedBox(width:6),Expanded(child:Text('GCash, Maya, GoTyme, BPI, BDO, Metrobank',style:TextStyle(fontSize:11)))]),
        ])),
      ] else ...[
        Text('Confirm your number',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
        SizedBox(height:10),
        Text('Enter the code we sent over SMS to ${email.text}. Code expires in $seconds seconds.',style:TextStyle(fontSize:13),textAlign:TextAlign.center),
        SizedBox(height:15),
        TextField(controller:otp,keyboardType:TextInputType.number,maxLength:6,decoration:InputDecoration(labelText:'Enter 6-digit OTP - Ex: 123456',border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),hintText:'123456'),textAlign:TextAlign.center,style:TextStyle(fontSize:20,letterSpacing:8)),
        SizedBox(height:10),
        Row(children:[
          TextButton(onPressed:(){setState(()=>seconds=60);_startTimer();ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('OTP resent to ${email.text}')));},child:Text('Resend code ($seconds)')),
          Spacer(),
          ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.black),onPressed:(){if(otp.text.length>=4){widget.onDone();ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('✅ Verified! Registered na!')));} else {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Enter OTP - 6 digits')));}},child:Text('Verify & Register',style:TextStyle(color:Colors.white))),
        ]),
        SizedBox(height:10),
        Text('Direct register after OTP - Auto commission sa GoTyme/GCash/BPI/BDO',style:TextStyle(fontSize:11,color:Colors.grey),textAlign:TextAlign.center),
      ]
    ])));
  }
}

class CatPage extends StatelessWidget{final String cat;final List props;final String gt;CatPage({required this.cat,required this.props,required this.gt});@override Widget build(BuildContext c){var f=props.where((e)=>e['cat']==cat).toList();return Scaffold(appBar:AppBar(title:Text('$cat - ${f.length} listings'),backgroundColor:Color(0xFF2E7D32)),body:ListView.builder(itemCount:f.length,itemBuilder:(c,i){var p=f[i];return Card(margin:EdgeInsets.all(10),child:Column(children:[Image.network(p['img'],height:180,width:double.infinity,fit:BoxFit.cover,errorBuilder:(a,b,cc)=>Container(height:180,color:Colors.grey.shade300)),ListTile(title:Text(p['title'],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${p['loc']} - ₱${p['price']}')),Row(children:[Expanded(child:OutlinedButton(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ChatPage(owner:p['owner'],title:p['title']))),child:Text('Chat'))),SizedBox(width:8),Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>PaySheet(price:p['price'],com:(p['price']*0.15).toInt(),gt:gt)),child:Text('Book')))])]));}));}}
class ProfileContent extends StatelessWidget{final String name;final bool isReg;final VoidCallback onReg;ProfileContent({required this.name,required this.isReg,required this.onReg});@override Widget build(BuildContext c){return ListView(children:[Card(margin:EdgeInsets.all(20),child:Padding(padding:EdgeInsets.all(20),child:Column(children:[CircleAvatar(radius:40,child:Text(name[0])),Text(name,style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),if(!isReg)ElevatedButton(onPressed:onReg,child:Text('REGISTER NOW - With OTP'))])))]);}}
class ChatPage extends StatefulWidget{final String owner,title;ChatPage({required this.owner,required this.title});@override State<ChatPage> createState()=>_CS();}
class _CS extends State<ChatPage>{List<String> msgs=[];var ctrl=TextEditingController();@override void initState(){super.initState();msgs=['Hello ${widget.owner}, available pa?','Yes boss available!'];}@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Chat ${widget.owner}')),body:Column(children:[Expanded(child:ListView.builder(itemCount:msgs.length,itemBuilder:(c,i)=>Align(alignment:i%2==0?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:EdgeInsets.all(8),padding:EdgeInsets.all(12),decoration:BoxDecoration(color:i%2==0?Color(0xFF2E7D32):Colors.grey.shade200,borderRadius:BorderRadius.circular(15)),child:Text(msgs[i]))))),Row(children:[Expanded(child:TextField(controller:ctrl,decoration:InputDecoration(hintText:'Type...',border:OutlineInputBorder()))),IconButton(icon:Icon(Icons.send),onPressed:(){if(ctrl.text.isNotEmpty){setState(()=>msgs.add(ctrl.text));ctrl.clear();}})])]));}}
class PostPage extends StatefulWidget{final Function(Map<String,dynamic>) onAdd;PostPage({required this.onAdd});@override State<PostPage> createState()=>_PS();}
class _PS extends State<PostPage>{
  var t=TextEditingController();var pr=TextEditingController();var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600');String cat='House Rent';
  List<String> samples=['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600','https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=600','https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600','https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=600','https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=600'];
  @override Widget build(BuildContext c){
    return Scaffold(appBar:AppBar(title:Text('MAG POST + PICTURE')),
      body:Padding(padding:EdgeInsets.all(15),child:ListView(children:[
        Text('Pili ug sample picture - Click:',style:TextStyle(fontWeight:FontWeight.bold)),
        SizedBox(height:90,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:samples.length,itemBuilder:(c,i)=>InkWell(onTap:()=>setState(()=>img.text=samples[i]),child:Container(margin:EdgeInsets.all(5),width:90,decoration:BoxDecoration(border:Border.all(color:img.text==samples[i]?Colors.orange:Colors.grey,width:3),borderRadius:BorderRadius.circular(8)),child:ClipRRect(borderRadius:BorderRadius.circular(5),child:Image.network(samples[i],fit:BoxFit.cover,errorBuilder:(a,b,cc)=>Container(color:Colors.grey))))))),
        SizedBox(height:10),
        TextField(controller:img,decoration:InputDecoration(labelText:'Picture Link',border:OutlineInputBorder()),onChanged:(v)=>setState((){})),
        SizedBox(height:8),
        Container(height:150,decoration:BoxDecoration(border:Border.all(color:Colors.grey),borderRadius:BorderRadius.circular(8)),child:Image.network(img.text,fit:BoxFit.cover,width:double.infinity,errorBuilder:(a,b,cc)=>Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.image,size:40,color:Colors.grey),Text('Picture preview - Pili sa taas para makita')])))),
        SizedBox(height:10),
        DropdownButton<String>(value:cat,isExpanded:true,items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>cat=v!)),
        TextField(controller:t,decoration:InputDecoration(labelText:'Title - Ex: Tubero Service',border:OutlineInputBorder())),
        SizedBox(height:8),
        TextField(controller:pr,decoration:InputDecoration(labelText:'Price',border:OutlineInputBorder()),keyboardType:TextInputType.number),
        SizedBox(height:10),
        ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.orange,padding:EdgeInsets.all(15)),onPressed:(){widget.onAdd({'title':t.text.isEmpty?'$cat - New':t.text,'price':int.tryParse(pr.text)??800,'loc':'Davao','cat':cat,'owner':'Ikaw','img':img.text});Navigator.pop(c);},child:Text('I-POST NA!')),
      ])));
  }
}
class PaySheet extends StatelessWidget{final int price,com;final String gt;PaySheet({required this.price,required this.com,required this.gt});@override Widget build(BuildContext c){return Container(padding:EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,children:[Text('Bayad ₱$price Commission ₱$com AUTO $gt',style:TextStyle(fontWeight:FontWeight.bold)),Wrap(spacing:5,children:['GCash','Maya','GoTyme','BPI','BDO','Metrobank'].map((e)=>Chip(label:Text(e))).toList()),ElevatedButton(onPressed:(){Navigator.pop(c);ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('✅ Bayad na!')));},child:Text('BAYARAN ₱$price'))]));}}
