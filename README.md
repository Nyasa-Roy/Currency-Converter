# Currency-Converter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resou# 💱 Flutter Currency Converter

A beautiful and functional multi-currency converter app built with Flutter. Convert between 20+ popular world currencies with real-time exchange rates.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features

- 🌍 **20+ Currencies Supported** - Convert between major world currencies
- 💹 **Real-time Exchange Rates** - Fetches live rates from ExchangeRate API
- 💱 **Currency Symbols** - Displays proper symbols (₹, $, €, £, ¥, etc.)
- 🔄 **Quick Swap** - Instantly swap between currencies
- ⚡ **Auto-convert** - Updates conversion as you type
- 🎨 **Clean UI** - Modern and intuitive Material Design interface
- 📱 **Responsive** - Works on all screen sizes

## 🌐 Supported Currencies

| Currency | Code | Symbol |
|----------|------|--------|
| US Dollar | USD | $ |
| Euro | EUR | € |
| British Pound | GBP | £ |
| Japanese Yen | JPY | ¥ |
| Indian Rupee | INR | ₹ |
| Australian Dollar | AUD | A$ |
| Canadian Dollar | CAD | C$ |
| Swiss Franc | CHF | CHF |
| Chinese Yuan | CNY | ¥ |
| Swedish Krona | SEK | kr |
| New Zealand Dollar | NZD | NZ$ |
| Mexican Peso | MXN | $ |
| Singapore Dollar | SGD | S$ |
| Hong Kong Dollar | HKD | HK$ |
| Norwegian Krone | NOK | kr |
| South Korean Won | KRW | ₩ |
| Turkish Lira | TRY | ₺ |
| Russian Ruble | RUB | ₽ |
| Brazilian Real | BRL | R$ |
| South African Rand | ZAR | R |

## 📸 Screenshots
```
[Add your app screenshots here]
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code with Flutter extensions
- An emulator or physical device

### Installation

1. **Clone the repository**
```bash
   git clone https://github.com/yourusername/flutter-currency-converter.git
   cd flutter-currency-converter
```

2. **Install dependencies**
```bash
   flutter pub get
```

3. **Run the app**
```bash
   flutter run
```

## 📦 Dependencies

Add these to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

## 🏗️ Project Structure
```
lib/
├── main.dart                          # App entry point
└── currency_converter_material_page.dart   # Main converter screen
```

## 🔧 Configuration

### API Information

This app uses the [ExchangeRate-API](https://www.exchangerate-api.com/) for fetching real-time currency exchange rates.

- **Free Tier**: 1,500 requests per month
- **No API Key Required** for basic usage
- **Rate Limits**: Automatically handled

### Changing the API (Optional)

If you want to use a different API or add an API key, modify the `fetchExchangeRates()` method:
```dart
Future<void> fetchExchangeRates() async {
  final response = await http.get(
    Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'),
    // Add headers for API key if needed
    // headers: {'Authorization': 'Bearer YOUR_API_KEY'},
  );
  // ... rest of the code
}
```

### Alternative APIs

- [Fixer.io](https://fixer.io/) - Requires API key
- [Open Exchange Rates](https://openexchangerates.org/) - Requires API key
- [Currency API](https://currencyapi.com/) - Requires API key

## 💡 Usage

1. **Select Source Currency**: Choose the currency you want to convert from using the top dropdown
2. **Enter Amount**: Type the amount in the text field
3. **Select Target Currency**: Choose the currency you want to convert to using the bottom dropdown
4. **View Result**: The converted amount appears at the top
5. **Swap Currencies**: Tap the swap icon (⇅) to quickly reverse the conversion
6. **Refresh Rates**: Tap "Refresh Rates" to get the latest exchange rates

rces to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
