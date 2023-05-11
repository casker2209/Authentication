
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionUtils{
  static Future<bool> requestContact() async{
    if (await Permission.contacts.isGranted){
      return true;
    }
    else if(await Permission.contacts.isPermanentlyDenied){
      openAppSettings();
    }
    else{
      return await Permission.contacts.request() == PermissionStatus.granted;
    }
    return false;
  }
}