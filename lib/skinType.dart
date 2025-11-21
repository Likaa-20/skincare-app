import 'package:flutter/material.dart';
class Skin {
  String type;


  Skin(this.type);
  @override

  String toString() {
    return '$type';

  }
}

List<Skin> skins = [
  Skin('Dry'),
  Skin('Normal'),
  Skin('Oily')
];
class MyDropdownMenuWidget extends StatefulWidget {
  const MyDropdownMenuWidget({required this.updateSkin, super.key});
  final Function(Skin) updateSkin;
  @override
  State<MyDropdownMenuWidget> createState() => _MyDropdownMenuWidgetState();

}
class _MyDropdownMenuWidgetState extends State<MyDropdownMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: 210.0,
        initialSelection: skins[0], // first car to be displayed
        onSelected: (skin) {
          setState(() {
            widget.updateSkin(skin as Skin);
          });
        },
        dropdownMenuEntries: skins.map<DropdownMenuEntry<Skin>>((Skin skin) {
          return DropdownMenuEntry(value: skin, label: skin.toString());
        }).toList());
  }
}

