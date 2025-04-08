import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:booking/widgets/screen_container.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: "Settings",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push("/settings/rooms");
              },
              child: const Text("Accéder aux salles"),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/settings/tables");
              },
              child: const Text("Accéder aux tables"),
            ),
          ],
        ),
      ),
    );
  }
}
