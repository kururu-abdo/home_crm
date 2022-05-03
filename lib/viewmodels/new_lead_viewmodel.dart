import 'package:home_crm/data/database/db.dart';
import 'package:home_crm/data/models/lead.dart';
import 'package:home_crm/data/models/toast_type.dart';
import 'package:home_crm/data/models/view_status.dart';
import 'package:home_crm/utils/helpers.dart';
import 'package:stacked/stacked.dart';

class NewLeadViewModel extends BaseViewModel {
  
  ViewState? _viewState =ViewState.IDLE;
  ViewState get viewState =>  _viewState!;


  updateState(ViewState state){
    _viewState =state;
    notifyListeners();
  }

  addLead(Lead lead)async{
    updateState(ViewState.BUSY);
    try {
       await Future.delayed(Duration(seconds: 5) );
await SQLHelper.createLead(lead);
showToast(ToastType.SUCCESS, 'Lead Added Successfully');
updateState(ViewState.IDLE);
    } catch (e) {
      updateState(ViewState.EROR);
      showToast(ToastType.ERROR, 'Operation Failed');

    }
  }


  
}