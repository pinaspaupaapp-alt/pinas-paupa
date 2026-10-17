import 'package:flutter/material.dart';
void main(){runApp(const App());}
class App extends StatelessWidget{
  const App({super.key});
  @override Widget build(BuildContext c){
    return const MaterialApp(debugShowCheckedModeBanner:false,home:Main());
  }
}
class Main extends StatefulWidget{
  const Main({super.key});
  @override State<Main> createState()=>MainState();
}
class MainState extends State<Main>{
  int idx=0;
  final pages=[const Explore(),const Wish(),const Trips(),const Msgs(),const Profile()];
  @override Widget build(BuildContext c){
    return Scaffold(
      body:pages,
      bottomNavigationBar:BottomNavigationBar(
        currentIndex:idx,
        onTap:(v){setState(()=>idx=v);},
        type:BottomNavigationBarType.fixed,
        selectedItemColor:const Color(0xFF1A8E3E),
        items:const [
          BottomNavigationBarItem(icon:Icon(Icons.explore),label:'Explore'),
          BottomNavigationBarItem(icon:Icon(Icons.favorite),label:'Wish'),
          BottomNavigationBarItem(icon:Icon(Icons.map),label:'Trips'),
          BottomNavigationBarItem(icon:Icon(Icons.message),label:'Messages'),
          BottomNavigationBarItem(icon:Icon(Icons.person),label:'Profile'),
        ]
      )
    );
  }
}
class Explore extends StatelessWidget{
  const Explore({super.key});
  @override Widget build(BuildContext c){
    return Scaffold(
      appBar:AppBar(backgroundColor:const Color(0xFF1A8E3E),title:const Text('Pinas Paupa',style:TextStyle(color:Colors.white))),
      body:ListView(
        padding:const EdgeInsets.all(12),
        children:[
          Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:const Color(0xFF1A8E3E),borderRadius:BorderRadius.circular(10)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[const Text('Search Airbnb, House, Lot...',style:TextStyle(color:Colors.white70)),ElevatedButton(onPressed:(){Navigator.push(c,MaterialPageRoute(builder:()=>const SubPlan()));},child:const Text('Register'))])),
          const SizedBox(height:12),
          const Text('Category',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          const SizedBox(height:8),
          GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:2,childAspectRatio:3,mainAxisSpacing:8,crossAxisSpacing:8,children:[cat(c,'Airbnb'),cat(c,'House Rent'),cat(c,'House Sale'),cat(c,'Lot Sale'),cat(c,'Car Rent'),cat(c,'Food'),cat(c,'Services'),cat(c,'Lot Rent')]),
          const SizedBox(height:12),
          const Text('Listings',style:TextStyle(fontWeight:FontWeight.bold)),
          Card(child:ListTile(title:const Text('Cozy Airbnb Tizimin - P1500 - 8 photos'),subtitle:const Text('Airbnb'),trailing:IconButton(icon:const Icon(Icons.photo_library,color:Color(0xFF1A8E3E)),onPressed:(){Navigator.push(c,MaterialPageRoute(builder:(_)=>const UploadPage()));}))),
          Card(child:ListTile(title:const Text('House Rent Cebu - P12000'),subtitle:const Text('House Rent'),trailing:IconButton(icon:const Icon(Icons.chat,color:Color(0xFF1A8E3E)),onPressed:(){Navigator.push(c,MaterialPageRoute(builder:()=>const ChatPage()));}))),
        ]
      )
    );
  }
}
Widget cat(BuildContext c,String t){
  return InkWell(onTap:(){Navigator.push(c,MaterialPageRoute(builder:()=>const UploadPage()));},child:Container(decoration:BoxDecoration(color:const Color(0xFFE8F5E9),borderRadius:BorderRadius.circular(8),border:Border.all(color:Colors.black12)),child:Center(child:Text(t,style:const TextStyle(fontWeight:FontWeight.bold)))));
}
class UploadPage extends StatelessWidget{
  const UploadPage({super.key});
  @override Widget build(BuildContext c){
    return Scaffold(
      appBar:AppBar(title:const Text('Upload Photos - Up to 10 - Maka upload picture!')),
      body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.photo_library,size:60,color:Color(0xFF1A8E3E)),const Text('Add More Photos Button Here'),const SizedBox(height:10),ElevatedButton(onPressed:(){Navigator.pop(c);},child:const Text('Continue'))]))
    );
  }
}
class ChatPage extends StatelessWidget{
  const ChatPage({super.key});
  @override Widget build(BuildContext c){
    return Scaffold(
      appBar:AppBar(title:const Text('Chat with Host - Usually responds within 1 hour')),
      body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[const Text('Hi! Available Dec 15-18? - Maka chats sa guest!'),ElevatedButton(onPressed:(){Navigator.pop(c);},child:const Text('Send Message'))]))
    );
  }
}
class SubPlan extends StatelessWidget{
  const SubPlan({super.key});
  @override Widget build(BuildContext c){
    return Scaffold(
      appBar:AppBar(title:const Text('Subscription P1999 per year')),
      body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[const Text('Pinas Paupa Host - Yearly'),const Text('P1999 / year - GCash - GoTyme - Bank Transfer'),const Text('Bayad yearly para maka upload'),const SizedBox(height:10),ElevatedButton(onPressed:(){Navigator.pop(c);},child:const Text('Pay P1999 - Yearly active until 2027!'))]))
    );
  }
}
class Wish extends StatelessWidget{const Wish({super.key});@override Widget build(BuildContext c){return const Scaffold(body:Center(child:Text('Wishlists')));}}
class Trips extends StatelessWidget{const Trips({super.key});@override Widget build(BuildContext c){return const Scaffold(body:Center(child:Text('Trips - 2 listings on map')));}}
class Msgs extends StatelessWidget{const Msgs({super.key});@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('Messages')),body:ListView(children:[ListTile(title:const Text('Chat with Maria Santos'),onTap:(){Navigator.push(c,MaterialPageRoute(builder:(_)=>const ChatPage()));})]));}}
class Profile extends StatelessWidget{const Profile({super.key});@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('Profile')),body:ListView(children:[ListTile(title:const Text('Subscription P1999 per year'),onTap:(){Navigator.push(c,MaterialPageRoute(builder:()=>const SubPlan()));})]));}}[idx]
