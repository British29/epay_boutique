import 'dart:convert';

import 'package:e_pay/models/addcart.dart';
import 'package:e_pay/models/detailsarticles.dart';
import 'package:e_pay/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArticlesDetails extends StatefulWidget {
  const ArticlesDetails({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _ArticlesDetailsState createState() => _ArticlesDetailsState();
}

class _ArticlesDetailsState extends State<ArticlesDetails> {
  Future<List<ArticlesDetailsData>> fetchArticlesDetails() async {
    var url = Uri.parse(
        "http://firewall-agency.com/odilon/boutiqueFlutter/affichageArticlesdetails.php?id=${widget.id}");

    var reponse = await http.get(url);

    if (reponse.statusCode == 200) {
      final items = json.decode(reponse.body).cast<Map<String, dynamic>>();

      List<ArticlesDetailsData> articleDetailsListe =
          items.map<ArticlesDetailsData>((json) {
        return ArticlesDetailsData.fromJson(json);
      }).toList();

      return articleDetailsListe;
    } else {
      throw Exception('Échec du chargement des données depuis le serveur');
    }
  }

  String articleCommander = "";
  String email = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
    });
  }

  Future commander() async {
    var url = Uri.parse(
        "http://firewall-agency.com/odilon/boutiqueFlutter/validerCommande.php");
    var reponse = await http.post(url, body: {
      "article": articleCommander,
      "email": email,
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

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    PreferencesArticle prefs = PreferencesArticle();

    // ignore: avoid_print
    print(widget.id);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.lightBlueAccent;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(),
      // ignore: avoid_unnecessary_containers
      body: SingleChildScrollView(
        child: FutureBuilder<List<ArticlesDetailsData>>(
          future: fetchArticlesDetails(),
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: snapshot.data!
                  .map(
                    (data) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: ListTile(
                              title: Image.network(
                                "http://firewall-agency.com/odilon/phpboutique/uploads/${data.photo}",
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                fit: BoxFit.cover,
                              ),
                              subtitle: Center(
                                child: Text(
                                  articleCommander = data.designation,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 60),
                          child: Row(
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          getColor),
                                ),
                                onPressed: () {
                                  commander();
                                },
                                child: const Text(
                                  'COMMANDER',
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.black),
                                ),
                              ),
                              const Spacer(),
                              Card(
                                color: Colors.blue,
                                // ignore: avoid_unnecessary_containers
                                child: Container(
                                  child: IconButton(
                                      onPressed: () {
                                        ajouterAuPanier(data);
                                      },
                                      icon: const Icon(
                                        Icons.add_shopping_cart_outlined,
                                      ),
                                      iconSize: 30.0,
                                      color: Colors.black,
                                      splashRadius: 100,
                                      splashColor: Colors.lightGreenAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  //La connexion n'est pas bonne

  void ajouterAuPanier(ArticlesDetailsData article) async {
    PreferencesArticle prefs = PreferencesArticle();
    // ignore: unused_local_variable
    final result = await prefs.ajouterAuPanier(article);
  }
}
