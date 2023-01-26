import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Providers/bookingProviders.dart';


class RoutingMap extends StatefulWidget {
  const RoutingMap({Key? key}) : super(key: key);

  @override
  State<RoutingMap> createState() => _RoutingMapState();
}

class _RoutingMapState extends State<RoutingMap> {

  // created controller to display Google Maps
  final Completer<GoogleMapController> _controller = Completer();
  //on below line we have set the camera position


  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  // list of locations to display polylines


  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    List<LatLng> latLen = [
       LatLng(booking.sourceLatitude, booking.sourceLogitude),
       LatLng(booking.destinationLatitude, booking.destinationLogitude),
    ];
    // declared for loop for various locations
    for(int i=0; i<latLen.length; i++){
      _markers.add(
        // added markers
          Marker(
            markerId: MarkerId(i.toString()),
            position: latLen[i],
            infoWindow: const InfoWindow(
              title: 'HOTEL',
              snippet: '5 Star Hotel',
            ),
            icon: BitmapDescriptor.defaultMarker,
          )
      );
      setState(() {

      });
      _polyline.add(
          Polyline(
            polylineId: const PolylineId('1'),
            points: latLen,
            color: kGreen,
            zIndex: 1,
            width: 8
          )
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    BookingModel booking = Provider.of<BookingProvider>(context).user;
      CameraPosition _kGoogle = CameraPosition(
      target: LatLng(booking.sourceLatitude, booking.sourceLogitude),
      zoom: 14,
    );
    return   Container(
      color: kOrangeColor,
      height: MediaQuery.of(context).size.height * 0.34,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            //given camera position
            initialCameraPosition: _kGoogle,
            // on below line we have given map type
            mapType: MapType.normal,
            // specified set of markers below
            markers: _markers,
            // on below line we have enabled location
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // on below line we have enabled compass location
            compassEnabled: true,
            // on below line we have added polylines
            polylines: _polyline,
            // displayed google map
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),

          Positioned(
              top: 180.h,
              left: 0,
              right: 0,
              //bottom: 0,
              child:Container(
                margin: EdgeInsets.symmetric(horizontal: 40),

                child: Card(child:Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Time: ",
                            style: Theme.of(context).textTheme.bodyText2,
                            children: <TextSpan>[
                              TextSpan(
                                text: booking.timeTaken.toString(),
                                style: Theme.of(context).textTheme.caption!.copyWith(color: kGreen),
                              ),


                            ]

                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Distance: ",
                            style: Theme.of(context).textTheme.bodyText2,
                            children: <TextSpan>[
                              TextSpan(
                                text: booking.distance.toString(),
                                style: Theme.of(context).textTheme.caption!.copyWith(color: kGreen),
                              ),


                            ]

                        ),
                      ),
                    ],
                  ),
                ),),
              )),
        ],
      ),
    );
  }



}
