import 'package:flutter/material.dart';
import 'package:home_crm/data/models/lead.dart';
import 'package:home_crm/viewmodels/chat_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StatefulWidget {
  final Lead? lead;
  const ChatView({ Key? key, this.lead }) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController messageController  =  new TextEditingController();
  ScrollController controller =ScrollController();
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
      
      
      ViewModelBuilder<ChatViewModel>.reactive(viewModelBuilder: ()=>ChatViewModel(), 
      
      onModelReady: (model){
        model.init();
      },
      builder: (ctx  ,ctrl ,child){


        return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.lead!.name!, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
          
           

           SizedBox(width: 20,),
           Visibility(
             visible: ctrl.isTyping,
             child: Text(widget.lead!.name!+" is Typing ..."))
          
          
            ],
          ),
          
          
          
          
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),

          
        ),
body: ListView.builder(
  controller: controller,
  itemCount: ctrl.messages.length,

  physics: BouncingScrollPhysics(),
  itemBuilder: (BuildContext context, int index) {
  //   if (ctrl.isTyping) {
  // //     return Align(
  // //  alignment: Alignment.centerRight,

  // //  child: Text(widget.lead!.name!+" typing"+" ..."),
  // //     );
  //   }
    return  Align(
       alignment: 
       ctrl.messages[index].fromMe!?
       Alignment.centerLeft:    Alignment.centerRight,
      child: Container(
        width: 200,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:   ctrl.messages[index].fromMe!?Colors.green:Colors.grey.withOpacity(0.4),
          borderRadius: 
           
          BorderRadius.circular(
  25
          )
          
        ),
        child: Center(child: Text(ctrl.messages[index].message! , style: TextStyle(color: Colors.white),),),),
    ) ;
  },
),

        bottomNavigationBar: Padding(
          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(

            children: [
              Icon(Icons.face , size: 40,),
              Expanded(child: TextField(
               controller: messageController,
maxLines:null,
              )) ,
IconButton(onPressed: ()async{

await ctrl.send(messageController.text);
messageController.text ="";
controller.jumpTo(controller.position.maxScrollExtent);
}, icon: Icon(Icons.send , size: 40,))
            ],
          ),
        ),
      );
      })
    );
  }
}