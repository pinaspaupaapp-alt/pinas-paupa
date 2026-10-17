import 'package:flutter/material.dart';
void main(){runApp(const App());}
class App extends StatelessWidget{
  const App({super.key});
  @override Widget build(BuildContext context){
    return const MaterialApp(debugShowCheckedModeBanner:false,home:Main());
  }
}
class Listing{
  String title;
  String cat;
  int price;
  int photos;
  String host;
  Listing(this.title,this.cat,this.price,this.photos,this.host);
}
class Main extends StatefulWidget{
  const Main({super.key});
  @override State<Main> createState()=>MainState();
}
class MainState extends State<Main>{
  int idx=0;
  @override Widget build(BuildContext context){
    List<Widget> pages=[];
    pages.add(const Explore());
    pages.add(const Wish());
    pages.add(const Trips());
    pages.add(const Msgs());
    pages.add(const Profile());
    return Scaffold(
      body:pages[idx],
      bottomNavigationBar:BottomNavigationBar(
        currentIndex:idx,
        onTap:(v){setState((){idx=v;});},
        type:BottomNavigationBarType.fixed,
        selectedItemColor:const Color(0xFF1A8E3E),
        items:const [
          BottomNavigationBarItem(icon:Icon(Icons.travel_explore),label:'Explore'),
          BottomNavigationBarItem(icon:Icon(Icons.favorite_border),label:'Wishlists'),
          BottomNavigationBarItem(icon:Icon(Icons.card_travel),label:'Trips'),
          BottomNavigationBarItem(icon:Icon(Icons.message_outlined),label:'Messages'),
          BottomNavigationBarItem(icon:Icon(Icons.person_outline),label:'Profile'),
        ]
      )
    );
  }
}
class Explore extends StatelessWidget{
  const Explore({super.key});
  @override Widget build(BuildContext context){
    return SafeArea(
      child:Column(
        children:[
          Container(
            color:const Color(0xFF1A8E3E),
            padding:const EdgeInsets.all(12),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:[
                const Text('Pinas Paupa',style:TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold)),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(backgroundColor:Colors.white,foregroundColor:const Color(0xFF1A8E3E)),
                  onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>const SubPlan()));},
                  child:const Text('Register')
                )
              ]
            )
          ),
          Expanded(
            child:SingleChildScrollView(
              padding:const EdgeInsets.all(12),
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Container(
                    decoration:BoxDecoration(color:const Color(0xFF1A8E3E),borderRadius:BorderRadius.circular(12)),
                    child:const TextField(
                      decoration:InputDecoration(
                        hintText:'Search Airbnb, House, Lot, Services...',
                        hintStyle:TextStyle(color:Colors.white70),
                        prefixIcon:Icon(Icons.search,color:Colors.white),
                        border:InputBorder.none,
                        contentPadding:EdgeInsets.all(14)
                      ),
                      style:TextStyle(color:Colors.white)
                    )
                  ),
                  const SizedBox(height:14),
                  const Text('Category',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                  const SizedBox(height:8),
                  GridView.count(
                    shrinkWrap:true,
                    physics:const NeverScrollableScrollPhysics(),
                    crossAxisCount:2,
                    childAspectRatio:2.8,
                    mainAxisSpacing:8,
                    crossAxisSpacing:8,
                    children:[
                      catBox(context,'Airbnb',Icons.home,const Color(0xFFFFE8E9)),
                      catBox(context,'House Rent',Icons.house_siding,const Color(0xFFE8F5E9)),
                      catBox(context,'House Sale',Icons.house,const Color(0xFFE3F2FD)),
                      catBox(context,'Lot Rent',Icons.terrain,const Color(0xFFFFF8E1)),
                      catBox(context,'Lot Sale',Icons.landscape,const Color(0xFFEFEBE9)),
                      catBox(context,'Rent Car',Icons.car_rental,const Color(0xFFF3E5F5)),
                      catBox(context,'Food',Icons.fastfood,const Color(0xFFFFEBEE)),
                      catBox(context,'Services',Icons.build,const Color(0xFFE0F7FA)),
                    ]
                  ),
                  const SizedBox(height:14),
                  const Text('Popular Services',style:TextStyle(fontWeight:FontWeight.bold)),
                  const SizedBox(height:14),
                  Card(
                    child:ListTile(
                      title:const Text('Cozy Airbnb Tizimin'),
                      subtitle:const Text('Airbnb - P1500 - 8 photos'),
                      trailing:Row(
                        mainAxisSize:MainAxisSize.min,
                        children:[
                          IconButton(icon:const Icon(Icons.photo_library,color:Color(0xFF1A8E3E)),onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>UploadPage()));}),
                          IconButton(icon:const Icon(Icons.chat,color:Color(0xFF1A8E3E)),onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>ChatPage()));})
                        ]
                      )
                    )
                  ),
                  Card(
                    child:ListTile(
                      title:const Text('House Rent Cebu'),
                      subtitle:const Text('House Rent - P12000 - 5 photos'),
                      trailing:Row(
                        mainAxisSize:MainAxisSize.min,
                        children:[
                          IconButton(icon:const Icon(Icons.photo_library,color:Color(0xFF1A8E3E)),onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>UploadPage()));}),
                          IconButton(icon:const Icon(Icons.chat,color:Color(0xFF1A8E3E)),onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>ChatPage()));})
                        ]
                      )
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}
Widget catBox(BuildContext c,String t,IconData ic,Color bg){
  return InkWell(
    onTap:(){Navigator.push(c,MaterialPageRoute(builder:(_)=>UploadPage()));},
    child:Container(
      decoration:BoxDecoration(color:bg,borderRadius:BorderRadius.circular(10),border:Border.all(color:Colors.black12)),
      child:Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children:[
          Icon(ic,color:const Color(0xFF1A8E3E),size:20),
          const SizedBox(width:6),
          Text(t,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w600))
        ]
      )
    )
  );
}
class UploadPage extends StatefulWidget{
  @override State<UploadPage> createState()=>UploadState();
}
class UploadState extends State<UploadPage>{
  int cnt=8;
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor:const Color(0xFF1A8E3E),foregroundColor:Colors.white,title:const Text('Upload Photos'),centerTitle:true),
      body:SingleChildScrollView(
        padding:const EdgeInsets.all(14),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            const Center(child:Text('Upload - Upload Picture',style:TextStyle(color:Colors.grey,fontSize:11))),
            const SizedBox(height:10),
            const Text('Add Property Photos',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
            const Text('Upload up to 10 photos of your space',style:TextStyle(color:Colors.grey,fontSize:12)),
            const SizedBox(height:10),
            GridView.builder(
              shrinkWrap:true,
              physics:const NeverScrollableScrollPhysics(),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4,crossAxisSpacing:6,mainAxisSpacing:6),
              itemCount:cnt,
              itemBuilder:(ctx,i){
                return Stack(
                  children:[
                    Container(decoration:BoxDecoration(color:Colors.grey[200],borderRadius:BorderRadius.circular(6)),child:Center(child:Icon(Icons.image,color:Colors.grey[500]))),
                    Positioned(top:0,right:0,child:InkWell(onTap:(){setState((){cnt--;});},child:const Icon(Icons.close,size:18,color:Colors.red)))
                  ]
                );
              }
            ),
            const SizedBox(height:10),
            InkWell(
              onTap:(){setState((){if(cnt<10){cnt++;}});},
              child:Container(
                width:double.infinity,
                padding:const EdgeInsets.all(12),
                decoration:BoxDecoration(border:Border.all(color:const Color(0xFF1A8E3E)),borderRadius:BorderRadius.circular(8)),
                child:const Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.add,color:Color(0xFF1A8E3E)),Text(' Add More Photos',style:TextStyle(color:Color(0xFF1A8E3E),fontWeight:FontWeight.bold))])
              )
            ),
            const SizedBox(height:10),
            Container(padding:const EdgeInsets.all(10),decoration:BoxDecoration(color:const Color(0xFFE8F5E9),borderRadius:BorderRadius.circular(8)),child:const Row(children:[Icon(Icons.check_box,color:Color(0xFF1A8E3E)),SizedBox(width:8),Text('Clear, well-lit photos get more bookings',style:TextStyle(fontSize:12))])),
            const SizedBox(height:14),
            SizedBox(width:double.infinity,height:48,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF1A8E3E)),onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('$cnt photos uploaded!')));Navigator.pop(context);},child:const Text('Continue',style:TextStyle(color:Colors.white))))
          ]
        )
      )
    );
  }
}
class ChatPage extends StatefulWidget{
  @override State<ChatPage> createState()=>ChatState();
}
class ChatState extends State<ChatPage>{
  TextEditingController ctrl=TextEditingController();
  List<String> texts=[];
  List<bool> isMe=[];
  List<String> times=[];
  @override void initState(){
    super.initState();
    texts.add('Hi Maria! Is the property available for Dec 15-18?');
    isMe.add(true);
    times.add('10:32 AM');
    texts.add('Yes! Available. Fully furnished and free wifi');
    isMe.add(false);
    times.add('10:33 AM');
    texts.add('Can we viewing tomorrow morning?');
    isMe.add(true);
    times.add('10:34 AM');
    texts.add('Sure, 9am works. I send address.');
    isMe.add(false);
    times.add('10:35 AM');
  }
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:PreferredSize(
        preferredSize:const Size.fromHeight(65),
        child:AppBar(
          backgroundColor:const Color(0xFF1A8E3E),
          foregroundColor:Colors.white,
          title:Row(
            children:[
              const CircleAvatar(child:Icon(Icons.person)),
              const SizedBox(width:10),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  const Text('Maria Santos - Host',style:TextStyle(fontSize:14)),
                  Row(children:const [Icon(Icons.circle,color:Colors.lightGreenAccent,size:10),Text(' Usually responds within 1 hour',style:TextStyle(fontSize:11))])
                ]
              )
            ]
          )
        )
      ),
      body:Column(
        children:[
          Expanded(
            child:ListView.builder(
              padding:const EdgeInsets.all(10),
              itemCount:texts.length,
              itemBuilder:(ctx,i){
                return Align(
                  alignment:isMe[i]?Alignment.centerRight:Alignment.centerLeft,
                  child:Column(
                    crossAxisAlignment:isMe[i]?CrossAxisAlignment.end:CrossAxisAlignment.start,
                    children:[
                      Container(
                        margin:const EdgeInsets.symmetric(vertical:3),
                        padding:const EdgeInsets.all(10),
                        decoration:BoxDecoration(color:isMe[i]?const Color(0xFFDCF8C6):Colors.white,borderRadius:BorderRadius.circular(10)),
                        child:Text(texts[i])
                      ),
                      Text(times[i],style:const TextStyle(fontSize:9,color:Colors.grey))
                    ]
                  )
                );
              }
            )
          ),
          Container(
            padding:const EdgeInsets.all(6),
            child:Row(
              children:[
                IconButton(icon:const Icon(Icons.attach_file),onPressed:(){setState((){texts.add('[Photo uploaded]');isMe.add(true);times.add('Now');});}),
                Expanded(child:TextField(controller:ctrl,decoration:InputDecoration(hintText:'Write a message...',filled:true,fillColor:Colors.grey[100],border:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide.none)))),
                IconButton(icon:const Icon(Icons.send,color:Color(0xFF1A8E3E)),onPressed:(){if(ctrl.text.isNotEmpty){setState((){texts.add(ctrl.text);isMe.add(true);times.add('Now');});ctrl.clear();}})
              ]
            )
          )
        ]
      )
    );
  }
}
class SubPlan extends StatefulWidget{
  const SubPlan({super.key});
  @override State<SubPlan> createState()=>SubState();
}
class SubState extends State<SubPlan>{
  String pay='GCash';
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor:const Color(0xFF1A8E3E),foregroundColor:Colors.white,title:const Text('Subscription Plan'),centerTitle:true),
      body:SingleChildScrollView(
        padding:const EdgeInsets.all(14),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            const Center(child:Column(children:[Text('Register as Host',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),Text('Unlock hosting features with yearly plan',style:TextStyle(fontSize:11,color:Colors.grey))])),
            const SizedBox(height:14),
            Container(
              padding:const EdgeInsets.all(12),
              decoration:BoxDecoration(color:const Color(0xFFC8E6C9),borderRadius:BorderRadius.circular(10)),
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children:[
                      const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Pinas Paupa Host - Yearly',style:TextStyle(fontWeight:FontWeight.bold)),Text('P1999 / year',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Color(0xFF1A8E3E)))]),
                      Container(padding:const EdgeInsets.symmetric(horizontal:6,vertical:3),decoration:BoxDecoration(color:const Color(0xFF1A8E3E),borderRadius:BorderRadius.circular(10)),child:const Text('Recommended',style:TextStyle(color:Colors.white,fontSize:10)))
                    ]
                  ),
                  const SizedBox(height:6),
                  checkRow('Unlimited property listings'),
                  checkRow('Priority in search results'),
                  checkRow('Direct chat with guests'),
                  checkRow('Analytics and insights'),
                  checkRow('24/7 host support'),
                ]
              )
            ),
            const SizedBox(height:12),
            const Text('Payment Method',style:TextStyle(fontWeight:FontWeight.bold)),
            const SizedBox(height:6),
            payRow('GCash','Pay via GCash Wallet',pay=='GCash',(){setState((){pay='GCash';});}),
            payRow('GoTyme','Pay via GoTyme Bank',pay=='GoTyme',(){setState((){pay='GoTyme';});}),
            payRow('Bank Transfer','BDO, BPI, Metrobank, UnionBank',pay=='Bank Transfer',(){setState((){pay='Bank Transfer';});}),
            const SizedBox(height:10),
            SizedBox(
              width:double.infinity,
              height:46,
              child:ElevatedButton.icon(
                style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFF1A8E3E)),
                icon:const Icon(Icons.lock,color:Colors.white,size:16),
                label:Text('Pay P1999 per year via '+pay,style:const TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),
                onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Paid via '+pay+'! Yearly active until 2027!')));Navigator.pop(context);}
              )
            )
          ]
        )
      )
    );
  }
}
Widget checkRow(String t){
  return Row(children:[const Icon(Icons.check,color:Color(0xFF1A8E3E),size:16),const SizedBox(width:4),Text(t,style:const TextStyle(fontSize:11))]);
}
Widget payRow(String n,String d,bool s,VoidCallback tap){
  return InkWell(
    onTap:tap,
    child:Container(
      margin:const EdgeInsets.only(bottom:6),
      padding:const EdgeInsets.all(10),
      decoration:BoxDecoration(border:Border.all(color:s?const Color(0xFF1A8E3E):Colors.black12),borderRadius:BorderRadius.circular(8),color:s?const Color(0xFFE8F5E9):Colors.white),
      child:Row(
        children:[
          Icon(Icons.account_balance_wallet,color:s?const Color(0xFF1A8E3E):Colors.grey),
          const SizedBox(width:8),
          Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(n,style:TextStyle(fontWeight:FontWeight.bold,color:s?const Color(0xFF1A8E3E):Colors.black)),Text(d,style:const TextStyle(fontSize:11,color:Colors.grey))])),
          const Icon(Icons.arrow_forward,size:14)
        ]
      )
    )
  );
}
class Wish extends StatelessWidget{
  const Wish({super.key});
  @override Widget build(BuildContext context){
    return Scaffold(appBar:AppBar(title:const Text('Wishlists')),body:const Center(child:Text('No wishlist')));
  }
}
class Trips extends StatelessWidget{
  const Trips({super.key});
  @override Widget build(BuildContext context){
    return Scaffold(body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:const [Icon(Icons.map,size:80,color:Colors.blueGrey),Text('2 listings on map')])));
  }
}
class Msgs extends StatelessWidget{
  const Msgs({super.key});
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:const Text('Messages')),
      body:ListView(
        children:[
          ListTile(leading:const CircleAvatar(child:Text('M')),title:const Text('Chat with Maria Santos'),subtitle:const Text('Cozy Airbnb Tizimin'),onTap:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>ChatPage()));}),
          ListTile(leading:const CircleAvatar(child:Text('J')),title:const Text('Chat with Juan'),subtitle:const Text('House Rent Cebu'),onTap:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>ChatPage()));})
        ]
      )
    );
  }
}
class Profile extends StatelessWidget{
  const Profile({super.key});
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:const Text('Profile',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold))),
      body:ListView(
        children:[
          ListTile(leading:const Icon(Icons.settings),title:const Text('Account settings'),trailing:const Icon(Icons.chevron_right),onTap:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>const SubPlan()));}),
          ListTile(leading:const Icon(Icons.card_membership,color:Color(0xFF1A8E3E)),title:const Text('Subscription P1999 per year'),subtitle:const Text('Bayad yearly para maka upload'),trailing:const Icon(Icons.chevron_right),onTap:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>const SubPlan()));}),
          const Divider(),
          const ListTile(leading:Icon(Icons.help_outline),title:Text('Get help')),
          const ListTile(leading:Icon(Icons.logout),title:Text('Log out'))
        ]
      )
    );
  }
}
