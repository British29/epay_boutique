import 'package:e_pay/models/recommandationimage.dart';
import 'package:e_pay/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesArticles {
  Future<bool> ajouterAuPanier(RecommandationArticle article) async {
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

  Future<bool> supprimerArticle(RecommandationArticle article) async {
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

  Future<List<RecommandationArticle>> recupererPanier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('panier') == null) {
      return [];
    } else {
      List<RecommandationArticle> listeArticles =
          await fetchArticlesData();
      // print(listeArticles);
      final list = prefs.getStringList('panier');
      List<RecommandationArticle> finalList = <RecommandationArticle>[];

      for (int i = 0; i < list!.length; i++) {
        // print(list[i]);
        for (int y = 0; y < listeArticles.length; y++) {
          if (list[i] == listeArticles[y].id) {
            finalList.add(listeArticles[y]);
            // print(finalList.toString());
          }
        }
      }

      return finalList;
    }
  }
}
