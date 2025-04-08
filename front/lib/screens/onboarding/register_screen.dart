import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:booking/widgets/screen_container.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: "Register Screen",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go("/home");
              },
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
