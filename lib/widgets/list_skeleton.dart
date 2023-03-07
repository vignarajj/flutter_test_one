import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmerEffect extends StatelessWidget {
  const ListShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          height: 1,
                          color: Colors.black45,
                        ),
                    itemCount: 20,
                    padding: const EdgeInsets.all(3),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 6,
                            height: 40.0,
                            color: Colors.white,
                          ),
                        ],
                      );
                    })))
      ],
    );
  }
}

class GridShimmerEffect extends StatelessWidget {
  const GridShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: 40,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 3,
                );
              }),
        ))
      ],
    );
  }
}
