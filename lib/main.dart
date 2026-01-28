import 'package:flutter/material.dart';
import 'currency_conv_material_page.dart';
void main(){
  runApp(const MyApp());
}
//types of widgets:
//1.stateless, 2. stateful(for ui we only have these two) 
//3. inherited
//state is some data that widget will care about


//you've two design systems, material design(google) and cupertino(apple)



class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrencyConverterMaterialPage(),
    );
  }
}