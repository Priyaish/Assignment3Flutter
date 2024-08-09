import 'package:flutter/material.dart';

class ExchangeListPage extends StatefulWidget {
  @override
  _ExchangeListPageState createState() => _ExchangeListPageState();
}

class _ExchangeListPageState extends State<ExchangeListPage> {
  // Expanded example data with more currencies
  final Map<String, String> _exchangeRates = {
    'USD': '1.00',
    'EUR': '0.85',
    'JPY': '110.00',
    'GBP': '0.75',
    'AUD': '1.30',
    'CAD': '1.25',
    'CHF': '0.92',
    'CNY': '6.50',
    'INR': '83.00',
    'MXN': '18.00',
  };

  // Initialize filtered rates to show all currencies initially
  late List<String> _filteredRates;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load all currencies initially
    _filteredRates = _exchangeRates.keys.toList();
  }

  void _filterRates(String query) {
    final filtered = _exchangeRates.keys.where((currency) {
      final currencyLower = currency.toLowerCase();
      final queryLower = query.toLowerCase();
      return currencyLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredRates = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange List'),
      ),
      body: Column(
        children: [
          // Search bar to filter currencies
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterRates,
              decoration: InputDecoration(
                labelText: 'Search by Currency Code',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Display the filtered list of currencies
          Expanded(
            child: ListView.builder(
              itemCount: _filteredRates.length,
              itemBuilder: (context, index) {
                final currency = _filteredRates[index];
                final rate = _exchangeRates[currency]!;
                return ListTile(
                  title: Text('$currency: $rate'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
