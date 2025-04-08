import "package:flutter/material.dart";
import "package:booking/widgets/screen_container.dart";

class AdminRoomScreen extends StatelessWidget {
  const AdminRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenContainer(
      title: "Admin room",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gestion des rooms")
          ],
        ),
      ),
    );
  }
}
