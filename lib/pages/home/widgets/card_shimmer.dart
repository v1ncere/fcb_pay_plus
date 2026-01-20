import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/utils.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _shimmerCard(height: 150, width: MediaQuery.of(context).size.width),
        _shimmerCard(height: 160, width: MediaQuery.of(context).size.width),
        _shimmerCard(height: 200, width: MediaQuery.of(context).size.width)
      ],
    );
  }
}

class SingleCardShimmer extends StatelessWidget {
  const SingleCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _shimmerCard(height: 150, width: MediaQuery.of(context).size.width);
  }
}

class SingleCardError extends StatelessWidget {
  const SingleCardError({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SvgPicture.asset(
              AssetString.inboxEmpty,
              height: 80,
              width: 80,
            )
          )
        )
      )
    );
  }
}

Card _shimmerCard({
  required double width,
  required double height
}) {
  return Card(
    elevation: 2,
    clipBehavior: Clip.antiAlias,
    color: Colors.grey[200],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width * 0.6,
                    height: 10.0,
                    color: Colors.grey,
                  )
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width * 0.2,
                    height: 10.0,
                    color: Colors.grey,
                  )
                )
              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width * 0.3,
                    height: 10.0,
                    color: Colors.grey, // Placeholder line color
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width * 0.2,
                    height: 10.0,
                    color: Colors.grey, // Placeholder line color
                  )
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width * 0.5,
                    height: 10.0,
                    color: Colors.grey,
                  )
                )
              ]
            )
          ]
        )
      )
    )
  );
}