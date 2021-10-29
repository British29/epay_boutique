import 'package:e_pay/models/detailsarticles.dart';
import 'package:e_pay/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesArticle {
  Future<bool> ajouterAuPanier(ArticlesDetailsData article) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get("panier") == null) {
      prefs.setStringList("panier", [article.id]);
      return true;
    } else {
      final panier = prefs.getStringList("panier") as List<String>;
      panier.add(article.id);
      prefs.setStringList('panier', panier);
      return true;
    }
  }

  Future<bool> supprimerArticle(ArticlesDetailsData article) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("panier") == null) {
      return false;
    } else {
      var panier = prefs.getStringList("panier") as List<String>;
      panier.remove(article.id);
      prefs.setStringList('panier', panier);
      return true;
    }
  }

  Future<List<ArticlesDetailsData>> recupererPanier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('panier') == null) {
      return [];
    } else {
      List<ArticlesDetailsData> listeArticles = (await fetchArticlesData()).cast<ArticlesDetailsData>();
      // fetchArticlesDetails
      // ignore: avoid_print
      print(listeArticles);
      final list = prefs.getStringList('panier');
      List<ArticlesDetailsData> finalList = <ArticlesDetailsData>[];

      for (int i = 0; i < list!.length; i++) {
        // ignore: avoid_print
        print(list[i]);
        for (int y = 0; y < listeArticles.length; y++) {
          if (list[i] == listeArticles[y].id) {
            finalList.add(listeArticles[y]);
            // ignore: avoid_print
            print(finalList.toString());
          }
        }
      }

      return finalList;
    }
  }
}
