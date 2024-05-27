import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to fetch customer data from the server
Future<List<Customer>> fetchCustomers() async {
  final response =
      await http.get(Uri.parse('http://your-backend-api/customers'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => Customer.fromJson(data)).toList();
  } else {
    // If the server returns an error response, throw an exception
    throw Exception('Failed to load customers');
  }
}

// Model class representing a customer
class Customer {
  final int customerId;
  final String username;
  final String password;
  final String role;
  final String firstname;
  final String middlename;
  final String lastname;
  final String address;
  final String emailAddress;

  Customer({
    required this.customerId,
    required this.username,
    required this.password,
    required this.role,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.address,
    required this.emailAddress,
  });

  // Factory method to create a Customer object from JSON data
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['CustomerID'],
      username: json['Username'],
      password: json['PASSWORD'],
      role: json['Role'],
      firstname: json['Firstname'],
      middlename: json['Middlename'],
      lastname: json['Lastname'],
      address: json['Address'],
      emailAddress: json['EmailAddress'],
    );
  }
}

// Example usage:
void main() async {
  // Fetch customers from the server
  List<Customer> customers = await fetchCustomers();

  // Print customer details
  customers.forEach((customer) {
    print(
        'Customer: ${customer.firstname} ${customer.lastname}, Email: ${customer.emailAddress}');
  });
}
