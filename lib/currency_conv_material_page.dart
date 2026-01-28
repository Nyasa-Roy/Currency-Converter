import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();
  
  String fromCurrency = 'USD';
  String toCurrency = 'INR';
  Map<String, dynamic> exchangeRates = {};
  bool isLoading = false;

  // Currency symbols map
  final Map<String, String> currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'INR': '₹',
    'AUD': 'A\$',
    'CAD': 'C\$',
    'CHF': 'CHF',
    'CNY': '¥',
    'SEK': 'kr',
    'NZD': 'NZ\$',
    'MXN': '\$',
    'SGD': 'S\$',
    'HKD': 'HK\$',
    'NOK': 'kr',
    'KRW': '₩',
    'TRY': '₺',
    'RUB': '₽',
    'BRL': 'R\$',
    'ZAR': 'R',
  };

  // Popular currencies list
  final List<String> currencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'INR', 'AUD', 'CAD', 'CHF', 'CNY', 'SEK',
    'NZD', 'MXN', 'SGD', 'HKD', 'NOK', 'KRW', 'TRY', 'RUB', 'BRL', 'ZAR'
  ];

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Using exchangerate-api.com (free tier: 1500 requests/month)
      final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          exchangeRates = data['rates'];
          isLoading = false;
        });
        
        // Auto-convert if there's a value
        if (textEditingController.text.isNotEmpty) {
          convert();
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching rates: $e')),
        );
      }
    }
  }

  void convert() {
    if (textEditingController.text.isEmpty) return;
    
    final input = double.tryParse(textEditingController.text);
    if (input == null) return;

    if (exchangeRates.isNotEmpty) {
      setState(() {
        result = input * exchangeRates[toCurrency];
      });
    }
  }

  void swapCurrencies() {
    setState(() {
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
    fetchExchangeRates();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text('Currency Converter'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result display
              Text(
                '${currencySymbols[toCurrency] ?? toCurrency} ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              
              // From Currency Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: fromCurrency,
                    isExpanded: true,
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(
                          '${currencySymbols[currency] ?? ''} $currency',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          fromCurrency = newValue;
                        });
                        fetchExchangeRates();
                      }
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Input field
              TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in $fromCurrency',
                  hintStyle: const TextStyle(color: Colors.black54),
                  prefixIcon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.black,
                  ),
                  prefixText: '${currencySymbols[fromCurrency] ?? ''} ',
                  prefixStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (value) => convert(),
              ),
              
              const SizedBox(height: 10),
              
              // Swap button
              IconButton(
                onPressed: swapCurrencies,
                icon: const Icon(Icons.swap_vert, size: 32),
                color: Colors.white,
              ),
              
              const SizedBox(height: 10),
              
              // To Currency Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: toCurrency,
                    isExpanded: true,
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(
                          '${currencySymbols[currency] ?? ''} $currency',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          toCurrency = newValue;
                        });
                        convert();
                      }
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Convert/Refresh button
              ElevatedButton(
                onPressed: isLoading ? null : fetchExchangeRates,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Refresh Rates'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}