import "package:flutter/material.dart";
import "package:booking/api/api.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<dynamic> bookings = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   fetchData();
 }

 Future<void> fetchData() async {
   try {
     var value = await ApiService().get("/rooms");

     setState(() {
       bookings = value;
     });
   } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text("Error while fetching data: $e"),
         duration: const Duration(seconds: 3),
       ),
     );
   }
 }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text("Mes réservations")),
     body: RefreshIndicator(
       onRefresh: fetchData,
       child: bookings.isEmpty
           ? const Center(child: CircularProgressIndicator())
           : ListView.builder(
         itemCount: bookings.length,
         itemBuilder: (context, index) {
           final booking = bookings[index];
           return Card(
             margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
             child: ListTile(
               title: Text("Réservation #${booking['id']}"),
               subtitle: Text("Salle: ${booking['name']}"),
               trailing: Text("${booking['date']}"),
             ),
           );
         },
       ),
     ),
   );
  }
}
