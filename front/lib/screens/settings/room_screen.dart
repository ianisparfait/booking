import "package:flutter/material.dart";
import "package:booking/widgets/screen_container.dart";

class AdminRoomScreen extends StatefulWidget {
  const AdminRoomScreen({
    super.key,
    required this.roomId
  });

  final String roomId;

  @override
  State<AdminRoomScreen> createState() => _AdminRoomDetailScreen();
}

class _AdminRoomDetailScreen extends State<AdminRoomScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: "Salle ${widget.roomId}",
      child: Container(),
    );
  }
}
