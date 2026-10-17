import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main()=>runApp(MaterialApp(home:PinasPaupaApp(),debugShowCheckedModeBanner:false));

class PinasPaupaApp extends StatefulWidget{ @override State<PinasPaupaApp> createState()=>_PinasPaupaAppState();}
class _PinasPaupaAppState extends State<PinasPaupaApp>{
  List<Map<String,dynamic>> allProps=[
    {'title':'Modern Apartment Davao','loc':'Davao City','price':15000,'cat':'House Rent','owner':'Anna','img':null,'net':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'},
    {'title':'Airbnb Makati 2BR','loc':'Makati','price':3000,'cat':'Airbnb','owner':'Mika','img':null,'net':'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=800'},
  ];
  String gcash="09123456789"; String gotyme="019812345678"; bool reg=false;
  void addProp(Map<String,dynamic> p){setState(()=>allProps.insert(0,p));}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFFFDF2F8),
      appBar:AppBar(title:Text('Pinas Paupa 🇵🇭'),backgroundColor:Color(0xFF2E7D32)),
      body:SingleChildScrollView(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(margin:EdgeInsets.all(15),padding:EdgeInsets.symmetric(horizontal:15),decoration:BoxDecoration(color:Color(0xFF2E7D32),borderRadius:BorderRadius.circular(15)),child:TextField(decoration:InputDecoration(icon:Icon(Icons.search,color:Colors.white),hintText:'Search Airbnb, House, Lot...',hintStyle:TextStyle(color:Colors.white70),border:InputBorder.none))),
        Container(margin:EdgeInsets.symmetric(horizontal:15),padding:EdgeInsets.all(12),decoration:BoxDecoration(color:reg?Colors.green.shade100:Colors.orange.shade100,borderRadius:BorderRadius.circular(12)),child:Row(children:[Icon(reg?Icons.verified:Icons.app_registration,color:reg?Colors.green:Colors.orange),SizedBox(width:10),Expanded(child:Text(reg?'REGISTERED - AUTO $gotyme':'Wala pa ka naka-register!',style:TextStyle(fontWeight:FontWeight.bold))),ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:reg?Colors.green:Colors.orange),onPressed:()=>setState(()=>reg=true),child:Text(reg?'UPDATE':'REGISTER'))])),
        Padding(padding:EdgeInsets.all(15),child:Text('Pangitaon? - MA-PINDOT NA!',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))),
        Padding(padding:EdgeInsets.symmetric(horizontal:10),child:GridView.count(crossAxisCount:2,shrinkWrap:true,physics:NeverScrollableScrollPhysics(),childAspectRatio:2.6,children:[
          _cat('Airbnb',Icons.home,Color(0xFFFFEBEE),Colors.red),_cat('House Rent',Icons.home_work,Color(0xFFE8F5E9),Colors.green),
          _cat('House Sale',Icons.house,Color(0xFFE3F2FD),Colors.blue),_cat('Lot Rent',Icons.terrain,Color(0xFFFFF3E0),Colors.orange),
          _cat('Lot Sale',Icons.landscape,Color(0xFFEFEBE9),Colors.brown),_cat('Rent Car',Icons.car_rental,Color(0xFFF3E5F5),Colors.purple),
          _cat('Food',Icons.fastfood,Color(0xFFFBE9E7),Colors.deepOrange),_cat('Services',Icons.build,Color(0xFFE0F2F1),Colors.teal),
        ])),
        Padding(padding:EdgeInsets.all(15),child:Text('Bag-o - MA-POST + PICTURE NA!',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold))),
        ...allProps.map((p){int comm=(p['price']*0.15).toInt();Widget imgWidget=p['img']!=null?Image.file(p['img'],height:180,width:double.infinity,fit:BoxFit.cover):Image.network(p['net'],height:180,width:double.infinity,fit:BoxFit.cover);return Card(margin:EdgeInsets.symmetric(horizontal:15,vertical:8),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),child:Column(children:[
          ClipRRect(borderRadius:BorderRadius.vertical(top:Radius.circular(15)),child:imgWidget),
          ListTile(title:Text(p['title'],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${p['loc']} - ₱${p['price']} | Kita: ₱$comm -> $gotyme')),
          Padding(padding:EdgeInsets.all(10),child:Row(children:[
            Expanded(child:OutlinedButton.icon(icon:Icon(Icons.chat),label:Text('Chat'),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ChatPage(owner:p['owner'],title:p['title']))))),
            SizedBox(width:8),
            Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:()=>showModalBottomSheet(context:context,builder:(_)=>PaySheet(price:p['price'],comm:comm,gt:gotyme,gc:gcash)),child:Text('Book & Pay'))),
          ])),
        ]));}).toList(),
        SizedBox(height:120),
      ])),
      floatingActionButton:Column(mainAxisSize:MainAxisSize.min,children:[
        FloatingActionButton.extended(heroTag:'reg',backgroundColor:Color(0xFFFF9800),icon:Icon(Icons.verified),label:Text('REGISTER COMMISSION'),onPressed:()=>setState(()=>reg=true)),
        SizedBox(height:10),
        FloatingActionButton.extended(heroTag:'post',backgroundColor:Color(0xFFFF6B00),icon:Icon(Icons.add_a_photo),label:Text('MAG POST + PICTURE'),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>PostPage(onPost:addProp)))),
      ]),
    );
  }
  Widget _cat(String t,IconData i,Color bg,Color ic){return InkWell(onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>CatPage(cat:t,props:allProps,gcash:gcash,gotyme:gotyme))),child:Container(margin:EdgeInsets.all(5),decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(12),border:Border.all(color:ic.withOpacity(0.3))),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(i,color:ic),SizedBox(width:6),Text(t,style:TextStyle(fontWeight:FontWeight.bold,fontSize:12))])));}
}

class CatPage extends StatelessWidget{
  final String cat; final List<Map<String,dynamic>> props; final String gcash,gotyme;
  CatPage({required this.cat,required this.props,required this.gcash,required this.gotyme});
  @override Widget build(BuildContext context){
    var f=props.where((p)=>p['cat']==cat).toList();
    return Scaffold(appBar:AppBar(title:Text('$cat - ${f.length}'),backgroundColor:Color(0xFF2E7D32)),body:f.isEmpty?Center(child:Text('Wala pay $cat - Ikaw una mag post + picture!')):ListView.builder(itemCount:f.length,itemBuilder:(c,i){var p=f[i];Widget imgWidget=p['img']!=null?Image.file(p['img'],height:180,width:double.infinity,fit:BoxFit.cover):Image.network(p['net'],height:180,width:double.infinity,fit:BoxFit.cover);return Card(margin:EdgeInsets.all(10),child:Column(children:[imgWidget,ListTile(title:Text(p['title']),subtitle:Text('${p['loc']} - ₱${p['price']}')),Row(children:[Expanded(child:OutlinedButton.icon(icon:Icon(Icons.chat),label:Text('Chat'),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ChatPage(owner:p['owner'],title:p['title']))))),Expanded(child:ElevatedButton(onPressed:()=>showModalBottomSheet(context:context,builder:(_)=>PaySheet(price:p['price'],comm:(p['price']*0.15).toInt(),gt:gotyme,gc:gcash)),child:Text('Book & Pay')))],)]));}));}
}

class ChatPage extends StatefulWidget{final String owner,title;ChatPage({required this.owner,required this.title});@override State<ChatPage> createState()=>_ChatPageState();}
class _ChatPageState extends State<ChatPage>{
  List<String> msgs=['Hello available pa ang ${"property"}?','Yes boss available!'];
  var ctrl=TextEditingController();
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text('Chat ${widget.owner} - ${widget.title}'),backgroundColor:Color(0xFF2E7D32)),
      body:Column(children:[
        Expanded(child:ListView.builder(itemCount:msgs.length,itemBuilder:(c,i)=>Align(alignment:i%2==0?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:EdgeInsets.all(8),padding:EdgeInsets.all(12),decoration:BoxDecoration(color:i%2==0?Color(0xFF2E7D32):Colors.grey.shade200,borderRadius:BorderRadius.circular(15)),child:Text(msgs[i],style:TextStyle(color:i%2==0?Colors.white:Colors.black)))))),
        Container(padding:EdgeInsets.all(10),color:Colors.white,child:Row(children:[
          Expanded(child:TextField(controller:ctrl,decoration:InputDecoration(hintText:'Type message... maka-chat tinuod!',border:OutlineInputBorder(borderRadius:BorderRadius.circular(20))))),
          SizedBox(width:8),
          CircleAvatar(backgroundColor:Color(0xFF2E7D32),child:IconButton(icon:Icon(Icons.send,color:Colors.white),onPressed:(){if(ctrl.text.isNotEmpty){setState(()=>msgs.add(ctrl.text));ctrl.clear();Future.delayed(Duration(seconds:1),(){setState(()=>msgs.add('Copy boss! Mo-reply ko sa ${widget.owner}. GCash/GoTyme ta!'));});}})),
        ])),
      ]),
    );
  }
}

class PostPage extends StatefulWidget{final Function(Map<String,dynamic>) onPost;PostPage({required this.onPost});@override State<PostPage> createState()=>_PostPageState();}
class _PostPageState extends State<PostPage>{
  var title=TextEditingController();var price=TextEditingController();var loc=TextEditingController(text:'Davao City');
  String cat='House Rent'; File? _image; final picker=ImagePicker();
  Future<void> pickImage() async {
    final XFile? picked=await picker.pickImage(source: ImageSource.gallery);
    if(picked!=null){setState(()=>_image=File(picked.path));}
  }
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text('MAG POST + PICTURE - TINUOD NA!'),backgroundColor:Color(0xFF2E7D32)),
      body:Padding(padding:EdgeInsets.all(16),child:ListView(children:[
        InkWell(onTap:pickImage,child:Container(height:220,decoration:BoxDecoration(color:Colors.grey.shade200,borderRadius:BorderRadius.circular(12),border:Border.all(color:Colors.orange,width:2)),child:_image!=null?ClipRRect(borderRadius:BorderRadius.circular(12),child:Image.file(_image!,width:double.infinity,fit:BoxFit.cover)):Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.add_a_photo,size:60,color:Colors.orange),Text('I-CLICK PARA MAKA-INSERT PICTURE SA GALLERY!',style:TextStyle(fontWeight:FontWeight.bold)),Text('Tinuod na picture sa imong phone!')])))),
        SizedBox(height:10),
        Row(children:[Expanded(child:ElevatedButton.icon(icon:Icon(Icons.photo_library),label:Text('Gallery'),onPressed:pickImage)),SizedBox(width:10),Expanded(child:ElevatedButton.icon(icon:Icon(Icons.camera_alt),label:Text('Camera'),onPressed:()async{final XFile? p=await picker.pickImage(source:ImageSource.camera);if(p!=null)setState(()=>_image=File(p.path));}))]),
        SizedBox(height:15),
        DropdownButton<String>(value:cat,isExpanded:true,items:['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>cat=v!)),
        SizedBox(height:10),
        TextField(controller:title,decoration:InputDecoration(labelText:'Title - Ex: Apartment Davao 2BR',border:OutlineInputBorder())),
        SizedBox(height:10),
        TextField(controller:price,decoration:InputDecoration(labelText:'Price - Ex: 15000',border:OutlineInputBorder()),keyboardType:TextInputType.number),
        SizedBox(height:10),
        TextField(controller:loc,decoration:InputDecoration(labelText:'Location',border:OutlineInputBorder())),
        SizedBox(height:20),
        ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00),padding:EdgeInsets.all(15)),onPressed:(){if(title.text.isEmpty||_image==null){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Palihog butangi ug Title + Picture gikan sa Gallery!')));return;}widget.onPost({'title':title.text,'price':int.tryParse(price.text)??15000,'loc':loc.text,'cat':cat,'owner':'Ikaw','img':_image,'net':'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'});Navigator.pop(context);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('✅ NA-POST NA UBAN ANG PICTURE!')));},child:Text('I-POST NA UBAN ANG PICTURE!',style:TextStyle(fontSize:16))),
      ])),
    );
  }
}

class PaySheet extends StatelessWidget{
  final int price,comm; final String gt,gc;
  PaySheet({required this.price,required this.comm,required this.gt,required this.gc});
  @override Widget build(BuildContext context){
    return Container(padding:EdgeInsets.all(20),height:350,child:Column(children:[
      Text('AUTO PAY - ₱$comm -> $gt/$gc',style:TextStyle(fontWeight:FontWeight.bold,fontSize:16)),
      SizedBox(height:10),
      Wrap(spacing:5,children:['GCash','Maya','GoTyme','GoTyme Bank','BPI','BDO','Metrobank'].map((m)=>Chip(label:Text(m))).toList()),
      Spacer(),
      SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6B00)),onPressed:(){Navigator.pop(context);showDialog(context:context,builder:(_)=>AlertDialog(title:Text('✅ BAYAD NA!'),content:Text('Via GCash/GoTyme ₱$price\nCommission ₱$comm AUTO sa $gt')));},child:Text('BAYARAN ₱$price'))),
    ]));
  }
}
