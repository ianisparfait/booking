import "package:booking/screens/settings/room_screen.dart";
import "package:flutter/material.dart";
import "package:booking/widgets/screen_container.dart";

import "../../api/api.dart";

class AdminRoomsScreen extends StatefulWidget {
  const AdminRoomsScreen({super.key});

  @override
  State<AdminRoomsScreen> createState() => _AdminRoomsScreenState();
}

class _AdminRoomsScreenState extends State<AdminRoomsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _rooms = [];

  // Dummy room data for display
  void _fetchRooms() async {
    setState(() {
      _isLoading = true;
    });
    // Here we simulate fetching the list of rooms.
    var rooms = await ApiService().get("/rooms"); // Implémenter la méthode `getRooms`
    setState(() {
      _rooms = rooms;
      _isLoading = false;
    });
  }

  // Open modal to add room
  void _openAddRoomModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ajouter une salle"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Nom"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le nom est requis";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _capacityController,
                  decoration: const InputDecoration(labelText: "Capacité"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "La capacité est requise";
                    }
                    if (int.tryParse(value) == null) {
                      return "Veuillez entrer un nombre valide";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _addRoom();
                }
              },
              child: const Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  // Handle adding room
  void _addRoom() async {
    setState(() {
      _isLoading = true;
    });
    final roomData = {
      "name": _nameController.text,
      "capacity": int.parse(_capacityController.text),
    };

    bool success = await ApiService().post("/rooms", roomData); // Implémenter la méthode `addRoom`
    setState(() {
      _isLoading = false;
    });

    if (success) {
      _fetchRooms(); // Refresh room list
      Navigator.of(context).pop(); // Close the modal
    } else {
      // Handle error, show a snackbar or alert
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l\'ajout de la salle")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRooms(); // Fetch the rooms when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: "Gestion des salles",
      child: Column(
        children: [
          // Button to open modal
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: _openAddRoomModal,
                child: const Text("Ajouter"),
              ),
            ),
          ),
          // List of rooms
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                final room = _rooms[index];
                return ListTile(
                  title: Text(room["name"]),
                  subtitle: Text("Capacité: ${room['capacity']}"),
                  onTap: () {
                    // Navigate to room details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminRoomScreen(roomId: room["name"]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
