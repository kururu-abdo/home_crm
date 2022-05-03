import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:home_crm/utils/app_constants.dart';

class LocationPickup extends StatefulWidget{
   Function(Map)? onSelected;
   LocationPickup({this.onSelected});
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<LocationPickup> {
   String googleApikey = AppConstants.MapKey;
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027); 
  String location = "Search Location"; 
   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
   String title ='';
updateMarker(LatLng loc ){
 
 // final marker = markers.values.toList().firstWhere((item) => item.markerId == "id");

  Marker _marker = Marker(
   markerId: MarkerId("id"),
   onTap: () {
     print("tapped");
   },
   position: LatLng(loc.latitude, loc.longitude),
  //  icon: marker.icon,
   infoWindow: InfoWindow(title: title),
  );

 setState(() {
  //the marker is identified by the markerId and not with the index of the list
   markers[MarkerId("id")] = _marker;
 });
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Select Lead Location "),
             backgroundColor: Colors.green,
             leading:IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
             actions: [
               TextButton(onPressed: (){

                 Navigator.of(context).pop();
               }, child: Text('Confirm' ,style: TextStyle(color: Colors.white),))
             ],
          ),
          body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: startLocation, //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onTap: (latlng)async{
                    List<Placemark> placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);

                   
setState(() {
  updateMarker(latlng);
});
widget.onSelected!({
  "lat":latlng.latitude ,
  "lon":latlng.longitude ,
  "name":placemarks.first.country!+ ","+placemarks.first.name!+","+placemarks.first.street!
});

setState(() {
  title = placemarks.first.country!+ ","+placemarks.first.name!+","+placemarks.first.street!;
});

                  },
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      mapController = controller; 
                    });
                  },
                  markers: Set<Marker>.of(markers.values),
             ),

           

            //  //search autoconplete input
            //  Positioned(  //search input bar
            //    top:10,
            //    child: InkWell(
            //      onTap: () async {
            //       var place = await PlacesAutocomplete.show(
            //               context: context,
            //               apiKey:
                          
            //               // "AIzaSyBvY8Ddcbs7AahaYu73x_VSXblgGpy8W2s",
                          
                          
            //               googleApikey,
            //               mode: Mode.overlay,
            //               types: [],
            //               strictbounds: false,
            //               components: [Component(Component.country, 'np')],
            //                           //google_map_webservice package
            //               onError: (err){

            //                  print(err.errorMessage);
            //                  print(err);
            //               }
            //           );

            //        if(place != null){
            //             setState(() {
            //               location = place.description.toString();
            //             });

            //            //form google_maps_webservice package
            //            final plist = GoogleMapsPlaces(apiKey:googleApikey,
            //                   apiHeaders: await GoogleApiHeaders().getHeaders(),
            //                             //from google_api_headers package
            //             );
            //             String placeid = place.placeId ?? "0";
            //             final detail = await plist.getDetailsByPlaceId(placeid);
            //             final geometry = detail.result.geometry!;
            //             final lat = geometry.location.lat;
            //             final lang = geometry.location.lng;
            //             var newlatlang = LatLng(lat, lang);
                        

            //             //move map camera to selected place with animation
            //             mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
            //        }
            //      },
            //      child:Padding(
            //        padding: EdgeInsets.all(15),
            //         child: Card(
            //            child: Container(
            //              padding: EdgeInsets.all(0),
            //              width: MediaQuery.of(context).size.width - 40,
            //              child: ListTile(
            //                 title:Text(location, style: TextStyle(fontSize: 18),),
            //                 trailing: Icon(Icons.search),
            //                 dense: true,
            //              )
            //            ),
            //         ),
            //      )
            //    )
            //  )


            ]
          )
       );
  }
}