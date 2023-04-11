import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoredData extends StatefulWidget {
  const StoredData({Key? key}) : super(key: key);

  @override
  State<StoredData> createState() => _StoredDataState();
}

class _StoredDataState extends State<StoredData> {
  final CollectionReference demo =
      FirebaseFirestore.instance.collection("demo_user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Stored Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: demo.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final data = snapshot.requireData; //latest data received
              return Center(
                child: ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: 50,
                            );
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          imageUrl: '${data.docs[index]['profile']}',
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Name : ${data.docs[index]['Name']}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("id : ${data.docs[index]['id']}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
