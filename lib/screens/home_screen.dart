import 'package:flutter/material.dart';
import '../services/thingsboard_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool alarmaActiva = false;

  List<String> eventosRecientes = List.generate(
    5,
        (index) => "Alarma activada a las 14:27 del 20-05-2025",
  );

  void toggleAlarma(bool value) {
    setState(() {
      alarmaActiva = value;
      // Aquí puedes llamar a la API de ThingsBoard
    });
  }

  int _selectedIndex = 0;

  void onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Aquí podrías cambiar de vista en el futuro
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 30),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF3797EF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      const Text("Alarma", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Switch(
                        value: alarmaActiva,
                        activeColor: Colors.blueAccent,
                        onChanged: toggleAlarma,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Eventos Recientes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: eventosRecientes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.warning_amber_rounded, color: Colors.black),
                  title: Text(eventosRecientes[index]),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Hogar'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Estadísticas'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuraciones'),
        ],
      ),
    );
  }
}
