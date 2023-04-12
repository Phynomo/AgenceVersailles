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
                backgroundImage: AssetImage("assets/images/user.png"),
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
    WidgetBuilder builder = build;
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: title == "Visión"
          ? () => showSimpleDialogVision(context, builder)
          : () => showSimpleDialogMision(context, builder),
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

void showSimpleDialogVision(BuildContext context, WidgetBuilder builder) => showDialog(
  context: context,
  builder: (BuildContext context) => SimpleDialog(
    title: const Center(
      child: Text(
        "Visión",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    ),
    contentPadding: const EdgeInsets.all(16.0),
    children: [
      Container(
        width: 400.0,
        height: 380.0,
        child: const Center(
          child: Text(
            "Nuestra visión es convertirnos en el referente del mercado en cuanto a calidad y satisfacción del cliente. Queremos ser reconocidos por nuestra excelencia en la atención y por ofrecer experiencias de viaje únicas y memorables. Buscamos ser líderes en el sector turístico, ofreciendo siempre un servicio personalizado y adaptado a las necesidades y preferencias de nuestros clientes.",
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ],
  ),
);

void showSimpleDialogMision(BuildContext context, WidgetBuilder builder) => showDialog(
  context: context,
  builder: (BuildContext context) => SimpleDialog(
    title: const Center(
      child: Text(
        "Misión",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    ),
    contentPadding: const EdgeInsets.all(16.0),
    children: [
      Container(
        width: 400.0,
        height: 450.0,
        child: const Center(
          child: Text(
            "Nuestra misión es ayudar a nuestros clientes a crear recuerdos y experiencias de vida a través de nuestros servicios de viaje. Nos esforzamos por ofrecer soluciones integrales a medida para cada cliente, desde la planificación y organización de viajes hasta la selección de los mejores destinos y actividades. Queremos ser reconocidos por nuestra pasión por los viajes, nuestra experiencia y conocimiento en el sector y nuestro compromiso con la calidad y la satisfacción del cliente.",
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ],
  ),
);
// Misión de una agencia de viajes:
