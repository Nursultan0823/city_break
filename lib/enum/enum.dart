 enum Url{
    getTrip( "http://192.168.0.102:8081/trip/get"),
    addTrip( "http://localhost:8081/trip/add"),
  getCity( "http://192.168.0.102:8081/city/get"),
  addCity( "http://192.168.0.102:8081/city/add");
    final String description;
    const Url(this.description);
 }