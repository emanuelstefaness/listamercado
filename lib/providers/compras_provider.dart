import 'package:mercado_a/models/item.dart';
import 'package:flutter/material.dart';

class ComprasProvider extends ChangeNotifier {
  List<Item> pendentes = [];
  List<Item> comprados = [];

  void adicionar(Item item) {
    pendentes.add(item);
    notifyListeners();
  }

  void marcarComprado(Item item) {
    pendentes.remove(item);
    comprados.add(item);
    notifyListeners();
  }

  void devolver(Item item) {
    comprados.remove(item);
    pendentes.add(item);
    notifyListeners();
  }

  void remover(Item item) {
    pendentes.remove(item);
    notifyListeners();
  }

  void limparComprados() {
    comprados.clear();
    notifyListeners();
  }
}
