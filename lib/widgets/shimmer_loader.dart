import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
          ),
          title: Container(
            width: 50,
            height: 18,
            color: Colors.white,
          ),
          subtitle: Container(
            width: 30,
            height: 18,
            color: Colors.white,
          ),
        ));
  }
}
