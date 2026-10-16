import 'package:flutter/material.dart';
void main(){runApp(PinasPaupaApp());}
class PinasPaupaApp extends StatelessWidget{
@override
Widget build(BuildContext c){
return MaterialApp(debugShowCheckedModeBanner:false,home:MainHome());
}
}
class MainHome extends StatelessWidget{
final categories=[
{'title':'Airbnb','icon':Icons.home_work,'color':Colors.red},
{'title':'House Rent','icon':Icons.house,'color':Colors.green},
{'title':'House Sale','icon':Icons.real_estate_agent,'color':Colors.blue},
{'title':'Lot Rent','icon':Icons.landscape,'color':Colors.orange},
{'title':'Lot Sale','icon':Icons.terrain,'color':Colors.brown},
{'title':'Rent Car/Motor','icon':Icons.car_rental,'color':Colors.purple},
{'title':'Food Delivery','icon':Icons.fastfood,'color':Colors.redAccent},
{'title':'Services','icon':Icons.handyman,'color':Colors.teal},
];
final services=[
{'title':'Aircon Cleaning','icon':Icons.ac_unit},
{'title':'House Cleaning','icon':Icons.cleaning_services},
{'title':'Tubero','icon':Icons.plumbing},
{'title':'House Renovation','icon':Icons.construction},
{'title':'Electrical','icon':Icons.electrical_services},
{'title':'Car Mechanic','icon':Icons.car_repair},
{'title':'Manicurista','icon':Icons.spa},
{'title':'Home Massage','icon':Icons.self_improvement},
];
@override
Widget build(BuildContext c){
return Scaffold(
appBar:AppBar(title:Text('Pinas Paupa 🇵🇭'),backgroundColor:Colors.green[700],centerTitle:true),
body:SingleChildScrollView(padding:EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Text('Pangitaon?',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
SizedBox(height:10),
GridView.builder(shrinkWrap:true,physics:NeverScrollableScrollPhysics(),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:2.5,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:categories.length,itemBuilder:(ctx,i){
var cat=categories[i];
return InkWell(onTap:(){
if(cat['title']=='Services'){Navigator.push(c,MaterialPageRoute(builder:(_)=>ServicesPage(services:services)));}
else{Navigator.push(c,MaterialPageRoute(builder:(_)=>ListingPage(title:cat['title'] as String)));}},
child:Container(decoration:BoxDecoration(color:(cat['color'] as Color).withOpacity(0.15),borderRadius:BorderRadius.circular(12),border:Border.all(color:cat['color'] as Color)),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(cat['icon'] as IconData,color:cat['color'] as Color),SizedBox(width:8),Text(cat['title'] as String,style:TextStyle(fontWeight:FontWeight.bold))])));}),
SizedBox(height:20),
Text('Popular Services',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
SizedBox(height:10),
GridView.builder(shrinkWrap:true,physics:NeverScrollableScrollPhysics(),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4,childAspectRatio:0.9,crossAxisSpacing:8,mainAxisSpacing:8),itemCount:services.length,itemBuilder:(ctx,i){
var s=services[i];
return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ListingPage(title:s['title'] as String))),child:Column(children:[CircleAvatar(backgroundColor:Colors.green[100],radius:28,child:Icon(s['icon'] as IconData,color:Colors.green[700])),SizedBox(height:4),Text(s['title'] as String,textAlign:TextAlign.center,style:TextStyle(fontSize:11))]));
}),
])),
);
}
}
class ListingPage extends StatelessWidget{
final String title;ListingPage({required this.title});
@override
Widget build(BuildContext c){
return Scaffold(appBar:AppBar(title:Text(title),backgroundColor:Colors.green[700]),body:ListView.builder(itemCount:6,itemBuilder:(ctx,i){return Card(margin:EdgeInsets.all(8),child:ListTile(leading:Icon(Icons.image,size:40),title:Text('$title #${i+1}'),subtitle:Text('Tizimin, Yucatan - P${(i+1)*1500}/month'),trailing:Icon(Icons.arrow_forward_ios,size:14),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>DetailPage(title:'$title #${i+1}')))));}),floatingActionButton:FloatingActionButton(backgroundColor:Colors.green[700],onPressed:(){},child:Icon(Icons.add)));
}
}
class ServicesPage extends StatelessWidget{
final List<Map<String,dynamic>> services;ServicesPage({required this.services});
@override
Widget build(BuildContext c){
return Scaffold(appBar:AppBar(title:Text('All Services'),backgroundColor:Colors.green[700]),body:GridView.builder(padding:EdgeInsets.all(12),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:services.length,itemBuilder:(ctx,i){var s=services[i];return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ListingPage(title:s['title'] as String))),child:Card(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(s['icon'] as IconData,size:40,color:Colors.green[700]),SizedBox(height:8),Text(s['title'] as String,style:TextStyle(fontWeight:FontWeight.bold))])));}));
}
}
class DetailPage extends StatelessWidget{
final String title;DetailPage({required this.title});
@override
Widget build(BuildContext c){
return Scaffold(appBar:AppBar(title:Text(title),backgroundColor:Colors.green[700]),body:Padding(padding:EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(height:180,color:Colors.grey[300],child:Center(child:Icon(Icons.image,size:80))),SizedBox(height:12),Text(title,style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),Text('Owner: Juan - 09123456789',style:TextStyle(color:Colors.grey[600])),SizedBox(height:20),Row(children:[Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.green[700]),onPressed:(){ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('Message sent!')));},child:Text('Message',style:TextStyle(color:Colors.white)))),SizedBox(width:10),Expanded(child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.orange),onPressed:(){ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text('Booking $title...')));},child:Text('Book / Rent',style:TextStyle(color:Colors.white))))])])));}
}
