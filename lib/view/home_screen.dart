import 'package:clear_view_model/res/components/round_button.dart';
import 'package:clear_view_model/utils/routes/routes.dart';
import 'package:clear_view_model/view_model/home_view_model.dart';
import 'package:clear_view_model/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../res/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.fetchShoppingList();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Store'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              userPreferences.removeUser().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: Center(
              child: Text('Logout'),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, child) {
          switch (value.shoppingList.status) {
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text(value.shoppingList.message.toString());
            case Status.COMPLETED:
              return ListView.builder(
                itemCount: value.shoppingList.data!.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Card(
                        child: Image(
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                      image: NetworkImage(value
                          .shoppingList.data!.data![index].pantoneValue
                          .toString()),
                    )),
                  );
                },
              );
          }
          return Container();
        }),
      ),
    );
  }
}
