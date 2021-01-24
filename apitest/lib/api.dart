import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class API {
  String url;
  String userID = "uO6mlTc4jrcJSUIpikVt";
  String companyID = "57b2ORKV0Rw1u9Glnowh";

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'RXSilRA8R6RQ46sG3TQAXScZiGJl6M6s'
  };

  Future<List<String>> getBranchID() async {
    List<String> ids = [];
    url = "https://qanty-lab.firebaseapp.com/api/company/get_branches";
    var response = await http.post(url,
        headers: headers,
        body: convert.jsonEncode(<String, String>{"company_id": companyID}));
    var jsonconverter = convert.jsonDecode(response.body);
    var branchid = jsonconverter['sites'][0]['id'];
    print("Branch ID =  $branchid");
    ids.add(branchid);
    var lineid = await getLine(branchid);
    ids.add(lineid);
    return ids;
  }

  Future<String> getLine(var branchID) async {
    url = "https://qanty-lab.firebaseapp.com/api/branches/get_lines";
    var response = await http.post(url,
        headers: headers,
        body: convert.jsonEncode(<String, String>{
          "company_id": companyID,
          "branch_id": branchID,
        }));
    var jsonconverter = convert.jsonDecode(response.body);
    var lineid = jsonconverter['lines'][0]['id'];
    print("Line ID =  $lineid");
    return lineid;
  }

  Future<List<String>> createTickets() async {
    List<String> ids = await getBranchID();
    var branchid = ids[0];
    var lineid = ids[1];
    List<String> ticketinfo = [];
    url = "https://qanty-lab.firebaseapp.com/api/create_ticket";
    var response = await http.post(url,
        headers: headers,
        body: convert.jsonEncode(<String, String>{
          "company_id": companyID,
          "branch_id": branchid,
          "line_id": lineid,
          "user_id": userID,
        }));
    var jsonconverter = convert.jsonDecode(response.body);
    var ticketname = jsonconverter['ticket_name'];
    ticketinfo.add(ticketname);
    var ticketid = jsonconverter['ticket_id'];
    ticketinfo.add(ticketid);
    print("Ticket Turn Name =  $ticketname");
    print("Ticket Turn ID =  $ticketid");
    return ticketinfo;
  }

  Future<int> getTickets() async {
    List<String> ticketsinfo = await createTickets();
    var ticketid = ticketsinfo[1];
    url = "https://qanty-lab.firebaseapp.com/api/get_ticket";
    var response = await http.post(url,
        headers: headers,
        body: convert.jsonEncode(<String, String>{
          "company_id": companyID,
          "ticket_id": ticketid,
        }));
    var jsonconverter = convert.jsonDecode(response.body);
    var ticketsinfront =
        jsonconverter['info']['wait_metrics']['tickets_in_front'];
    print("Number of Tickets Infront =  $ticketsinfront");
    return ticketsinfront;
  }
}
