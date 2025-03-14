import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Address', style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 30),
        ProvinceDropdown(),
        SizedBox(height: 20),
        MunicipalityDropdown(),
        SizedBox(height: 20),
        BaranggayDropdown(),
        SizedBox(height: 20),
        ZipCodeTextfield()
      ]
    );
  }
}
