class Lead {
   int? id;
   String? name;
   String? email;
     String? phone;
   double? lat;
   double?  lon;
String? createdAt ;

   Lead({
     this.id,
   this.name,
       this.email,

   this.phone,
   this.lat,
    this.lon,
this.createdAt
    
  });


Lead.fromMap(Map<String,dynamic> data){


  id =data['id'];

  name =data['name'];
  email =data['email'];
  phone =data['phone'];
 lat =data['lat'];
  lon =data['lon'];
  createdAt =data['createdAt'];

}
Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
            'email': email,
            'lat': lat,
            'lon': lon,

    };
  }
  


}