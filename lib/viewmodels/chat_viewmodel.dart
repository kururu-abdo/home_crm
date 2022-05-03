import 'package:home_crm/data/models/message.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  List<Message> messages =[];

     bool isTyping = false;

init(){
  messages.add(Message(id: 1,fromMe: true,message: 'Hi'));
  notifyListeners();
}

     updateIsTyping(bool val){
       isTyping =val;
       notifyListeners();
     }

     send(String message)async{
       messages.add(Message(fromMe: true ,message: message  ,id: 1) ,);
       notifyListeners();
   updateIsTyping(true);
   await Future.delayed(Duration(seconds: 3));
 updateIsTyping(false);

        messages.add(Message(fromMe: false ,message: 'Message received'  ,id: 1) ,);



     }



}