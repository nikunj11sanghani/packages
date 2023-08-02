import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/helper_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridViewTask extends StatefulWidget {
  const StaggeredGridViewTask({Key? key}) : super(key: key);

  @override
  State<StaggeredGridViewTask> createState() => _StaggeredGridViewTaskState();
}

class _StaggeredGridViewTaskState extends State<StaggeredGridViewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StaggeredGridView Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: const [
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: HelperContainer(
                      colors: Colors.orange,
                      text: 'orange',
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: HelperContainer(
                      colors: Colors.lime,
                      text: 'lime',
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: HelperContainer(
                      colors: Colors.lightGreen,
                      text: 'lightGreen',
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 2,
                    child: HelperContainer(
                      colors: Colors.cyan,
                      text: 'cyan',
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 2,
                    child: HelperContainer(
                      colors: Colors.deepPurple,
                      text: 'deepPurple',
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
