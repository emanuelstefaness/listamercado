import 'package:mercado_a/providers/compras_provider.dart';
import 'package:mercado_a/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompradosPage extends StatelessWidget {
  const CompradosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final compras = Provider.of<ComprasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprados"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Faltam: ${compras.pendentes.length}  |  Comprados: ${compras.comprados.length}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            if (compras.comprados.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Nenhum item comprado.",
                  style: TextStyle(fontSize: 20),
                ),
              )
            else
              ...compras.comprados.map(
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
                          Provider.of<ComprasProvider>(
                            context,
                            listen: false,
                          ).devolver(item);
                        },
                        icon: Icon(Icons.undo, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
            if (compras.comprados.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: ButtonWidget(
                  text: "Limpar",
                  onPressed: () {
                    Provider.of<ComprasProvider>(
                      context,
                      listen: false,
                    ).limparComprados();
                  },
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
