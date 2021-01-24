import 'api.dart';

class Tickets {
  API api;
  Tickets() {
    api = API();
  }

  Future<String> getTicketsName() async {
    List<String> ticketname = await api.createTickets();
    return ticketname[0];
  }

  Future<int> getNumberInfrontTickets() async {
    return await api.getTickets();
  }
}
