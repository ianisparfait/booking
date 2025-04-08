import "package:flutter/material.dart";
import "package:booking/api/api.dart";
import "package:booking/model/response.dart";
import "package:booking/widgets/components/button.dart";
import "package:booking/widgets/screen_container.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String response = "";

  void fetchData() {
    var res = ApiService(baseUrl: "http://192.168.1.65:8081/v0").get("/bookings");

    res.then((Response value) {
      setState(() {
        if (value.resultError == null) {
          response = value.resultData.toString();
        } else {
          response = value.resultError!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        title: "Home",
        child: Column(
          children: <Widget>[
            AppButton(
              label: "Fetch Data",
              onPressed: fetchData,
            ),
            Text("Response: $response"),
          ],
        ));
  }
}
