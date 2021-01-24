import 'package:apitest/tickets.dart';
import 'package:flutter/material.dart';

class TicketsNameModel extends ChangeNotifier {
  String ticketname;
  int ticketsinfront;

  Future<void> getTicketsName() async {
    ticketname = await Tickets().getTicketsName();
    notifyListeners();
  }

  Future<void> getTicketsInfront() async {
    ticketsinfront = await Tickets().getNumberInfrontTickets();
    notifyListeners();
  }
}
