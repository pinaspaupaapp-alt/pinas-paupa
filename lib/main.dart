import 'package:flutter/material.dart';
void main(){runApp(PinasPaupaApp());}
class PinasPaupaApp extends StatelessWidget{
@override Widget build(BuildContext c){
return MaterialApp(debugShowCheckedModeBanner:false,home:PinasPaupaHome());}}
class PinasPaupaHome extends StatelessWidget{
@override Widget build(BuildContext c){
return Scaffold(appBar:AppBar(title:Text('Pinas Paupa'),backgroundColor:Colors.green[700],centerTitle:true),
body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
Icon(Icons.work,size:100,color:Colors.green[700]),SizedBox(height:20),
Text('Pinas Paupa',style:TextStyle(fontSize:32,fontWeight:FontWeight.bold)),
Text('Libre APK - Success!'),SizedBox(height:30),
ElevatedButton(onPressed:(){},style:ElevatedButton.styleFrom(backgroundColor:Colors.green[700]),
child:Text('Search Jobs',style:TextStyle(color:Colors.white)))])));}}
