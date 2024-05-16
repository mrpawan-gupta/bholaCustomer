
import "package:flutter/material.dart";
import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:url_launcher/url_launcher.dart";



class SearchTab extends GetView<SearchController> {
  const SearchTab( {required this.text,required this.onPressed, super.key});
  final String text;

  final Function(double lat, double long, List<Placemark>  list) onPressed;




  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) =>
                   GoogleMapScreen(onPressed: (double v1,double v2, List<Placemark>v3) {
                     onPressed(v1,v2,v3);
                   },),),
                );
              },
              child: const Icon(
                Icons.search_rounded,
                color: Colors.black,
                size: 24,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: SizedBox(
                  width: 200,
                  child: GestureDetector(
                    onTap: () async {
                      await _openDropDown(context);
                    },
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Enter location",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(
                        fontFamily: "Inter",
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openDropDown(BuildContext context) async {
    String? _selectedLocation;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a location'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _selectedLocation = 'Location 1';
                    Navigator.pop(context);
                  },
                  child: const Text('Location 1'),
                ),
                GestureDetector(
                  onTap: () {
                    _selectedLocation = 'Location 2';
                    Navigator.pop(context);
                  },
                  child: const Text('Location 2'),
                ),
                GestureDetector(
                  onTap: () {
                    _selectedLocation = 'Location 3';
                    Navigator.pop(context);
                  },
                  child: const Text('Location 3'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}


class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({required this.onPressed, Key? key}) : super(key: key);
   final Function(double lat, double long, List<Placemark>  list) onPressed;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController _controller;
  late LatLng _currentPosition = LatLng(0, 0);

  Future<void> _fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      await openGoogleMaps(context);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<List<Placemark>> latLongToAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition.latitude,
        _currentPosition.longitude);
    return  Future<List<Placemark>>.value(placemarks);
  }

  Future<void> openGoogleMaps(BuildContext context) async {
    final String url =
        "https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude},${_currentPosition.longitude}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentPosition != null
                ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15,
              ),
              onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                });
              },
              markers: {
                Marker(
                  markerId: MarkerId('current_location'),
                  position: _currentPosition,
                  infoWindow: InfoWindow(title: 'Current Location'),
                ),
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async{
                List<Placemark> temp = await latLongToAddress();
                print("apiData--${temp.first.toJson()}");
                widget.onPressed(_currentPosition.latitude, _currentPosition.longitude,temp);
              },
              child: const Text('Confirm Location & Proceed'),
            ),
          ),
        ],
      ),
    );
  }

}



