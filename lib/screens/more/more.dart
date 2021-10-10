import 'package:flutter/material.dart';
import 'package:recipia/screens/random_recipe/widgets/expandable.dart';
import 'package:url_launcher/url_launcher.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Spoonacular",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: ListView(
          children: [
            ExpandableGroup(
              isExpanded: false,
              collapsedIcon: const Icon(Icons.arrow_drop_down),
              header: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Terms of Use",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              items: const [
                ListTile(
                  title: Text("Acceptance of Terms"),
                  subtitle: Text(
                      "By subscribing to any of the spoonacular API plans offered on our website or on rapidapi.com (previously mashape.com) or to a custom plan to which you are invited, you the API subscriber (“you”) confirm that you have read and agree to the Terms of Use outlined below. Failure to honor these terms will result in your use of the spoonacular API being suspended and/or permanently blocked."),
                ),
                ListTile(
                    title: Text("License"),
                    subtitle: Text(
                        "A spoonacular API subscription grants you a nonexclusive, non-transferable license to use the spoonacular API on a month-by-month basis dependent on your payment of the monthly fee associated with your subscription (and any additional charges due to exceeding the number of calls per day covered by your subscription) and on your agreement to respect these terms. You will be charged every month until you cancel your subscription under My Console > Plan/Billing or on RapidAPI's website, depending on where you subscribed.")),
              ],
            ),
            ExpandableGroup(
              isExpanded: false,
              collapsedIcon: Icon(Icons.arrow_drop_down),
              header: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Features",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              items: const [
                ListTile(
                  title: Text(
                    'App includes 5,000+ recipes.',
                  ),
                ),
                ListTile(
                  title: Text(
                    'cost breakdown per servings.',
                  ),
                ),
                ListTile(
                  title: Text(
                    'related recipes.',
                  ),
                ),
                ListTile(
                  title: Text(
                    'Autocomplete search fetaure.',
                  ),
                ),
                ListTile(
                  title: Text(
                    'Save recipes for letter.',
                  ),
                ),
                ListTile(
                  title: Text(
                    'Get Random recipes.',
                  ),
                ),
                ListTile(
                  title: Text(
                    'Everyday\'s meal plan with nutritions.',
                  ),
                ),
              ],
            ),
            ExpandableGroup(
              isExpanded: false,
              collapsedIcon: Icon(Icons.arrow_drop_down),
              header: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "App Information",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              items: [
                const ListTile(
                  title: Text(
                    'App Created with Flutter bloc library.',
                  ),
                ),
                ListTile(
                  onTap: () {
                    launch("https://spoonacular.com/food-api");
                  },
                  title: const Text('with open source spoonacular api',
                      style: TextStyle(color: Colors.blue)),
                ),
                ListTile(
                  onTap: () {
                    launch("https://github.com/Ansh-rathod");
                  },
                  title: const Text('Socure code of application',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
