import 'package:flutter/material.dart';

class SliverTask extends StatefulWidget {
  const SliverTask({Key? key}) : super(key: key);

  @override
  State<SliverTask> createState() => _SliverTaskState();
}

class _SliverTaskState extends State<SliverTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.amber,
            centerTitle: true,
            title: Text("Sliver App Bar"),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverClass(
              minHeight: 100,
              maxHeight: 100,
              child: Container(
                height: 100,
                color: Colors.deepPurple[100],
                child: const Center(child: Text("SliverGird Count")),
              ),
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 3,
            children: [
              Container(
                color: Colors.deepOrangeAccent,
                height: 100,
              ),
              Container(
                color: Colors.tealAccent,
                height: 100,
              ),
              Container(
                color: Colors.limeAccent,
                height: 100,
              ),
              Container(
                color: Colors.brown,
                height: 100,
              ),
              Container(
                color: Colors.deepPurple,
                height: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
              ),
              Container(
                color: Colors.amber,
                height: 100,
              ),
              Container(
                color: Colors.white,
                height: 100,
              ),
              Container(
                color: Colors.black,
                height: 100,
              ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverClass(
              minHeight: 100,
              maxHeight: 100,
              child: Container(
                height: 100,
                color: Colors.deepPurple[100],
                child: const Center(child: Text("Sliver Gird")),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.orange[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 10,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverClass(
              minHeight: 100,
              maxHeight: 100,
              child: Container(
                height: 100,
                color: Colors.deepPurple[100],
                child: const Center(child: Text("SliverFixed Extent List")),
              ),
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildListDelegate(
                [
                  Container(color: Colors.red),
                  Container(color: Colors.purple),
                  Container(color: Colors.green),
                  Container(color: Colors.orange),
                  Container(color: Colors.yellow),
                ],
              ),
              itemExtent: 120),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverClass(
              minHeight: 100,
              maxHeight: 100,
              child: Container(
                height: 100,
                color: Colors.deepPurple[100],
                child: const Center(child: Text("Sliver List")),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(color: Colors.pink, height: 120.0),
                Container(color: Colors.cyan, height: 120.0),
                Container(color: Colors.indigo, height: 120.0),
                Container(color: Colors.blue, height: 120.0),
                Container(color: Colors.limeAccent, height: 120.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliverClass extends SliverPersistentHeaderDelegate {
  SliverClass({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverClass oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
