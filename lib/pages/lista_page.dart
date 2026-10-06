import 'package:mercado_a/models/item.dart';
import 'package:mercado_a/pages/comprados_page.dart';
import 'package:mercado_a/providers/compras_provider.dart';
import 'package:mercado_a/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  void adicionarItem() {
    if (controller.text.trim().isEmpty) {
      return;
    }
    final compras = Provider.of<ComprasProvider>(context, listen: false);
    compras.adicionar(Item(name: controller.text.trim()));
    controller.clear();
  }

  void comprarItem(Item item) {
    final compras = Provider.of<ComprasProvider>(context, listen: false);
    compras.marcarComprado(item);
  }

  void removerItem(Item item) {
    final compras = Provider.of<ComprasProvider>(context, listen: false);
    compras.remover(item);
  }

  @override
  Widget build(BuildContext context) {
    final compras = Provider.of<ComprasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de Compras",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CompradosPage()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Digite um item",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ButtonWidget(
                    text: "+",
                    onPressed: () {
                      adicionarItem();
                    },
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            if (compras.pendentes.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Nenhum item na lista.",
                  style: TextStyle(fontSize: 20),
                ),
              )
            else
              ...compras.pendentes.map(
                (item) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          comprarItem(item);
                        },
                        icon: Icon(Icons.check, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () {
                          removerItem(item);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
