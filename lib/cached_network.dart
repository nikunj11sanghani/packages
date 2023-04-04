import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetwork extends StatefulWidget {
  const CachedNetwork({Key? key}) : super(key: key);

  @override
  State<CachedNetwork> createState() => _CachedNetworkState();
}

class _CachedNetworkState extends State<CachedNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cached Images"),
      ),
      body: Center(
          child: CachedNetworkImage(
        imageUrl: 'http://via.placeholder.com/350x150',
        imageBuilder: (context, imageProvider) {
          return Container(
            width: 200,
            height: 200,
            decoration:
                BoxDecoration(image: DecorationImage(image: imageProvider)),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context, url) => const CircularProgressIndicator(),
      )),
    );
  }
}
