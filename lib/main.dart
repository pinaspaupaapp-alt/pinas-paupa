import 'package:flutter/material.dart';
void main(){runApp(PinasPaupaApp());}

class PinasPaupaApp extends StatelessWidget{
@override
Widget build(BuildContext c){
return MaterialApp(debugShowCheckedModeBanner:false, theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF8F9FA)), home:MainHome());
}
}

class MainHome extends StatelessWidget{
final categories=[
{'title':'Airbnb','icon':Icons.home_work_rounded,'color':Color(0xFFE53935),'light':Color(0xFFFFEBEE),'sub':'Bakasyon'},
{'title':'House Rent','icon':Icons.house_rounded,'color':Color(0xFF2E7D32),'light':Color(0xFFE8F5E9),'sub':'Paupahan'},
{'title':'House Sale','icon':Icons.real_estate_agent_rounded,'color':Color(0xFF1565C0),'light':Color(0xFFE3F2FD),'sub':'Baligya'},
{'title':'Lot Rent','icon':Icons.landscape_rounded,'color':Color(0xFFEF6C00),'light':Color(0xFFFFF3E0),'sub':'Lupa Rent'},
{'title':'Lot Sale','icon':Icons.terrain_rounded,'color':Color(0xFF6D4C41),'light':Color(0xFFEFEBE9),'sub':'Lupa Sale'},
{'title':'Rent Car','icon':Icons.directions_car_rounded,'color':Color(0xFF6A1B9A),'light':Color(0xFFF3E5F5),'sub':'Car/Motor'},
{'title':'Food','icon':Icons.fastfood_rounded,'color':Color(0xFFFF3D00),'light':Color(0xFFFBE9E7),'sub':'Delivery'},
{'title':'Services','icon':Icons.handyman_rounded,'color':Color(0xFF00897B),'light':Color(0xFFE0F2F1),'sub':'All Services'},
];

final services=[
{'title':'Aircon','icon':Icons.ac_unit_rounded,'color':Color(0xFF03A9F4)},
{'title':'Cleaning','icon':Icons.cleaning_services_rounded,'color':Color(0xFF00ACC1)},
{'title':'Tubero','icon':Icons.plumbing_rounded,'color':Color(0xFFFF6F00)},
{'title':'Renovation','icon':Icons.construction_rounded,'color':Color(0xFF5D4037)},
{'title':'Electrical','icon':Icons.electrical_services_rounded,'color':Color(0xFFFFB300)},
{'title':'Mechanic','icon':Icons.car_repair_rounded,'color':Color(0xFF424242)},
{'title':'Manicure','icon':Icons.spa_rounded,'color':Color(0xFFEC407A)},
{'title':'Massage','icon':Icons.self_improvement_rounded,'color':Color(0xFFAB47BC)},
];

@override
Widget build(BuildContext c){
return Scaffold(
body:SingleChildScrollView(child:Column(children:[
// HEADER GRADIENT
Container(
padding:EdgeInsets.fromLTRB(16,50,16,20),
decoration:BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF2E7D32),Color(0xFF66BB6A)],begin:Alignment.topLeft,end:Alignment.bottomRight),borderRadius:BorderRadius.only(bottomLeft:Radius.circular(24),bottomRight:Radius.circular(24))),
child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Text('Pinas Paupa 🇵🇭',style:TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.bold)),
Text('Tanan naa diri - Balay, Lupa, Serbisyo',style:TextStyle(color:Colors.white70,fontSize:13)),
]),
CircleAvatar(backgroundColor:Colors.white,child:Icon(Icons.person,color:Color(0xFF2E7D32))),
]),
SizedBox(height:16),
Container(
decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:Colors.black12,blurRadius:8)]),
child:TextField(decoration:InputDecoration(hintText:'Search Airbnb, House, Lot, Services...',prefixIcon:Icon(Icons.search,color:Color(0xFF2E7D32)),border:InputBorder.none,contentPadding:EdgeInsets.all(14))),
),
])),
SizedBox(height:16),
Padding(padding:EdgeInsets.symmetric(horizontal:12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Text('Pangitaon?',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
SizedBox(height:10),
GridView.builder(shrinkWrap:true,physics:NeverScrollableScrollPhysics(),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:2.2,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:categories.length,itemBuilder:(ctx,i){
var cat=categories[i];
return InkWell(
onTap:(){
if(cat['title']=='Services'){Navigator.push(c,MaterialPageRoute(builder:(_)=>ServicesPage(services:services)));}
else{Navigator.push(c,MaterialPageRoute(builder:(_)=>ListingPage(title:cat['title'] as String,color:cat['color'] as Color,light:cat['light'] as Color)));}},
borderRadius:BorderRadius.circular(16),
child:Container(
decoration:BoxDecoration(color:cat['light'] as Color,borderRadius:BorderRadius.circular(16),border:Border.all(color:(cat['color'] as Color).withOpacity(0.3)),boxShadow:[BoxShadow(color:(cat['color'] as Color).withOpacity(0.15),blurRadius:6,offset:Offset(0,3))]),
child:Row(children:[
Container(margin:EdgeInsets.all(12),padding:EdgeInsets.all(10),decoration:BoxDecoration(color:cat['color'] as Color,borderRadius:BorderRadius.circular(12)),child:Icon(cat['icon'] as IconData,color:Colors.white,size:22)),
Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[
Text(cat['title'] as String,style:TextStyle(fontWeight:FontWeight.bold,fontSize:13,color:Colors.black87)),
Text(cat['sub'] as String,style:TextStyle(fontSize:11,color:Colors.black54)),
])),
]),
));
}),
SizedBox(height:20),
Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
Text('Popular Services',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
TextButton(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ServicesPage(services:services))),child:Text('See All',style:TextStyle(color:Color(0xFF2E7D32)))),
]),
GridView.builder(shrinkWrap:true,physics:NeverScrollableScrollPhysics(),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4,childAspectRatio:0.85,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:services.length,itemBuilder:(ctx,i){
var s=services[i];
return InkWell(
onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ListingPage(title:s['title'] as String,color:s['color'] as Color,light:Colors.white))),
child:Column(children:[
Container(padding:EdgeInsets.all(14),decoration:BoxDecoration(color:(s['color'] as Color).withOpacity(0.12),shape:BoxShape.circle,border:Border.all(color:(s['color'] as Color).withOpacity(0.3))),child:Icon(s['icon'] as IconData,color:s['color'] as Color,size:26)),
SizedBox(height:6),
Text(s['title'] as String,textAlign:TextAlign.center,style:TextStyle(fontSize:11,fontWeight:FontWeight.w600)),
]),
);
}),
SizedBox(height:20),
])),
])),
);
}
}

class ListingPage extends StatelessWidget{
final String title; final Color color; final Color light;
ListingPage({required this.title,required this.color,required this.light});
@override
Widget build(BuildContext c){
return Scaffold(
appBar:AppBar(title:Text(title),backgroundColor:color,elevation:0),
body:Column(children:[
Container(height:50,color:light,child:Row(children:[SizedBox(width:12),Icon(Icons.location_on,color:color,size:18),SizedBox(width:4),Text('Tizimin, Yucatan • 12 available',style:TextStyle(color:Colors.black54)),Spacer(),Container(margin:EdgeInsets.only(right:12),padding:EdgeInsets.symmetric(horizontal:10,vertical:4),decoration:BoxDecoration(color:color,borderRadius:BorderRadius.circular(20)),child:Text('FILTER',style:TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.bold)))])),
Expanded(child:ListView.builder(itemCount:8,itemBuilder:(ctx,i){
return InkWell(
onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>DetailPage(title:'$title #${i+1}',color:color))),
child:Container(margin:EdgeInsets.all(10),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:Colors.black12,blurRadius:6)]),child:Row(children:[
ClipRRect(borderRadius:BorderRadius.only(topLeft:Radius.circular(14),bottomLeft:Radius.circular(14)),child:Container(width:110,height:100,color:light,child:Icon(Icons.image_rounded,size:40,color:color.withOpacity(0.6)))),
Expanded(child:Padding(padding:EdgeInsets.all(10),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Row(children:[Container(padding:EdgeInsets.symmetric(horizontal:6,vertical:2),decoration:BoxDecoration(color:light,borderRadius:BorderRadius.circular(6)),child:Text(title,style:TextStyle(fontSize:10,color:color,fontWeight:FontWeight.bold))),Spacer(),Icon(Icons.favorite_border,size:18,color:Colors.grey)]),
SizedBox(height:4),
Text('$title #${i+1} - Nice & Clean',style:TextStyle(fontWeight:FontWeight.bold,fontSize:14)),
Text('Brgy. Tizimin • 2BR • Available now',style:TextStyle(fontSize:11,color:Colors.grey[600])),
SizedBox(height:6),
Row(children:[Text('₱${(i+1)*1500}',style:TextStyle(fontWeight:FontWeight.bold,color:color,fontSize:15)),Text('/month',style:TextStyle(fontSize:11,color:Colors.grey)),Spacer(),Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:3),decoration:BoxDecoration(color:Color(0xFFFF6F00),borderRadius:BorderRadius.circular(8)),child:Text('BOOK',style:TextStyle(color:Colors.white,fontSize:10,fontWeight:FontWeight.bold)))]),
]))),
])),
);
})),
);
}
}

class ServicesPage extends StatelessWidget{
final List<Map<String,dynamic>> services;ServicesPage({required this.services});
@override
Widget build(BuildContext c){
return Scaffold(appBar:AppBar(title:Text('All Services'),backgroundColor:Color(0xFF00897B)),body:GridView.builder(padding:EdgeInsets.all(14),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.1,crossAxisSpacing:14,mainAxisSpacing:14),itemCount:services.length,itemBuilder:(ctx,i){
var s=services[i];
return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ListingPage(title:s['title'] as String,color:s['color'] as Color,light:(s['color'] as Color).withOpacity(0.1)))),child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(16),boxShadow:[BoxShadow(color:Colors.black12,blurRadius:8)]),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Container(padding:EdgeInsets.all(16),decoration:BoxDecoration(color:(s['color'] as Color).withOpacity(0.12),shape:BoxShape.circle),child:Icon(s['icon'] as IconData,size:36,color:s['color'] as Color)),SizedBox(height:10),Text(s['title'] as String,style:TextStyle(fontWeight:FontWeight.bold)),Text('Available now',style:TextStyle(fontSize:11,color:Colors.grey))])));}));
}
}

class DetailPage extends StatelessWidget{
final String title; final Color color; DetailPage({required this.title,required this.color});
@override
Widget build(BuildContext c){
return Scaffold(appBar:AppBar(title:Text(title),backgroundColor:color),body:SingleChildScrollView(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Container(height:220,color:color.withOpacity(0.15),child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.image_rounded,size:80,color:color.withOpacity(0.5)),SizedBox(height:8),Text('3 Photos • Video tour available',style:TextStyle(color:color))]))),
Padding(padding:EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Row(children:[Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:4),decoration:BoxDecoration(color:color.withOpacity(0.15),borderRadius:BorderRadius.circular(8)),child:Text('VERIFIED',style:TextStyle(color:color,fontSize:11,fontWeight:FontWeight.bold))),SizedBox(width:8),Icon(Icons.star,color:Colors.amber,size:16),Text(' 4.8 (124 reviews)',style:TextStyle(fontSize:12))]),
SizedBox(height:8),
Text(title,style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
Text('Owner: Juan Dela Cruz • 0912-345-6789 • Tizimin',style:TextStyle(color:Colors.grey[600],fontSize:13)),
SizedBox(height:16),
Text('₱2,500 / month • Good condition • Free water',style:TextStyle(fontSize:16,fontWeight:FontWeight.bold,color:color)),
SizedBox(height:16),
Row(children:[
Expanded(child:ElevatedButton.icon(style:ElevatedButton.styleFrom(backgroundColor:Colors.white,foregroundColor:color,side:BorderSide(color:color),padding:EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),onPressed:(){ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('Message sent to owner!'),backgroundColor:color));},icon:Icon(Icons.message_rounded),label:Text('Message'))),
SizedBox(width:12),
Expanded(child:ElevatedButton.icon(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFFF6F00),foregroundColor:Colors.white,padding:EdgeInsets.symmetric(vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),onPressed:(){ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('Booking $title...'),backgroundColor:Color(0xFFFF6F00)));},icon:Icon(Icons.bolt_rounded),label:Text('Book Now'))),
]),
])),
])));}
}
