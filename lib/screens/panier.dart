import 'dart:convert';

import 'package:e_pay/models/preferences.dart';
import 'package:e_pay/models/recommandationimage.dart';
import 'package:e_pay/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({Key? key}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  String email = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
    _getCurrentLocation();
  }

  String articleCommander = "";

  Future commander() async {
    var url = Uri.parse(
        "http://firewall-agency.com/odilon/boutiqueFlutter/validerCommande.php");
    var reponse = await http.post(url, body: {
      "article": articleCommander,
      "email": email,
      "position": _currentPosition,
    });
    var data = json.decode(reponse.body);
    // ignore: avoid_print
    print(json.decode(reponse.body));
    if (data == 200) {
      Fluttertoast.showToast(
        msg: 'Pas commander',
        backgroundColor: Colors.red,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      //  ignore: avoid_print
      print('commander');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashPage(),
        ),
      );
    }
  }

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  late Position _currentPosition;
  // ignore: unused_field
  late String _currentAddress;

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(_currentPosition);
    // ignore: unused_local_variable
    PreferencesArticles prefs = PreferencesArticles();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Panier'),
        ),
        automaticallyImplyLeading: false,
      ),
      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            FutureBuilder<List<RecommandationArticle>>(
              future: PreferencesArticles().recupererPanier(),
              builder: (context, snapshot) {
                if (ConnectionState.waiting == snapshot.connectionState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!
                        .map(
                          // ignore: avoid_unnecessary_containers
                          (article) => Container(
                            child: Card(
                              elevation: 2,
                              margin: const EdgeInsets.all(2),
                              child: Padding(
                                padding: const EdgeInsets.all(17),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            "http://firewall-agency.com/odilon/phpboutique/uploads/${article.photo}",
                                          ),
                                        ),
                                        Text(
                                          articleCommander =
                                              article.designation,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        // Text(
                                        //   article.prix,
                                        //   style: const TextStyle(
                                        //     fontSize: 18,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              supprimerArticle(article);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    shrinkWrap: true,
                  );
                }

                return Container();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         'Location',
            //         style: Theme.of(context).textTheme.caption,
            //       ),
            //       if (_currentPosition != null && _currentAddress != null)
            //         Text(_currentAddress,
            //             style: Theme.of(context).textTheme.bodyText2),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 70),
              child: ButtonTheme(
                buttonColor: HexColor("#00BCD4"),
                minWidth: MediaQuery.of(context).size.width,
                height: 55,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    commander();
                  },
                  child: const Text(
                    'COMMANDER',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void supprimerArticle(RecommandationArticle article) async {
    PreferencesArticles prefs = PreferencesArticles();
    // ignore: unused_local_variable
    final resultat = await prefs.supprimerArticle(article);
  }
}
