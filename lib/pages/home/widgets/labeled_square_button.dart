import 'package:flutter/material.dart';

class LabeledSquareButton extends StatelessWidget {
  const LabeledSquareButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap
  });

  final IconData icon;
  final String text;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(10),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2), // Shadow color
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2)
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: const Color(0xFF25C166),
              child: InkWell(
                splashColor: Colors.white60,
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: color),
                      const SizedBox(height: 2),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.15), // Shadow color
                              blurRadius: 1,
                              offset: const Offset(0, 1)
                            )
                          ]
                        )
                      )
                    ]
                  )
                )
              )
            )
          )
        )
      ]
    );
  }
}