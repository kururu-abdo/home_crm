import 'dart:developer';

import 'package:home_crm/data/database/db.dart';
import 'package:home_crm/data/models/lead.dart';
import 'package:home_crm/data/models/view_status.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
Lead? lead;
bool showFirst = true;




  


List<Lead>  leads =[];
  ViewState? _state;
  ViewState get state => _state!;

  updateState(ViewState state){
    _state = state;
    notifyListeners();
  }
setLead(Lead? l){
    lead = l;

    notifyListeners();
    log((lead==null).toString());
  }

  toggleShow(bool value) {
    showFirst = value;
    notifyListeners();

  }
  fetchLeads()async {
     updateState(ViewState.BUSY);
     await Future.delayed(Duration(seconds: 3));
try {
 var data =await SQLHelper.geatLeads();

 leads =data;
 notifyListeners();
 if (leads.isNotEmpty) {
   setLead(leads[0]);
 }
      updateState(ViewState.IDLE);

} catch (e) {
  updateState(ViewState.EROR);
  log(e.toString());
}
  }

}