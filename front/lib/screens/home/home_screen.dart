import "package:booking/model/booking.dart";
import "package:flutter/material.dart";
import "package:booking/api/api.dart";
import "package:booking/model/response.dart";
import "package:booking/widgets/screen_container.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<dynamic> response = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    Future res = ApiService().get("/rooms");

    res.then((value) {
      setState(() {
        response = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        title: "Home",
        child: Column(
          children: <Widget>[
            Text("Response: $response"),
          ],
        ));
  }
}
