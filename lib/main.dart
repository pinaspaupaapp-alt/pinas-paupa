import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(home:PinasPaupa(),debugShowCheckedModeBanner:false));

class PinasPaupa extends StatefulWidget{ @override State<PinasPaupa> createState()=>_S();}
class _S extends State<PinasPaupa>{
  int navIndex=0;
  bool reg=false;
  String gt='019812345678'; String gc='09123456789';
  List<Map<String,dynamic>> props=[
    {'title':'Modern Apartment Davao','loc':'Davao City','price':15000,'cat':'House Rent','owner':'Anna','img':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'},
    {'title':'Airbnb Makati 2BR','loc':'Makati','price':3000,'cat':'Airbnb','owner':'Mika','img':'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=800'},
    {'title':'House & Lot Davao','loc':'Davao','price':2500000,'cat':'House Sale','owner':'John','img':'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800'},
  ];

  void openRegister(){showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(20))),builder:(_)=>RegisterSheet(onDone:(){setState(()=>reg=true);Navigator.pop(context);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('✅ REGISTERED NA! Auto commission sa $gt/$gc')));})));}

  @override Widget build(BuildContext c){
    List<Widget> pages=[
      ExplorePage(props:props,reg:reg,gt:gt,gc:gc,onRegister:openRegister,onAdd:(m)=>setState(()=>props.insert(0,m))),
      Center(child:Text('Wishlists - Wala pay na-save')),
      TripsPage(),
      MessagesPage(),
      ProfilePage(name: reg?'Sonny':'Guest', isReg: reg, onRegister: openRegister),
    ];
    return Scaffold(
      backgroundColor:Color(0xFFFDF2F8),
      body: pages[navIndex],
      floatingActionButton: navIndex==0?FloatingActionButton.extended(backgroundColor:Color(0xFFFF6B00),icon:Icon(Icons.add_a_photo),label:Text('MAG POST'),onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Post(onAdd:(m)=>setState(()=>props.insert(0,m)))))):null,
      bottomNavigationBar: BottomNavigationBar(currentIndex:navIndex,onTap:(i)=>setState(()=>navIndex=i),type:BottomNavigationBarType.fixed,selectedItemColor:Color(0xFFFF385C),unselectedItemColor:Colors.grey,items:[
        BottomNavigationBarItem(icon:Icon(Icons.search),label:'Explore'),
        BottomNavigationBarItem(icon:Icon(Icons.favorite_border),label:'Wishlists'),
        BottomNavigationBarItem(icon:Icon(Icons.card_travel),label:'Trips'),
        BottomNavigationBarItem(icon:Icon(Icons.chat_bubble_outline),label:'Messages'),
        BottomNavigationBarItem(icon:Icon(Icons.person),label:'Profile'),
      ]),
    );
  }
}

class ExplorePage extends StatelessWidget{
  final List props; final bool reg; final String gt,gc; final VoidCallback onRegister; final Function(Map<String,dynamic>) onAdd;
  ExplorePage({required this.props,required this.reg,required this.gt,required this.gc,required this.onRegister,required this.onAdd});
  @override Widget build(BuildContext c){
    return CustomScrollView(slivers:[
      SliverAppBar(pinned:true,backgroundColor:Color(0xFF2E7D32),title:Text('Pinas Paupa 🇵🇭')),
      SliverToBoxAdapter(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(margin:EdgeInsets.all(15),padding:EdgeInsets.symmetric(horizontal:15),decoration:BoxDecoration(color:Color(0xFF2E7D32),borderRadius:BorderRadius.circular(15)),child:TextField(style:TextStyle(color:Colors.white),decoration:InputDecoration(icon:Icon(Icons.search,color:Colors.white),hintText:'Search Airbnb, House, Lot, Services...',hintStyle:TextStyle(color:Colors.white70),border:InputBorder.none))),
        InkWell(onTap:onRegister,child:Container(margin:EdgeInsets.symmetric(horizontal:15),padding:EdgeInsets.all(14),decoration:BoxDecoration(color:reg?Color(0xFFE8F5E9):Color(0xFFFFF3E0),borderRadius:BorderRadius.circular(12),border:Border.all(color:reg?Colors.green:Colors.orange)),child:Row(children:[Icon(reg?Icons.verified:Icons.app_registration,color:reg?Colors.green:Colors.orange,size:32),SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(reg?'REGISTERED NA - $gt':'Wala pa ka naka-register!',style:TextStyle(fontWeight:FontWeight.bold)),Text(reg?'Auto sulod commission sa imong GoTyme/GCash/Bank':'I-register para auto sulod commission',style:TextStyle(fontSize:11))])),ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:reg?Colors.green:Colors.orange),onPressed:onRegister,child:Text(reg?'OK':'REGISTER'))]))),
        Padding(padding:EdgeInsets.all(15),child:Text('Pangitaon?',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold))),
        Padding(padding:EdgeInsets.symmetric(horizontal:10),child:GridView.count(crossAxisCount:2,shrinkWrap:true,physics:NeverScrollableScrollPhysics(),childAspectRatio:2.6,children:[
          _cat(c,'Airbnb',Icons.home,Color(0xFFFFEBEE),Colors.red),_cat(c,'House Rent',Icons.home_work,Color(0xFFE8F5E9),Colors.green),
          _cat(c,'House Sale',Icons.house,Color(0xFFE3F2FD),Colors.blue),_cat(c,'Lot Rent',Icons.terrain,Color(0xFFFFF3E0),Colors.orange),
          _cat(c,'Lot Sale',Icons.landscape,Color(0xFFEFEBE9),Colors.brown),_cat(c,'Rent Car',Icons.car_rental,Color(0xFFF3E5F5),Colors.purple),
          _cat(c,'Food',Icons.fastfood,Color(0xFFFBE9E7),Colors.deepOrange),_cat(c,'Services',Icons.build,Color(0xFFE0F2F1),Colors.teal),
        ])),
        Padding(padding:EdgeInsets.all(15),child:Text('Popular - Bag-o',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold))),
        ...props.map((p){int com=(p['price']*0.15).toInt();return Card(margin:EdgeInsets.symmetric(horizontal:15,vertical:8),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),child:Column(children:[ClipRRect(borderRadius:BorderRadius.vertical(top:Radius.circular(15)),child:Image.network(p['img'],height:180,width:double.infinity,fit:BoxFit.cover)),ListTile(title:Text(p['title'],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${p['loc']} - ₱${p['price']} | Kita: ₱$com')),Padding(padding:EdgeInsets.all(10),child:Row(children:[Expanded(child:OutlinedButton.icon(icon:Icon(Icons.chat),label:Text('Chat'),onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Chat(owner:p['owner'],title:p['title']))))),SizedBox(width:8),Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>Pay(price:p['price'],com:com,gt:gt,gc:gc)),child:Text('Book')))]))])) ;}).toList(),
        SizedBox(height:80),
      ])),
    ]);
  }
  Widget _cat(BuildContext c,String t,IconData i,Color bg,Color ic){return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Cat(cat:t,props:props,gt:gt,gc:gc))),child:Container(margin:EdgeInsets.all(5),decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(12),border:Border.all(color:ic.withOpacity(0.4),width:2)),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(i,color:ic),SizedBox(width:8),Text(t,style:TextStyle(fontWeight:FontWeight.bold,color:ic))])));}
}

class RegisterSheet extends StatefulWidget{final VoidCallback onDone;RegisterSheet({required this.onDone});@override State<RegisterSheet> createState()=>_RS();}
class _RS extends State<RegisterSheet>{
  int step=0;
  var email=TextEditingController(); var first=TextEditingController(text:'Sonny'); var last=TextEditingController(text:'SIMBAJON'); var pass=TextEditingController();
  @override Widget build(BuildContext context){
    return Container(padding:EdgeInsets.all(20),height:MediaQuery.of(context).size.height*0.85,child:ListView(children:[
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[SizedBox(width:30),Expanded(child:Center(child:Container(width:50,height:5,decoration:BoxDecoration(color:Colors.grey.shade300,borderRadius:BorderRadius.circular(5))))),IconButton(icon:Icon(Icons.close),onPressed:()=>Navigator.pop(context))]),
      SizedBox(height:20),
      if(step==0)...[
        Center(child:Icon(Icons.home_rounded,color:Color(0xFFFF385C),size:60)),
        SizedBox(height:20),
        Center(child:Text('Log in or sign up',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold))),
        SizedBox(height:20),
        TextField(controller:email,decoration:InputDecoration(labelText:'Phone number or email',border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),contentPadding:EdgeInsets.all(18))),
        SizedBox(height:15),
        SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF385C),padding:EdgeInsets.all(16),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),onPressed:(){if(email.text.isNotEmpty)setState(()=>step=1); else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Butangi email/phone!')));},child:Text('Continue',style:TextStyle(fontSize:16,fontWeight:FontWeight.bold,color:Colors.white)))),
        SizedBox(height:10),
        Text('We will send a confirmation code by text or email. Message and data rates apply. Privacy Policy',style:TextStyle(fontSize:11)),
        SizedBox(height:15),
        Row(children:[Expanded(child:Divider()),Padding(padding:EdgeInsets.symmetric(horizontal:10),child:Text('or')),Expanded(child:Divider())]),
        SizedBox(height:15),
        Row(mainAxisAlignment:MainAxisAlignment.center,children:[OutlinedButton(onPressed:()=>setState(()=>step=1),style:OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),padding:EdgeInsets.all(15)),child:Text('G',style:TextStyle(fontSize:28,fontWeight:FontWeight.bold,color:Colors.blue))),SizedBox(width:15),OutlinedButton(onPressed:()=>setState(()=>step=1),style:OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),padding:EdgeInsets.all(15)),child:Icon(Icons.apple,size:35))]),
        SizedBox(height:20),
        Container(padding:EdgeInsets.all(12),decoration:BoxDecoration(color:Colors.grey.shade100,borderRadius:BorderRadius.circular(12)),child:Column(children:[
          Row(children:[Icon(Icons.verified_user,color:Colors.green),SizedBox(width:8),Expanded(child:Text('Auto commission sa GoTyme/GCash/Bank - 15% per booking!',style:TextStyle(fontWeight:FontWeight.bold,fontSize:12)))]),
          SizedBox(height:8),
          Row(children:[Icon(Icons.payments,color:Colors.orange),SizedBox(width:8),Text('GCash, Maya, GoTyme, BPI, BDO, Metrobank',style:TextStyle(fontSize:11))]),
        ])),
      ] else if(step==1)...[
        Text('First name',style:TextStyle(fontWeight:FontWeight.bold)),SizedBox(height:5),
        TextField(controller:first,decoration:InputDecoration(border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),hintText:'First name')),
        SizedBox(height:10),
        TextField(controller:last,decoration:InputDecoration(border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),hintText:'Last name')),
        SizedBox(height:8),
        Text('Make sure it matches the name on your government ID.',style:TextStyle(fontSize:12)),
        SizedBox(height:20),
        Text('Date of birth',style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),
        SizedBox(height:8),
        Container(padding:EdgeInsets.all(15),decoration:BoxDecoration(border:Border.all(color:Colors.grey),borderRadius:BorderRadius.circular(12)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text('6/2/1982'),Icon(Icons.calendar_today)])),
        SizedBox(height:20),
        Text('Password',style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),
        TextField(controller:pass,obscureText:true,decoration:InputDecoration(border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),hintText:'Password')),
        SizedBox(height:15),
        Container(padding:EdgeInsets.all(10),decoration:BoxDecoration(color:Colors.grey.shade100,borderRadius:BorderRadius.circular(8)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Password strength: weak',style:TextStyle(color:Colors.red,fontSize:12)),
          Text('✓ Can\'t contain your name or email',style:TextStyle(fontSize:12)),
          Text('✓ At least 9 characters long',style:TextStyle(fontSize:12)),
        ])),
        SizedBox(height:20),
        SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.black,padding:EdgeInsets.all(16),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),onPressed:()=>setState(()=>step=2),child:Text('Agree and continue',style:TextStyle(color:Colors.white)))),
      ] else ...[
        Center(child:Icon(Icons.home_rounded,color:Color(0xFFFF385C),size:60)),
        SizedBox(height:15),
        Center(child:Text('Everyone belongs here',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold))),
        SizedBox(height:15),
        Text('When you join Pinas Paupa, we ask you to agree to our Community Commitment: I will treat everyone in the community with respect, and without judgment or bias.',textAlign:TextAlign.center),
        SizedBox(height:30),
        SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF385C),padding:EdgeInsets.all(16),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),onPressed:widget.onDone,child:Text('Agree and continue',style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white)))),
        SizedBox(height:15),
        Center(child:TextButton(onPressed:()=>Navigator.pop(context),child:Text('Decline',style:TextStyle(color:Colors.black)))),
      ]
    ]));
  }
}

class Cat extends StatelessWidget{final String cat;final List props;final String gt,gc;Cat({required this.cat,required this.props,required this.gt,required this.gc});@override Widget build(BuildContext c){var f=props.where((e)=>e['cat']==cat).toList();return Scaffold(appBar:AppBar(title:Text('$cat - ${f.length}'),backgroundColor:Color(0xFF2E7D32)),body:f.isEmpty?Center(child:Text('Wala pay $cat - Ikaw una mag post!')):ListView.builder(itemCount:f.length,itemBuilder:(c,i){var p=f[i];return Card(margin:EdgeInsets.all(10),child:Column(children:[Image.network(p['img'],height:180,width:double.infinity,fit:BoxFit.cover),ListTile(title:Text(p['title']),subtitle:Text('₱${p['price']}')),Row(children:[Expanded(child:OutlinedButton.icon(icon:Icon(Icons.chat),label:Text('Chat'),onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Chat(owner:p['owner'],title:p['title']))))),Expanded(child:ElevatedButton(onPressed:()=>showModalBottomSheet(context:c,builder:(_)=>Pay(price:p['price'],com:(p['price']*0.15).toInt(),gt:gt,gc:gc)),child:Text('Book')))])]));}));}}
class TripsPage extends StatelessWidget{ @override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Trips'),backgroundColor:Colors.white,foregroundColor:Colors.black),body:Column(children:[Container(height:180,color:Color(0xFFF5F5DC),child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text('Toronto  Nashville  New York  Orlando',style:TextStyle(fontWeight:FontWeight.bold)),SizedBox(height:10),Icon(Icons.map,size:50)]))),Expanded(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.holiday_village,size:80,color:Colors.orange),Text('Map out your next trip',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Padding(padding:EdgeInsets.all(20),child:Text('After you book a trip, come back here to see details.',textAlign:TextAlign.center))]))]));}}
class MessagesPage extends StatelessWidget{ @override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Messages'),backgroundColor:Colors.white,foregroundColor:Colors.black),body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.chat_bubble,size:80,color:Colors.blue),Text('Nothing to see here',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text('Plan a stay to connect with host'),SizedBox(height:20),ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.red),onPressed:(){},child:Text('Get started',style:TextStyle(color:Colors.white)))])));}}
class ProfilePage extends StatelessWidget{final String name;final bool isReg;final VoidCallback onRegister;ProfilePage({required this.name,required this.isReg,required this.onRegister});@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Profile'),backgroundColor:Colors.white,foregroundColor:Colors.black),body:ListView(children:[Card(margin:EdgeInsets.all(20),child:Padding(padding:EdgeInsets.all(20),child:Column(children:[CircleAvatar(radius:50,backgroundColor:Colors.pink.shade100,child:Text(name[0],style:TextStyle(fontSize:40,color:Colors.purple))),SizedBox(height:10),Text(name,style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),Text(isReg?'Verified Guest':'Guest'),if(!isReg)ElevatedButton(onPressed:onRegister,child:Text('REGISTER NOW'))]))),Padding(padding:EdgeInsets.symmetric(horizontal:15),child:Row(children:[Expanded(child:Card(child:Padding(padding:EdgeInsets.all(15),child:Column(children:[Icon(Icons.luggage,size:40),Text('Past trips')])))),Expanded(child:Card(child:Padding(padding:EdgeInsets.all(15),child:Column(children:[Icon(Icons.people,size:40),Text('Connections')]))))])),Card(margin:EdgeInsets.all(15),child:ListTile(leading:Icon(Icons.person),title:Text('Become a host'),subtitle:Text('It\'s easy to start hosting and earn extra income.'))) ]));}}
class Chat extends StatefulWidget{final String owner,title;Chat({required this.owner,required this.title});@override State<Chat> createState()=>_ChatS();}
class _ChatS extends State<Chat>{List<String> msgs=[];var ctrl=TextEditingController();@override void initState(){super.initState();msgs=['Hello ${widget.owner}, available pa ${widget.title}?','Yes boss available!'];}@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('Chat ${widget.owner}')),body:Column(children:[Expanded(child:ListView.builder(itemCount:msgs.length,itemBuilder:(c,i)=>Align(alignment:i%2==0?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:EdgeInsets.all(8),padding:EdgeInsets.all(12),decoration:BoxDecoration(color:i%2==0?Color(0xFF2E7D32):Colors.grey.shade200,borderRadius:BorderRadius.circular(15)),child:Text(msgs[i],style:TextStyle(color:i%2==0?Colors.white:Colors.black)))))),Padding(padding:EdgeInsets.all(10),child:Row(children:[Expanded(child:TextField(controller:ctrl,decoration:InputDecoration(hintText:'Type...',border:OutlineInputBorder()))),IconButton(icon:Icon(Icons.send),onPressed:(){if(ctrl.text.isNotEmpty){setState(()=>msgs.add(ctrl.text));ctrl.clear();Future.delayed(Duration(seconds:1),()=>setState(()=>msgs.add('Copy boss! Reply ko - ${widget.owner}')));}})]))])));}}
class Post extends StatefulWidget{final Function(Map<String,dynamic>) onAdd;Post({required this.onAdd});@override State<Post> createState()=>_PostS();}
class _PostS extends State<Post>{var t=TextEditingController();var pr=TextEditingController();var img=TextEditingController(text:'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800');String cat='House Rent';List<String> samples=['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800','https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=800','https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800'];@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text('MAG POST + PICTURE')),body:Padding(padding:EdgeInsets.all(15),child:ListView(children:[SizedBox(height:100,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:samples.length,itemBuilder:(c,i)=>InkWell(onTap:()=>setState(()=>img.text=samples[i]),child:Container(margin:EdgeInsets.all(5),width:100,decoration:BoxDecoration(border:Border.all(color:img.text==samples[i]?Colors.orange:Colors.grey,width:3)),child:Image.network(samples[i],fit:BoxFit.cover)))))),TextField(controller:img,decoration:InputDecoration(labelText:'Picture Link')),Image.network(img.text,height:150,fit:BoxFit.cover),DropdownButton<String>(value:cat,isExpanded:true,items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>cat=v!)),TextField(controller:t,decoration:InputDecoration(labelText:'Title')),TextField(controller:pr,decoration:InputDecoration(labelText:'Price'),keyboardType:TextInputType.number),ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.orange),onPressed:(){widget.onAdd({'title':t.text,'price':int.tryParse(pr.text)??15000,'loc':'Davao','cat':cat,'owner':'Ikaw','img':img.text});Navigator.pop(c);},child:Text('I-POST NA!'))])));}}
class Pay extends StatelessWidget{final int price,com;final String gt,gc;Pay({required this.price,required this.com,required this.gt,required this.gc});@override Widget build(BuildContext c){return Container(padding:EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,children:[Text('Bayad ₱$price Commission ₱$com AUTO $gt/$gc',style:TextStyle(fontWeight:FontWeight.bold)),Wrap(children:['GCash','Maya','GoTyme','BPI','BDO','Metrobank'].map((e)=>Chip(label:Text(e))).toList()),ElevatedButton(onPressed:(){Navigator.pop(c);ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('✅ Bayad na! ₱$com AUTO sa $gt')));},child:Text('BAYARAN ₱$price'))]));}}
