import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/equipment.dart';

class EquipmentsListView extends StatelessWidget {
  final List<Equipment> equipments;

  const EquipmentsListView({Key? key, required this.equipments})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(
            width: 26,
          ),
          ...equipments.map((equipment) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 5,
                          color: Color.fromRGBO(0, 0, 0, 0.20),
                        )
                      ],
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: CachedNetworkImageProvider(
                              "https://spoonacular.com/cdn/equipment_100x100/${equipment.image}")),
                    ),
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      equipment.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
