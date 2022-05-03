import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:home_crm/data/models/view_status.dart';
import 'package:home_crm/utils/app_colors.dart';
import 'package:home_crm/viewmodels/home_viewmodel.dart';
import 'package:home_crm/views/chat_view.dart';
import 'package:home_crm/views/new_lead.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
bool _first=false;


  @override
  Widget build(BuildContext context) {

    var size =  MediaQuery.of(context).size;
    final double itemHeight =(size.height -kTextTabBarHeight-24)/2;
    final double itemWidht =size.width/2;

    return 
    
    
    
    ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: ()=>HomeViewModel(),
    onModelReady: (model)async{
      model.fetchLeads();
    },
   
      builder: (context , ctrl ,child) {
        return Scaffold(
          // appBar: AppBar(elevation: 0.0,backgroundColor: Colors.green,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(bottomLeft:Radius.circular(.025) ,  bottomRight:Radius.circular(25)   )

          // ),
          // title: Text('Leads'),
          // actions: [
          //   IconButton(onPressed: (){}, icon: Icon(Icons.search)) ,

          // ],
          // ),
           body: 
           
          SafeArea(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: double.infinity,
                 height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                  
                  ),
                  child: Column(
                    children: [
                  Container(height: 80,width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text('Leads' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white ,fontSize: 20),) ,
                  
                IconButton(onPressed: ()async{


            
                }, icon: Icon(Icons.notifications , color: Colors.white,)) 
              ],
                  ),),
                  
                  ),
                  
                  
                       Expanded(
                         child: AnimatedCrossFade(
                         firstCurve: Curves.easeOutBack,
                         secondCurve: Curves.easeInBack,
                         firstChild: Container(
                            height: MediaQuery.of(context).size.height,
                           width: double.infinity,
                          decoration: BoxDecoration(
                             color: Colors.white,
                             
                                       borderRadius: BorderRadius.only(topRight:Radius.circular(25) ,  topLeft:Radius.circular(25)   )
            
                          ),
                           child: 
                           ViewModelBuilder<HomeViewModel>.reactive(
                             viewModelBuilder: ()=>HomeViewModel(), 
                             
                             onModelReady: (mdl)async{
                            await   mdl.fetchLeads();
                             },
                             builder: (ctx , model , child){

                             if (model.state ==ViewState.BUSY) {
                               return Center(child: CircularProgressIndicator(),);
                             } 
                             
                             else if  (model.state ==ViewState.EROR){
  return Center(child: Text('Error'),);
                            
                            
                            
                            
                             }else {


                               if (model.leads .length >0) {
                                 return ListView.builder(
                                   itemCount: model.leads.length,
                                   itemBuilder: (BuildContext context, int index) {
                                     return 
                                     InkWell(
                                       onTap: ()async{
                                         ctrl.setLead(model.leads[index]);
                                         ctrl.toggleShow(false);
                                       },
                                       child: Container(
                                     height: 150,
                                     margin: EdgeInsets.all(8),
                                     
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(20),
                                           boxShadow: [
                                             BoxShadow(
                                               color: Colors.grey.withOpacity(.05),
                                     offset: Offset(0 ,-4)
                                             )
                                           ]
                                         ),
                                     child:  Column(
                                       children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 CircleAvatar(
                                                   backgroundColor: Colors.green,
                                                   radius: 40,
                                                   child: Center(child:Text(model.leads[index].name!.substring(0,1).toUpperCase() ,
                                                    style: TextStyle(fontWeight: FontWeight.bold),)),
                                                 
                                                 ) ,
                                     
                                                 Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                     
                                                   children: [
                                     Text(model.leads[index].name!),
                                     SizedBox(height: 15,),
                                     Row(mainAxisSize: MainAxisSize.min ,
                                     children: [
                                       Text("created At: "),
                                       SizedBox(width: 8,),
                                     Text(model.leads[index].createdAt!),
                                     
                                     ],)
                                     
                                                   ],
                                                 ) ,
                                                 IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
                                               ],
                                             ) ,
                                     
                                             Row(mainAxisAlignment: MainAxisAlignment.end,
                                             
                                             children: [
                                               Container(width: 40,height: 40,
                                               
                                               decoration: BoxDecoration(
                                                 color: Colors.grey.withOpacity(0.1),
                                                 shape: BoxShape.circle
                                               ),
                                               
                                               child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.location_on)),),
                                               ),
                                     SizedBox(width: 10,),
                                                Container(width: 40,height: 40,
                                               
                                               decoration: BoxDecoration(
                                                 color: Colors.grey.withOpacity(0.1),
                                                 shape: BoxShape.circle ,
                                                 
                                               ),
                                               
                                                     child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.call)),),
                                     
                                               )
                                             ],
                                             )
                                       ],
                                     )
                                     
                                       ),
                                     );
                                     
                                     ;
                                   },
                                 );
                               } else {
 return Center(child: Text('No Data'),);

                               }
                             }
                           })
                           
                           
                           
                           ),




                         secondChild: Container(
                           height: MediaQuery.of(context).size.height,
                           width: double.infinity,
                           color: Colors.white,
                           child:
                         ViewModelBuilder<HomeViewModel>.reactive(
                             viewModelBuilder: ()=>HomeViewModel(), 
                             
                             onModelReady: (mdl)async{
                            await   mdl.fetchLeads();
                             },
                             builder: (ctx , model , child){

                             if (model.state ==ViewState.BUSY) {
                               return Center(child: CircularProgressIndicator(),);
                             } 
                             
                             else if  (model.state ==ViewState.EROR){
  return Center(child: Text('Error'),);   
                           
                             }
                             else if(model.lead ==null){
                               return Center(child: Text('No one selected'),);   
                             }
                      return 
                      

                      
                          Stack(
                             children: [
                               Align(alignment: Alignment.topLeft,
                               child: InkWell(
                                 onTap: (){
                                    ctrl.toggleShow(true);

                                 },
                                 child: Container(
                                   width: 30,height: 30,
                                   margin: EdgeInsets.all(10),
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle ,
                               color: Colors.red
                                   ),
                                   child: Center(
                                     child:
                                    //   IconButton(onPressed: (){
                                    //    ctrl.setLead(null);
                                    //  }, icon: 
                                     
                                     Icon(Icons.close ,color: Colors.white,size: 15,)
                                     //),
                                   ),
                                 ),
                               ),
                               ) ,
                               Column(
                                 children: [
                                   SizedBox(height: 20,),
                                   Center(
                                     child: CircleAvatar(
                                       radius: 80,
                                       backgroundColor: Colors.green,
                                       child: Text(model.lead!.name!.substring(0,1).toUpperCase() ,
                                       style: TextStyle(fontWeight: FontWeight.w900 ,fontSize: 25),
                                       ),
                                     ),
                                   ) ,
                                      SizedBox(height: 10,),
                                     
                                      Text(model.lead!.name !,  style: TextStyle(color: Colors.green , fontWeight: FontWeight.bold ,fontSize: 20), ) ,
 SizedBox(height: 10,),
                                     
                                     
                                     
                                      Text(model.lead!.email!,  style: TextStyle(color: Colors.green  ,fontSize: 20), ) ,

SizedBox(height: 30,) ,
Expanded(
  child:   Container(
    margin: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), 
      
      topRight: Radius.circular(20), 


      )
    ),
  child: Center(child: GridView.count(crossAxisCount: 2 ,
 // childAspectRatio: (itemHeight/itemWidht),
 
  children: [
     InkWell(
       onTap: ()async{
         await launchUrl(Uri(
        scheme:
        'tel' ,  path: '${ctrl.lead!.phone}'));
      
       },
       child: Container(width: 80,height: 80,
         margin: EdgeInsets.all(10),
         decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle ,
        
       
         ),
         child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.call , color: Colors.green,size: 30,) ,
          Text('Call', style: TextStyle(color: Colors.green ,  fontSize: 25),) ,
     
        ],
         ),),
         ),
     ) ,
     InkWell(
       onTap: ()async{
      
      await launchUrl(Uri(
        scheme:
        'sms' ,  path: '${ctrl.lead!.phone}'));
      
      
      //   Navigator.push(context, MaterialPageRoute(builder: ((context) => ChatView(lead: ctrl.lead,))));
       },
       child: Container(width: 80,height: 80,
         margin: EdgeInsets.all(10),
         decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
       
         ),
      child:    Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.message , color: Colors.green,size: 30,) ,
          Text('Text', style: TextStyle(color: Colors.green ,  fontSize: 25),) ,
     
        ],
         ),),
         ),
     ),
     InkWell(
       onTap: ()async{
         final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path:ctrl.lead!.email,
  query: json.encode(<String, String>{
    'subject': 'Hello  , mr ${ctrl.lead!.name}'
  }),
);

await launchUrl(emailLaunchUri);
       
            await launchUrl(Uri(
      scheme:
      'tel:${ctrl.lead!.phone}'));
       },
       child: Container(width: 80,height: 80,
         margin: EdgeInsets.all(10),
         decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
       
         ),
         child:  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.email , color: Colors.green,size: 30,) ,
          Text('Email', style: TextStyle(color: Colors.green ,  fontSize: 25),) ,
          
        ],
         ),),
         ),
     ) ,
     InkWell(
       onTap:()async{
         log('https://www.google.com/maps/dir/?api=1&destination=${ctrl.lead!.lat},${ctrl.lead!.lon}');

var uri =Uri.parse(
  // scheme:
  'https://www.google.com/maps/search/?api=1&query=${ctrl.lead!.lat},${ctrl.lead!.lon}');
  await launchUrl(uri);
       } ,
       child: Container(width: 80,height: 80,
         margin: EdgeInsets.all(10),
         decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
       
         ),
         child:  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.location_on , color: Colors.green,size: 30,) ,
          Text('GPS', style: TextStyle(color: Colors.green ,  fontSize: 25),) ,
     
        ],
         ),),
         ),
     )
  ],
  ),),
  ),
)


                                 ],
                               )
                             ],
                           );
                             }
                         )
                         
      
      
                           
                           
                           ),
                         crossFadeState:
                       ctrl.showFirst      ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                         duration: Duration(milliseconds: 800),        
                       ),
                       ),
                    ],
                  ),
              ),
            ),
          ) ,
           
           
           
         floatingActionButton: FloatingActionButton(onPressed: () {

           setState((){
_first = !_first;
           });

           Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewLead()));

         }  ,  
         backgroundColor: AppColors.primary,
         child: Icon(Icons.add ,color: AppColors.onPrimary,),
         
         ), 
        );
      }
    );
  }
}

