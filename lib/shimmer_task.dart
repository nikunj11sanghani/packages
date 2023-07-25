import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/helper_tile.dart';
import 'package:flutter_packages/widgets/shimmer_loader.dart';

class ShimmerTask extends StatefulWidget {
  const ShimmerTask({Key? key}) : super(key: key);

  @override
  State<ShimmerTask> createState() => _ShimmerTaskState();
}

class _ShimmerTaskState extends State<ShimmerTask> {
  bool hasData = false;
  List<Details> data = [
    Details("Robena", "001"),
    Details("Martina", "002"),
    Details("Jamie", "003"),
    Details("Leopold", "004"),
    Details("Amos", "005"),
    Details("Effie", "006"),
    Details("Foster", "007"),
    Details("Piper", "008"),
    Details("Harry", "009"),
    Details("Marry", "010"),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          hasData = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Shimmer Task"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => hasData
              ? HelperTile(
                  leading: data[index].name.substring(0, 1),
                  title: data[index].name,
                  id: data[index].id,
                )
              : const ShimmerLoader(),
          separatorBuilder: (context, index) => const Divider(
                height: 4,
                thickness: 2,
              ),
          itemCount: data.length),
    );
  }
}

class Details {
  final String name, id;

  Details(this.name, this.id);
}
