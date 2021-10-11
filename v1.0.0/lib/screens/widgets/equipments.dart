import 'package:flutter/material.dart';
import '../../models/equipments.dart';

class EquipmentsListView extends StatelessWidget {
  final List<Equipments> equipments;

  const EquipmentsListView({Key key, this.equipments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      height: 170,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        children: [
          ...equipments.map((equipment) {
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage("${equipment.image}")),
                        )),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        equipment.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    ));
  }
}
