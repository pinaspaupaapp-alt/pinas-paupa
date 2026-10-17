import 'package:flutter/material.dart';
void main()=>runApp(const MyApp());
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override Widget build(BuildContext c){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar:AppBar(title:const Text('Pinas Paupa'),backgroundColor:const Color(0xFF1A8E3E)),
        body:const Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
          Icon(Icons.check_circle,size:80,color:Color(0xFF1A8E3E)),
          SizedBox(height:10),
          Text('Pinas Paupa - GREEN NA!',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
        ])),
      ),
    );
  }
}
