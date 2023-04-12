import 'package:flutter/material.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  State<HomeScreenState> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenState> {
  @override
  Widget build(BuildContext context) {
    int num = 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        backgroundColor: Colors.teal,
      ),
      body: PageView(
        children: const [
          CustomScreen(color: Color.fromARGB(255, 186, 230, 187)),
          ],
      ),
      drawer:  Drawer(
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text("Alessia Medina", 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                            ), 
              accountEmail: Text("alessia88@hotmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("data:image/jpeg;base64,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"),
              ),
              decoration: BoxDecoration(color: Colors.teal),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Perfil"),
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text("Cambiar contraseña"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Cerrar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomScreen extends StatelessWidget {
  final Color color;

  const CustomScreen({super.key, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      color: color,
      // child: const Center(
      //   child: Text('hola compadre'),
      // ),
      child: GridView.count(
        crossAxisCount: 2,
        children: const [
          MyMenu(
            title: "Visión", 
            icon: Icons.accessibility_new_rounded,
          ),
          MyMenu(
            title: "Misión", 
            icon: Icons.adjust,
          ),
        ],
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  const MyMenu({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, 
                size: 70.0
              ),
              Text(
                title, 
                style: const TextStyle(fontSize: 17.0),
                )
            ],
          ),
        ),
      ),
    );
  }
}
