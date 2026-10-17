import 'package:flutter/material.dart';
void main(){runApp(const MyApp());}
class MyApp extends StatelessWidget{
const MyApp({super.key});
@override Widget build(BuildContext context){
return const MaterialApp(debugShowCheckedModeBanner:false,home: HomePage());
}
}

class Item{
String title; String cat; String price; String owner;
Item(this.title,this.cat,this.price,this.owner);
}

class HomePage extends StatefulWidget{
const HomePage({super.key});
@override State<HomePage> createState()=>_HomePageState();
}

class _HomePageState extends State<HomePage>{
String search=''; String filter='All';
List<Item> all=[
Item('Airbnb Beach House','Airbnb','₱1,500/night','Juan'),
Item('House Rent Tizimin','House Rent','₱8,000/mo','Maria'),
Item('House Sale Merida','House Sale','₱2.5M','Pedro'),
Item('Lot Rent 200sqm','Lot Rent','₱3,000/mo','Ana'),
Item('Lot Sale 500sqm','Lot Sale','₱500k','Jose'),
Item('Toyota Rent','Rent Car','₱1,200/day','Carlos'),
Item('Lechon Package','Food','₱850','Lola'),
Item('Aircon Cleaning','Services','₱500','Tubero'),
];
TextEditingController tTitle=TextEditingController();
TextEditingController tPrice=TextEditingController();
String newCat='Airbnb';

List<Item> get list{
return all.where((e){
bool s = e.title.toLowerCase().contains(search.toLowerCase()) || e.cat.toLowerCase().contains(search.toLowerCase());
bool f = filter=='All' || e.cat==filter;
return s && f;
}).toList();
}

void doPost(){
showModalBottomSheet(context:context,isScrollControlled:true,builder:(c){
return Padding(padding:EdgeInsets.only(bottom:MediaQuery.of(c).viewInsets.bottom),child:Container(padding:const EdgeInsets.all(16),child:Column(mainAxisSize:MainAxisSize.min,children:[
const Text('MAG POST + PICTURE',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
const SizedBox(height:10),
TextField(controller:tTitle,decoration:const InputDecoration(labelText:'Title',border:OutlineInputBorder())),
const SizedBox(height:8),
DropdownButtonFormField(value:newCat,items:const [DropdownMenuItem(value:'Airbnb',child:Text('Airbnb')),DropdownMenuItem(value:'House Rent',child:Text('House Rent')),DropdownMenuItem(value:'House Sale',child:Text('House Sale')),DropdownMenuItem(value:'Lot Rent',child:Text('Lot Rent')),DropdownMenuItem(value:'Lot Sale',child:Text('Lot Sale')),DropdownMenuItem(value:'Rent Car',child:Text('Rent Car')),DropdownMenuItem(value:'Food',child:Text('Food')),DropdownMenuItem(value:'Services',child:Text('Services'))],onChanged:(v){setState(()=>newCat=v!);},decoration:const InputDecoration(border:OutlineInputBorder(),labelText:'Category')),
const SizedBox(height:8),
TextField(controller:tPrice,decoration:const InputDecoration(labelText:'Price',border:OutlineInputBorder())),
const SizedBox(height:12),
SizedBox(width:double.infinity,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.deepOrange),onPressed:(){
if(tTitle.text.isEmpty) return;
setState(()=>all.insert(0,Item(tTitle.text,newCat,tPrice.text.isEmpty?'₱0':tPrice.text,'Ikaw')));
tTitle.clear(); tPrice.clear();
Navigator.pop(c);
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Posted na!')));
},child:const Text('POST NA! + PICTURE'))),
])));
});
}

void doChat(Item it){
Navigator.push(context,MaterialPageRoute(builder:(_)=>ChatScreen(item:it)));
}

void doWallet(){
showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Akong GoTyme/GCash/Bank'),content:const Text('Balance: ₱12,500\nGoTyme: 0123-4567\nGCash: 0912-345-6789\nBDO: 1234-5678\n\nPwede magbayad ang guest!'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('OK'))]));
}

@override Widget build(BuildContext context){
return Scaffold(
backgroundColor:Colors.white,
appBar:AppBar(backgroundColor:const Color(0xFF1A8E3E),title:const Text('Pinas Paupa 🇵🇭',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold))),
body:SingleChildScrollView(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:6),decoration:BoxDecoration(color:const Color(0xFF1A8E3E),borderRadius:BorderRadius.circular(20)),child:Row(children:[const Icon(Icons.search,color:Colors.white70),const SizedBox(width:8),Expanded(child:TextField(onChanged:(v)=>setState(()=>search=v),style:const TextStyle(color:Colors.white),decoration:const InputDecoration(border:InputBorder.none,hintText:'Search Airbnb, House, Lot, Services...',hintStyle:TextStyle(color:Colors.white70))))])),
const SizedBox(height:12),
const Text('Pangitaon?',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
const SizedBox(height:10),
GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:2,childAspectRatio:2.8,mainAxisSpacing:10,crossAxisSpacing:10,children:[
cBox(Icons.home,'Airbnb',Colors.red,const Color(0xFFFFF0F0),()=>setState(()=>filter='Airbnb')),
cBox(Icons.home_work,'House Rent',Colors.green,const Color(0xFFEFFAF0),()=>setState(()=>filter='House Rent')),
cBox(Icons.house,'House Sale',Colors.blue,const Color(0xFFEFF8FF),()=>setState(()=>filter='House Sale')),
cBox(Icons.terrain,'Lot Rent',Colors.orange,const Color(0xFFFFF8E8),()=>setState(()=>filter='Lot Rent')),
cBox(Icons.landscape,'Lot Sale',Colors.brown,const Color(0xFFF5F5F0),()=>setState(()=>filter='Lot Sale')),
cBox(Icons.car_rental,'Rent Car',Colors.purple,const Color(0xFFF5EFFF),()=>setState(()=>filter='Rent Car')),
cBox(Icons.fastfood,'Food',Colors.deepOrange,const Color(0xFFFFF0ED),()=>setState(()=>filter='Food')),
cBox(Icons.build,'Services',Colors.teal,const Color(0xFFEFFCFF),()=>setState(()=>filter='Services')),
]),
if(filter!='All') ActionChip(label:Text('Filter: $filter X'),onPressed:()=>setState(()=>filter='All')),
const SizedBox(height:16),
const Text('Popular Services',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
const SizedBox(height:10),
GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:4,children:[
pBox(Icons.ac_unit,'Aircon',()=>setState(()=>filter='Services')),
pBox(Icons.cleaning_services,'Cleaning',()=>setState(()=>filter='Services')),
pBox(Icons.plumbing,'Tubero',()=>setState(()=>filter='Services')),
pBox(Icons.handyman,'Renovation',()=>setState(()=>filter='Services')),
pBox(Icons.electrical_services,'Electrical',()=>setState(()=>filter='Services')),
pBox(Icons.directions_bus,'Bus',()=>setState(()=>filter='Rent Car')),
pBox(Icons.spa,'Spa',()=>setState(()=>filter='Services')),
pBox(Icons.self_improvement,'Massage',()=>setState(()=>filter='Services')),
]),
const SizedBox(height:16),
Text('Available Now - ${list.length} found',style:const TextStyle(fontWeight:FontWeight.bold)),
ListView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),itemCount:list.length,itemBuilder:(c,i){
var it=list[i];
return Card(child:ListTile(leading:Container(width:50,height:50,decoration:BoxDecoration(color:Colors.grey[200],borderRadius:BorderRadius.circular(8)),child:const Icon(Icons.image)),title:Text(it.title,style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${it.cat} • ${it.price}\nOwner: ${it.owner}'),isThreeLine:true,trailing:IconButton(icon:const Icon(Icons.chat,color:Colors.green),onPressed:()=>doChat(it)),onTap:()=>doChat(it)));
}),
const SizedBox(height:90),
])),
floatingActionButton:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.end,children:[
FloatingActionButton.extended(heroTag:'w',backgroundColor:const Color(0xFF1A8E3E),onPressed:doWallet,icon:const Icon(Icons.credit_card),label:const Text('Akong GoTyme/GCash/Bank',style:TextStyle(fontSize:11))),
const SizedBox(height:8),
FloatingActionButton.extended(heroTag:'p',backgroundColor:Colors.deepOrange,onPressed:doPost,icon:const Icon(Icons.add_a_photo),label:const Text('MAG POST + PICTURE',style:TextStyle(fontWeight:FontWeight.bold))),
]),
);
}
Widget cBox(IconData ic,String t,Color icC,Color bg,VoidCallback tap){return InkWell(onTap:tap,child:Container(decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(12),border:Border.all(color:Colors.black12)),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(ic,color:icC,size:20),const SizedBox(width:5),Text(t,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w600))])));}
Widget pBox(IconData ic,String t,VoidCallback tap){return InkWell(onTap:tap,child:Column(children:[Container(padding:const EdgeInsets.all(12),decoration:const BoxDecoration(color:Color(0xFFF0F0F0),shape:BoxShape.circle),child:Icon(ic,color:Colors.teal)),const SizedBox(height:4),Text(t,style:const TextStyle(fontSize:10))])));}
}

class ChatScreen extends StatefulWidget{
final Item item; const ChatScreen({super.key,required this.item}); @override State<ChatScreen> createState()=>_ChatScreenState();}
class _ChatScreenState extends State<ChatScreen>{
List<Map<String,dynamic>> msgs=[{'t':'Hi! Interested ko sa listing nimo!','me':false},{'t':'Hello! Yes available pa.','me':true}];
TextEditingController cc=TextEditingController();
void send(){if(cc.text.isEmpty) return; setState(()=>msgs.add({'t':cc.text,'me':true})); cc.clear(); Future.delayed(const Duration(seconds:1),(){setState(()=>msgs.add({'t':'Salamat sa reply! Meet tayo bukas? - ${widget.item.owner}','me':false}));});}
@override Widget build(BuildContext context){
return Scaffold(appBar:AppBar(backgroundColor:const Color(0xFF1A8E3E),title:Text('Chat ${widget.item.owner}',style:const TextStyle(fontSize:16))),body:Column(children:[
ListTile(title:Text(widget.item.title,style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text(widget.item.price)),
Expanded(child:ListView.builder(padding:const EdgeInsets.all(12),itemCount:msgs.length,itemBuilder:(_,i){var m=msgs[i]; return Align(alignment:m['me']?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:const EdgeInsets.only(bottom:8),padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:m['me']?const Color(0xFF1A8E3E):Colors.grey[300],borderRadius:BorderRadius.circular(12)),child:Text(m['t'],style:TextStyle(color:m['me']?Colors.white:Colors.black))));})),
Row(children:[Expanded(child:Padding(padding:const EdgeInsets.all(8),child:TextField(controller:cc,decoration:InputDecoration(hintText:'Reply sa guest...',border:OutlineInputBorder(borderRadius:BorderRadius.circular(20)))))),IconButton(icon:const Icon(Icons.send,color:Color(0xFF1A8E3E)),onPressed:send)]),
]));
}
}
