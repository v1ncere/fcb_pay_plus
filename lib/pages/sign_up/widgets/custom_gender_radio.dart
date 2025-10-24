import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CustomGenderRadio extends StatelessWidget {
	const CustomGenderRadio({super.key, required this.gender});
	final Gender gender;

	@override
	Widget build(BuildContext context) {
		return Card(
			color: gender.isSelected ? ColorString.eucalyptus : const Color(0xFFE8F5E9),
			child: Container(
				height: 80,
				alignment: Alignment.center,
				margin: EdgeInsets.all(5.0),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						Icon(
							gender.icon,
							color: gender.isSelected ? const Color(0xFFE8F5E9) : Colors.grey,
							size: 40,
						),
						SizedBox(height: 8),
						Text(
							gender.name,
							style: TextStyle(
								color: gender.isSelected ? const Color(0xFFE8F5E9) : Colors.grey,
								fontWeight: FontWeight.w700
							)
						)
					]
				)
			)
		);
	}
}