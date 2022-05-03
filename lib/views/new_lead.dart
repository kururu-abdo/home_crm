import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_crm/data/database/db.dart';
import 'package:home_crm/data/models/lead.dart';
import 'package:home_crm/data/models/view_status.dart';
import 'package:home_crm/utils/validations.dart';
import 'package:home_crm/viewmodels/new_lead_viewmodel.dart';
import 'package:home_crm/views/location_pickup.dart';
import 'package:stacked/stacked.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class AddNewLead extends StatefulWidget {
  const AddNewLead({ Key? key }) : super(key: key);

  @override
  _AddNewLeadState createState() => _AddNewLeadState();
}

class _AddNewLeadState extends State<AddNewLead> {


    var formKey =  GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
LatLng? latLng;

String? _phone;


  @override
  Widget build(BuildContext context) {
    return   ViewModelBuilder<NewLeadViewModel>.reactive(viewModelBuilder: ()=>NewLeadViewModel(), builder: (context ,model , child){
return 
Scaffold(
resizeToAvoidBottomInset: false,
  appBar: AppBar(
    
    leading: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios , color:Colors.green)),
    title: Text('New Lead'  , style: TextStyle(color: Colors.green),),
    elevation: 0.0 
    
     , backgroundColor: Colors.transparent,
  
  ),

  body: Form(
    key: formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

   Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                  validator: (str)=>isNotEnotyValidation(str!),
                  onChanged: (text) {
                    setState(() {
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                )),
Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email ',
                  ),
                  validator: (str)=>emailValidation(str!),
                  onChanged: (text) {
                    setState(() {
                    
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                )),
Container(
                margin: EdgeInsets.all(10),
                child:
                IntlPhoneField(
                  controller: phoneController,
    decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
            borderSide: BorderSide(),
        ),
    ),
    initialCountryCode: 'IN',
    validator: (str)=>isNotEnotyValidation(str!.completeNumber),
    onChanged: (phone) {
        print(phone.completeNumber);

        _phone = phone.completeNumber;
    },
)
                //  TextField(
                //   controller: nameController,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'phone',
                //   ),
                //   onChanged: (text) {
                //     setState(() {
                     
                //       //you can access nameController in its scope to get
                //       // the value of text entered as shown below
                //       //fullName = nameController.text;
                //     });
                //   },
                // )
                
                
                ),


                Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  readOnly: true,
                  controller: addressController,
                  onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => LocationPickup(
                    onSelected: (data){
                     setState(() {
                        print(data);
                      latLng = LatLng(data['lat'] ,data['lon']   );
                      addressController.text = data['name'];
                     });
                    },
                  ))));
                  },
                  // controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                    labelText: 'Address ',
                  ),
                  validator: (str)=>isNotEnotyValidation(str!),
                  onChanged: (text) {
                    setState(() {
                    
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                )),

              Spacer()   ,

InkWell(
  onTap: ()async{
    if(formKey.currentState!.validate()){
     

  var lead =Lead(
    
    name: nameController.text,
    email: emailController.text , phone: _phone ,lat:  latLng!.latitude , lon: latLng!.longitude);
//     name: nameController.text ,
// lat:  latLng!.latitude , lon: latLng!.longitude
//     );
await  model.addLead(lead);
    
     Navigator.pop(context);
    }

  },
  child: 
   model.viewState ==ViewState.BUSY?
   Center(child: CircularProgressIndicator(),):
  
    AnimatedContainer(
      duration: Duration(milliseconds: 800),
    width: 300,height: 60,
   margin: EdgeInsets.only(bottom: 10),
    decoration:BoxDecoration(
      color: Colors.green
      ,
  
      borderRadius: BorderRadius.circular(25)
    ),
    child: Center(child: Text("Add" ,style: TextStyle(color: Colors.white),),),
  ),
)

    ],)),




);
    });
  }
}