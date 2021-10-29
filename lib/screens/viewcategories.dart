// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:e_pay/models/addcart.dart';
import 'package:e_pay/models/detailsarticles.dart';
import 'package:e_pay/models/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DifferentCategories extends StatefulWidget {
  const DifferentCategories({Key? key, required this.cat}) : super(key: key);

  final String cat;

  @override
  _DifferentCategoriesState createState() => _DifferentCategoriesState();
}

class _DifferentCategoriesState extends State<DifferentCategories> {
  Future<List<ArticlesDetailsData>> fetchArticlesDetails() async {
    var url = Uri.parse(
        "http://firewall-agency.com/odilon/boutiqueFlutter/affichageArticlesCategories.php?categories=${widget.cat}");

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

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    PreferencesArticles prefs = PreferencesArticles();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cat,
        ),
      ),
      body: SingleChildScrollView(
        // ignore: sized_box_for_whitespace
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<ArticlesDetailsData>>(
            future: fetchArticlesDetails(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // ignore: avoid_unnecessary_containers
              return Container(
                child: GridView.count(
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                  crossAxisCount: 2,
                  children: snapshot.data!
                      .map(
                        // ignore: avoid_unnecessary_containers
                        (data) => Container(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2.0),
                                    child: Image.network(
                                      "http://firewall-agency.com/odilon/phpboutique/uploads/${data.photo}",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.prix,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          ajouterAuPanier(data);
                                        },
                                        child: const Icon(
                                          Icons.add_shopping_cart_outlined,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void ajouterAuPanier(ArticlesDetailsData article) async {
    PreferencesArticle prefs = PreferencesArticle();
    // ignore: unused_local_variable
    final result = await prefs.ajouterAuPanier(article);
  }
}
