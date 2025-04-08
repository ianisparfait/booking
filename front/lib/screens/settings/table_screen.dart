import "package:flutter/material.dart";
import "package:booking/widgets/screen_container.dart";

class AdminTableScreen extends StatelessWidget {
  const AdminTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenContainer(
      title: "Admin table",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gestion des tables / room")
          ],
        ),
      ),
    );
  }
}
