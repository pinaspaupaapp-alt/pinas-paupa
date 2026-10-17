import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(home:PinasPaupa(),debugShowCheckedModeBanner:false));

class PinasPaupa extends StatefulWidget{ @override State<PinasPaupa> createState()=>_S();}
class _S extends State<PinasPaupa>{
  int nav=0; bool reg=false; String gt='019812345678'; String gc='09123456789';
  List<Map<String,dynamic>> props=[
    {'title':'Modern Apartment Davao','loc':'Davao City','price':15000,'cat':'House Rent','owner':'Anna','img':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'},
    {'title':'Airbnb Makati 2BR','loc':'Makati','price':3000,'cat':'Airbnb','owner':'Mika','img':'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=800'},
    {'title':'House & Lot Davao','loc':'Davao','price':2500000,'cat':'House Sale','owner':'John','img':'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800'},
  ];
  void openReg(){
    showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(20))),builder:(_)=>RegSheet(onDone:(){setState(()=>reg=true);Navigator.pop(context);}));
  }
  @override Widget build(BuildContext c){
    List<Widget> pages=[
      Explore(props:props,reg:reg,gt:gt,gc:gc,onReg:openReg,onAdd:(m)=>setState(()=>props.insert(0,m))),
      Center(child:Text('Wishlists - Empty')),
      Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.map,size:60,color:Colors.orange),Text('Trips - Map out your next trip',style:TextStyle(fontWeight:FontWeight.bold))])), 
      Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.chat_bubble,size:60,color:Colors.blue),Text('Messages'),Text('Nothing to see here')])),
      Profile(name:reg?'Sonny SIMBAJON':'Guest',isReg:reg,onReg:openReg),
    ];
    return Scaffold(
      backgroundColor:Color(0xFFFDF2F8),
      body:pages[nav],
      floatingActionButton: nav==0?FloatingActionButton.extended(backgroundColor:Color(0xFFFF6B00),icon:Icon(Icons.add_a_photo),label:Text('MAG POST'),onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Post(onAdd:(m)=>setState(()=>props.insert(0,m)))))):null,
      bottomNavigationBar:BottomNavigationBar(currentIndex:nav,onTap:(i)=>setState(()=>nav=i),type:BottomNavigationBarType.fixed,selectedItemColor:Color(0xFFFF385C),items:[
        BottomNavigationBarItem(icon:Icon(Icons.search),label:'Explore'),
        BottomNavigationBarItem(icon:Icon(Icons.favorite_border),label:'Wishlists'),
        BottomNavigationBarItem(icon:Icon(Icons.card_travel),label:'Trips'),
        BottomNavigationBarItem(icon:Icon(Icons.message_outlined),label:'Messages'),
        BottomNavigationBarItem(icon:Icon(Icons.person_outline),label:'Profile'),
      ]),
    );
  }
}

class Explore extends StatelessWidget{
  final List props; final bool reg; final String gt,gc; final VoidCallback onReg; final Function(Map<String,dynamic>) onAdd;
  Explore({required this.props,required this.reg,required this.gt,required this.gc,required this.onReg,required this.onAdd});
  @override Widget build(BuildContext c){
    return ListView(children:[
      AppBar(title:Text('Pinas Paupa 🇵🇭'),backgroundColor:Color(0xFF2E7D32)),
      Container(margin:EdgeInsets.all(15),padding:EdgeInsets.symmetric(horizontal:15),decoration:BoxDecoration(color:Color(0xFF2E7D32),borderRadius:BorderRadius.circular(15)),child:TextField(style:TextStyle(color:Colors.white),decoration:InputDecoration(icon:Icon(Icons.search,color:Colors.white),hintText:'Search Airbnb, House, Lot...',hintStyle:TextStyle(color:Colors.white70),border:InputBorder.none))),
      InkWell(onTap:onReg,child:Container(margin:EdgeInsets.symmetric(horizontal:15),padding:EdgeInsets.all(14),decoration:BoxDecoration(color:reg?Color(0xFFE8F5E9):Color(0xFFFFF3E0),borderRadius:BorderRadius.circular(12),border:Border.all(color:reg?Colors.green:Colors.orange)),child:Row(children:[Icon(reg?Icons.verified:Icons.app_registration,color:reg?Colors.green:Colors.orange,size:32),SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(reg?'REGISTERED NA - $gt':'Wala pa ka naka-register!',style:TextStyle(fontWeight:FontWeight.bold)),Text(reg?'Auto commission GoTyme/GCash':'I-register para auto commission',style:TextStyle(fontSize:11))])),Container(padding:EdgeInsets.symmetric(horizontal:15,vertical:8),decoration:BoxDecoration(color:reg?Colors.green:Colors.orange,borderRadius:BorderRadius.circular(8)),child:Text(reg?'OK':'REGISTER',style:TextStyle(color:Colors.white)))]))),
      Padding(padding:EdgeInsets.all(15),child:Text('Pangitaon?',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold))),
      Padding(padding:EdgeInsets.symmetric(horizontal:10),child:GridView.count(crossAxisCount:2,shrinkWrap:true,physics:NeverScrollableScrollPhysics(),childAspectRatio:2.6,children:[
        _cat(c,'Airbnb',Icons.home,Color(0xFFFFEBEE),Colors.red),_cat(c,'House Rent',Icons.home_work,Color(0xFFE8F5E9),Colors.green),
        _cat(c,'House Sale',Icons.house,Color(0xFFE3F2FD),Colors.blue),_cat(c,'Lot Rent',Icons.terrain,Color(0xFFFFF3E0),Colors.orange),
        _cat(c,'Lot Sale',Icons.landscape,Color(0xFFEFEBE9),Colors.brown),_cat(c,'Rent Car',Icons.directions_car,Color(0xFFF3E5F5),Colors.purple),
        _cat(c,'Food',Icons.fastfood,Color(0xFFFBE9E7),Colors.deepOrange),_cat(c,'Services',Icons.build,Color(0xFFE0F2F1),Colors.teal),
      ])),
      Padding(padding:EdgeInsets.all(15),child:Text('Popular',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold))),
      ...props.map((p){int com=(p['price']*0.15).toInt();return Card(margin:EdgeInsets.symmetric(horizontal:15,vertical:8),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),child:Column(children:[ClipRRect(borderRadius:BorderRadius.vertical(top:Radius.circular(15)),child:Image.network(p['img'],height:180,width:double.infinity,fit:BoxFit.cover,errorBuilder:(a,b,c)=>Container(height:180,color:Colors.grey,child:Icon(Icons.image)))),ListTile(title:Text(p['title'],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${p['loc']} - ₱${p['price']} | Kita ₱$com')),Padding(padding:EdgeInsets.all(10),child:Row(children:[Expanded(child:OutlinedButton.icon(icon:Icon(Icons.chat),label:Text('Chat'),onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Chat(owner:p['owner'],title:p['title']))))),SizedBox(width:8),Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>Pay(price:p['price'],com:com,gt:gt,gc:gc)),child:Text('Book')))]))])) ;}).toList(),
      SizedBox(height:80),
    ]);
  }
  Widget _cat(BuildContext c,String t,IconData i,Color bg,Color ic){return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Cat(cat:t,props:props,gt:gt,gc:gc))),child:Container(margin:EdgeInsets.all(5),decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(12),border:Border.all(color:ic.withOpacity(0.4),width:2)),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(i,color:ic),SizedBox(width:8),Flexible(child:Text(t,style:TextStyle(fontWeight:FontWeight.bold,color:ic),overflow:TextOverflow.ellipsis))])));}
}

class RegSheet extends StatefulWidget{final VoidCallback onDone;RegSheet({required this.onDone});@override State<RegSheet> createState()=>_RS();}
class _RS extends State<RegSheet>{
  var email=TextEditingController();
  @override Widget build(BuildContext context){
    return Padding(padding:EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),child:Container(padding:EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,children:[
      Container(width:40,height:5,decoration:BoxDecoration(color:Colors.grey.shade300,borderRadius:BorderRadius.circular(5))),
      SizedBox(height:15),
      Icon(Icons.home_rounded,color:Color(0xFFFF385C),size:50),
      SizedBox(height:10),
      Text('Log in or sign up',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
      SizedBox(height:15),
      TextField(controller:email,decoration:InputDecoration(labelText:'Phone or email - Ex: Sonny@gmail.com',border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)))),
      SizedBox(height:15),
      SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF385C),padding:EdgeInsets.all(16),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),onPressed:(){if(email.text.isNotEmpty){widget.onDone();ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('✅ REGISTERED NA!')));} },child:Text('Continue',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)))),
      SizedBox(height:10),
      Text('We will confirm by text or email. Privacy Policy',style:TextStyle(fontSize:11,color:Colors.grey)),
      SizedBox(height:15),
      Row(children:[Expanded(child:Divider()),Padding(padding:EdgeInsets.symmetric(horizontal:10),child:Text('or')),Expanded(child:Divider())]),
      SizedBox(height:10),
      Row(mainAxisAlignment:MainAxisAlignment.center,children:[OutlinedButton(onPressed:widget.onDone,child:Text('G')),SizedBox(width:10),OutlinedButton(onPressed:widget.onDone,child:Icon(Icons.apple))]),
      SizedBox(height:15),
      Container(padding:EdgeInsets.all(12),decoration:BoxDecoration(color:Color(0xFFF5F5F5),borderRadius:BorderRadius.circular(12)),child:Column(children:[
        Row(children:[Icon(Icons.verified,color:Colors.green,size:18),SizedBox(width:6),Expanded(child:Text('Auto commission sa GoTyme/GCash/BPI/BDO - 15%',style:TextStyle(fontWeight:FontWeight.bold,fontSize:12)))]),
        SizedBox(height:6),
        Row(children:[Icon(Icons.payment,color:Colors.orange,size:18),SizedBox(width:6),Expanded(child:Text('GCash, Maya, GoTyme, BPI, BDO, Metrobank',style:TextStyle(fontSize:11)))]),
      ])),
      SizedBox(height:10),
    ])));
  }
}

class Cat extends StatelessWidget{final String cat;final List props;final String gt,gc;Cat({required this.cat,required this.props,required this.gt,required this.gc});@override Widget build(BuildContext c){var f=props.where((e)=>e['cat']==cat).toList();return Scaffold(appBar:AppBar(title:Text('$cat'),backgroundColor:Color(0xFF2E7D32)),body:f.isEmpty?Center(child:Text('Wala pay $cat - Ikaw una mag post!')):ListView.builder(itemCount:f.length,itemBuilder:(c,i){var p=f[i];return Card(margin:EdgeInsets.all(10),child:Column(children:[Image.network(p['img'],height:180,width:double.infinity,fit:BoxFit.cover),ListTile(title:Text(p['title']),subtitle:Text('₱${p['price']}')),Row(children:[Expanded(child:OutlinedButton(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Chat(owner:p['owner'],title:p['title']))),child:Text('Chat'))),Expanded(child:ElevatedButton(onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>Pay(price:p['price'],com:(p['price']*0.15).toInt(),gt:gt,gc:gc)),child:Text('Book')))])]));}));}}
class Profile extends StatelessWidget{final String name;final bool isReg;final VoidCallback onReg;Profile({required this.name,required this.isReg,required this.onReg});@override Widget build(BuildContext c){return ListView(children:[AppBar(title:Text('Profile'),backgroundColor:Colors.white,foregroundColor:Colors.black),Card(margin:EdgeInsets.all(20),child:Padding(padding:EdgeInsets.all(20),child:Column(children:[CircleAvatar(radius:40,backgroundColor:Colors.pink.shade100,child:Text(name[0],style:TextStyle(fontSize:30))),SizedBox(height:10),Text(name,style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text(isReg?'Verified - Sonny SIMBAJON':'Guest'),if(!isReg)SizedBox(height:10),if(!isReg)ElevatedButton(onPressed:onReg,child:Text('REGISTER NOW'))]))),Card(margin:EdgeInsets.symmetric(horizontal:15),child:ListTile(leading:Icon(Icons.person),title:Text('Become a host'),subtitle:Text('Earn extra income')))]);}}
class Chat extends StatefulWidget{final String owner,title;Chat({required this.owner,required this.title});@override State<Chat> createState()=>_CS();}
class _CS extends State<Chat>{List<String> msgs=[];var ctrl=TextEditingController();@override void initState(){super.initState();msgs=['Hello ${widget.owner}, available pa ${widget.title}?','Yes boss available!'];}@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Chat ${widget.owner}')),body:Column(children:[Expanded(child:ListView.builder(itemCount:msgs.length,itemBuilder:(c,i)=>Align(alignment:i%2==0?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:EdgeInsets.all(8),padding:EdgeInsets.all(12),decoration:BoxDecoration(color:i%2==0?Color(0xFF2E7D32):Colors.grey.shade200,borderRadius:BorderRadius.circular(15)),child:Text(msgs[i]))))),Padding(padding:EdgeInsets.all(10),child:Row(children:[Expanded(child:TextField(controller:ctrl,decoration:InputDecoration(hintText:'Type...',border:OutlineInputBorder()))),IconButton(icon:Icon(Icons.send),onPressed:(){if(ctrl.text.isNotEmpty){setState(()=>msgs.add(ctrl.text));ctrl.clear();}})]))])));}}
class Post extends StatefulWidget{final Function(Map<String,dynamic>) onAdd;Post({required this.onAdd});@override State<Post> createState()=>_PS();}
class _PS extends State<Post>{var t=TextEditingController();var pr=TextEditingController();var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800');String cat='House Rent';List<String> samples=['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=800','https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800'];@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('MAG POST + PICTURE')),body:Padding(padding:EdgeInsets.all(15),child:ListView(children:[SizedBox(height:90,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:samples.length,itemBuilder:(c,i)=>InkWell(onTap:()=>setState(()=>img.text=samples[i]),child:Container(margin:EdgeInsets.all(5),width:90,decoration:BoxDecoration(border:Border.all(color:img.text==samples[i]?Colors.orange:Colors.grey,width:3)),child:Image.network(samples[i],fit:BoxFit.cover))))),TextField(controller:img,decoration:InputDecoration(labelText:'Picture Link')),SizedBox(height:8),Image.network(img.text,height:130,fit:BoxFit.cover,errorBuilder:(a,b,c)=>Container(height:130,color:Colors.grey)),DropdownButton<String>(value:cat,isExpanded:true,items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>cat=v!)),TextField(controller:t,decoration:InputDecoration(labelText:'Title')),TextField(controller:pr,decoration:InputDecoration(labelText:'Price'),keyboardType:TextInputType.number),SizedBox(height:10),ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.orange),onPressed:(){widget.onAdd({'title':t.text.isEmpty?'New Post':t.text,'price':int.tryParse(pr.text)??15000,'loc':'Davao','cat':cat,'owner':'Ikaw','img':img.text});Navigator.pop(c);},child:Text('I-POST NA!'))])));}}
class Pay extends StatelessWidget{final int price,com;final String gt,gc;Pay({required this.price,required this.com,required this.gt,required this.gc});@override Widget build(BuildContext c){return Container(padding:EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,children:[Text('Bayad ₱$price Commission ₱$com AUTO $gt/$gc',style:TextStyle(fontWeight:FontWeight.bold)),Wrap(spacing:5,children:['GCash','Maya','GoTyme','BPI','BDO','Metrobank'].map((e)=>Chip(label:Text(e))).toList()),SizedBox(height:10),SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.orange),onPressed:(){Navigator.pop(c);ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('✅ Bayad na!')));},child:Text('BAYARAN ₱$price')))]));}}
