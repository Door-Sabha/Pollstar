import 'package:flutter/material.dart';
import 'package:pollstar/utils/theme/colors.dart';

// ignore: must_be_immutable
class MyDropDownButton extends StatefulWidget {
  final List<MyDropDownButtonItem> list;
  final Function? onChanged;
  MyDropDownButtonItem? selectedItem;
  final String? hint;
  final double? padding;

  MyDropDownButton({
    super.key,
    required this.list,
    this.selectedItem,
    this.onChanged,
    this.hint,
    this.padding,
  });

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  final double _height = 56;
  final double _fontSize = 16;
  final double _borderRadius = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 16),
      clipBehavior: Clip.antiAlias,
      foregroundDecoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greenColor,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: DropdownButton<MyDropDownButtonItem>(
        alignment: Alignment.centerLeft,
        underline: Container(),
        style: TextStyle(
          color: AppColors.textColorDark,
          fontSize: _fontSize,
        ),
        isExpanded: true,
        iconSize: _fontSize * 2,
        icon: const Icon(Icons.expand_more_rounded),
        hint: Text(
          widget.hint ?? 'Select...',
          style: TextStyle(
            color: AppColors.textColorDark,
            fontSize: _fontSize,
          ),
        ),
        dropdownColor: Colors.white,
        isDense: true,
        value: widget.list.contains(widget.selectedItem)
            ? widget.selectedItem
            : null,
        items: widget.list.map((MyDropDownButtonItem item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item.getDisplayName(),
              style: const TextStyle(color: AppColors.textColorDark),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.selectedItem = value;
          });
          (widget.onChanged != null) ? widget.onChanged!(value) : null;
        },
      ),
    );
  }
}

class MyDropDownButtonItem {
  String getDisplayName() => "";
  String getType() => "";
}
