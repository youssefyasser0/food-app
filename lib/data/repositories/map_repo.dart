import 'dart:async';
import 'package:geolocator/geolocator.dart';

class MapRepo {


  Future<Position?> getUserLocation() async{

    bool serviceEnabled;
    LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('this app must enable location');
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('this app must enable location');
        }


      }


      if(permission == LocationPermission.whileInUse){

        Position userLocation = await Geolocator.getCurrentPosition();

        return userLocation;

      }


      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }

      else{
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
          return null;
      }






  }


  Stream<ServiceStatus> getServiceStatus() {
    return Geolocator.getServiceStatusStream();
  }



}