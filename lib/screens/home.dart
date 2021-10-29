import 'package:e_pay/components/categories.dart';
import 'package:e_pay/components/drawer.dart';
import 'package:e_pay/models/preferences.dart';
import 'package:e_pay/models/recommandationimage.dart';
import 'package:e_pay/screens/articlesdetails.dart';
import 'package:e_pay/services/api.dart';
import 'package:e_pay/widgets/slider_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    PreferencesArticles prefs = PreferencesArticles();
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerPage(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SliderImagePublicite(),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
            ),
            const CategoriesPage(),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Recommandations',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List<RecommandationArticle>>(
                initialData: const [],
                future: fetchArticlesData(),
                builder: (context,
                    AsyncSnapshot<List<RecommandationArticle>> snapshot) {
                  if (ConnectionState.waiting == snapshot.connectionState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!
                        .map(
                          // ignore: avoid_unnecessary_containers
                          (data) => Container(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ArticlesDetails(
                                              id: data.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                        child: Image.network(
                                          "http://firewall-agency.com/odilon/phpboutique/uploads/${data.photo}",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.categories,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 17),
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 45,
                                        ),
                                        Card(
                                          color: Colors.white70,
                                          child: InkWell(
                                            onTap: () {
                                              ajouterAuPanier(data);
                                            },
                                            child: const Icon(
                                              Icons.add_shopping_cart_outlined,
                                              size: 36,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void ajouterAuPanier(RecommandationArticle article) async {
    PreferencesArticles prefs = PreferencesArticles();
    // ignore: unused_local_variable
    final result = await prefs.ajouterAuPanier(article);
  }
}
