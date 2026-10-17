import 'package:flutter/material.dart';
void main(){runApp(const App());}
class App extends StatelessWidget{const App({super.key});@override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false,home:Home());}}
class Home extends StatelessWidget{
@override Widget build(BuildContext c){
return Scaffold(
backgroundColor:Colors.white,
appBar:AppBar(backgroundColor:const Color(0xFF1A8E3E),title:const Row(children:[Text('Pinas Paupa ',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),Text('🇵🇭')])),
body:SingleChildScrollView(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:12),decoration:BoxDecoration(color:const Color(0xFF1A8E3E),borderRadius:BorderRadius.circular(20)),child:const Row(children:[Icon(Icons.search,color:Colors.white70),SizedBox(width:8),Text('Search Airbnb, House, Lot, Services...',style:TextStyle(color:Colors.white70))])),
const SizedBox(height:12),const Text('Pangitaon?',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),const SizedBox(height:10),
GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:2,childAspectRatio:2.8,mainAxisSpacing:10,crossAxisSpacing:10,children:[
catBox(Icons.home,'Airbnb',Colors.red,Color(0xFFFFF0F0)),catBox(Icons.home_work,'House Rent',Colors.green,Color(0xFFEFFAF0)),catBox(Icons.house,'House Sale',Colors.blue,Color(0xFFEFF8FF)),catBox(Icons.terrain,'Lot Rent',Colors.orange,Color(0xFFFFF8E8)),catBox(Icons.landscape,'Lot Sale',Color(0xFF8D6E63),Color(0xFFF5F5F0)),catBox(Icons.car_rental,'Rent Car',Colors.purple,Color(0xFFF5EFFF)),catBox(Icons.fastfood,'Food',Colors.deepOrange,Color(0xFFFFF0ED)),catBox(Icons.build,'Services',Colors.teal,Color(0xFFEFFCFF)),
]),
const SizedBox(height:16),const Text('Popular Services',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:10),
GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:4,children:[popIcon(Icons.ac_unit,'Aircon'),popIcon(Icons.cleaning_services,'Cleaning'),popIcon(Icons.plumbing,'Tubero'),popIcon(Icons.handyman,'Renovation'),popIcon(Icons.electrical_services,'Electrical'),popIcon(Icons.directions_bus,'Bus'),popIcon(Icons.spa,'Spa'),popIcon(Icons.self_improvement,'Yoga')]),
const SizedBox(height:10),const Text('Available Now -',style:TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:90),
])),
floatingActionButton:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.end,children:[
Container(padding:const EdgeInsets.symmetric(horizontal:16,vertical:12),decoration:BoxDecoration(color:const Color(0xFF1A8E3E),borderRadius:BorderRadius.circular(20)),child:const Row(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.credit_card,color:Colors.blue),SizedBox(width:8),Text('Akong GoTyme/GCash/Bank')])),
const SizedBox(height:8),
Container(padding:const EdgeInsets.symmetric(horizontal:18,vertical:12),decoration:BoxDecoration(color:Colors.deepOrange,borderRadius:BorderRadius.circular(20)),child:const Row(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.add_a_photo,color:Colors.indigo),SizedBox(width:8),Text('MAG POST + PICTURE',style:TextStyle(fontWeight:FontWeight.bold))])),
]),
);
}
}
Widget catBox(IconData ic,String t,Color icC,Color bg){return Container(decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(12),border:Border.all(color:Colors.black12)),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(ic,color:icC,size:22),const SizedBox(width:6),Text(t,style:const TextStyle(fontWeight:FontWeight.w600,fontSize:13))]));}
Widget popIcon(IconData ic,String t){return Column(children:[Container(padding:const EdgeInsets.all(14),decoration:const BoxDecoration(color:Color(0xFFF0F0F0),shape:BoxShape.circle),child:Icon(ic,color:Colors.teal,size:26)),const SizedBox(height:4),Text(t,style:const TextStyle(fontSize:11))]);}
