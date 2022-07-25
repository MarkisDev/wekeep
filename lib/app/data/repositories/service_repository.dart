import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:wekeep/app/data/models/serviceProvider_model.dart';
import 'package:wekeep/app/data/models/user_models.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';

class ServiceRepository {
  getShops(GeoFirePoint center) {
    var stream = FirestoreDb.getShops(center);
    var geo = Geoflutterfire();
    return stream.map((List<DocumentSnapshot> dL) {
      var x = [];
      dL.forEach((DocumentSnapshot document) {
        var loc = document['location']['geopoint'];
        // GeoFirePoint pos =
        //     geo.point(latitude: loc.latitude, longitude: loc.longitude);
        double k = center.kmDistance(lat: loc.latitude, lng: loc.longitude);
        ServiceProvider prov = ServiceProvider(
            coords: loc,
            name: document['shopName'],
            howFar: k,
            imgUrl:
                'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
        x.add(prov);
      });
      return x;
    });
    // stream.listen((List<DocumentSnapshot> documentList) {
    //   print("ok ${documentList}");
    //   documentList.forEach((DocumentSnapshot document) {
    //     var loc = document['location']['geopoint'];
    //     GeoFirePoint pos =
    //         geo.point(latitude: loc.latitude, longitude: loc.longitude);
    //     double k = pos.kmDistance(lat: center.latitude, lng: center.longitude);
    //     ServiceProvider prov = ServiceProvider(
    //         name: document['shopName'],
    //         howFar: k,
    //         imgUrl:
    //             'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
    //     shops.add(prov);
    //     print(shops);
    //   });
    // });
  }
}
