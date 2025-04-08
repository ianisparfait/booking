import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:booking/widgets/screen_container.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: "Profile",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push("/change-password"); // your named path
              },
              child: const Text("Go to change password"),
            ),
            ElevatedButton(
              onPressed: () {
                context.go("/login"); // your named path
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
