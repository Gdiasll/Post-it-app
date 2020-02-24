import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CardModel {
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<Map<String, dynamic>> getCards() async {
    SharedPreferences prefs = await _getPrefs();
    String cards = prefs.getString('cards');
    return cards != null ? json.decode(cards) : new Map();
  }
  
  Future setCard(card) async {
    SharedPreferences prefs = await _getPrefs();
    Map cards = await this.getCards();
    cards.addAll(card) ;
    String jsonCards =  json.encode(cards);
    return prefs.setString('cards', jsonCards);
  }

  Future deletCard(key) async {
    SharedPreferences prefs = await _getPrefs();
    Map cards = await this.getCards();
    cards.remove(key);
    String jsonCards = json.encode(cards);
    return prefs.setString('cards', jsonCards);
  }
}