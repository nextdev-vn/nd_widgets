import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_checkbox_type.dart';
import '../button/nd_button.dart';
import '../checkbox_list_tile/nd_checkbox_list_tile.dart';

class NDMultiSelect<T> extends StatefulWidget {
  const NDMultiSelect({
    required this.items,
    required this.onSelect,
    this.initialSelectedItemsIndex,
    this.dropdownTitleTileText = 'Select : ',
    this.dropdownTitleTileTextStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    this.color,
    this.avatar,
    this.padding = const EdgeInsets.all(5),
    this.margin = const EdgeInsets.all(5),
    this.size = NDSize.SMALL,
    this.type = NDCheckboxType.basic,
    this.activeBgColor = NDColors.WHITE,
    this.inactiveBgColor = NDColors.WHITE,
    this.activeBorderColor = NDColors.WHITE,
    this.inactiveBorderColor = NDColors.WHITE,
    this.listItemTextColor = NDColors.DARK,
    this.buttonColor = NDColors.PRIMARY,
    this.submitButton,
    this.cancelButton,
    this.expandedIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black87,
      size: 30,
    ),
    this.collapsedIcon = const Icon(
      Icons.keyboard_arrow_up,
      color: Colors.black87,
      size: 30,
    ),
    this.dropdownBgColor = Colors.white,
    this.activeIcon = const Icon(
      Icons.check,
      size: 20,
      color: NDColors.DARK,
    ),
    this.inactiveIcon,
    this.customBgColor = NDColors.SUCCESS,
    this.selected = false,
    this.dropdownTitleTileBorder,
    this.dropdownTitleTileBorderRadius =
        const BorderRadius.all(Radius.circular(4)),
    this.dropdownTitleTileColor = NDColors.WHITE,
    this.hideDropdownUnderline = false,
    this.dropdownUnderlineBorder =
        const BorderSide(color: Colors.black45, width: 1),
    this.dropdownTitleTileMargin = const EdgeInsets.all(16),
    this.dropdownTitleTilePadding = const EdgeInsets.all(12),
    this.dropdownTitleTileHintText,
    this.dropdownTitleTileHintTextStyle =
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    this.dropdownButton,
    Key? key,
  }) : super(key: key);

  final List<dynamic> items;

  final List<int>? initialSelectedItemsIndex;

  final ValueChanged<List<dynamic>> onSelect;

  final String dropdownTitleTileText;

  final TextStyle dropdownTitleTileTextStyle;

  final String? dropdownTitleTileHintText;

  final TextStyle dropdownTitleTileHintTextStyle;

  final BorderRadius dropdownTitleTileBorderRadius;

  final Border? dropdownTitleTileBorder;

  final dynamic dropdownTitleTileColor;

  final bool hideDropdownUnderline;

  final BorderSide dropdownUnderlineBorder;

  final EdgeInsets dropdownTitleTileMargin;

  final EdgeInsets dropdownTitleTilePadding;

  final Widget expandedIcon;

  final Widget collapsedIcon;

  final Widget? submitButton;

  final Widget? cancelButton;

  final dynamic color;

  final Widget? avatar;

  final EdgeInsets margin;

  final EdgeInsets padding;

  final NDCheckboxType type;

  final double size;

  final Color activeBgColor;

  final Color inactiveBgColor;

  final Color activeBorderColor;

  final Color inactiveBorderColor;

  final Color buttonColor;

  final Color? listItemTextColor;

  final Widget activeIcon;

  final Widget? inactiveIcon;

  final Color customBgColor;

  final bool selected;

  final Color dropdownBgColor;

  final Widget? dropdownButton;

  @override
  _NDMultiSelectState createState() => _NDMultiSelectState();
}

class _NDMultiSelectState<T> extends State<NDMultiSelect<T>>
    with AutomaticKeepAliveClientMixin {
  final List _selectedTitles = [];
  final List _selectedTitlesIndex = [];
  bool showDropdown = false;
  final _controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialSelectedItemsIndex != null &&
        widget.initialSelectedItemsIndex!.isNotEmpty) {
      for (int x in widget.initialSelectedItemsIndex!) {
        _selectedTitles.add(widget.items[x]);
        _selectedTitlesIndex.add(x);
      }
    }
    super.initState();
  }

  void _onItemSelect(bool selected, int index) {
    if (selected == true) {
      setState(() {
        _selectedTitles.add(widget.items[index]);
        _selectedTitlesIndex.add(index);
      });
    } else {
      setState(() {
        _selectedTitles.remove(widget.items[index]);
        _selectedTitlesIndex.remove(index);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget dropdownTile() => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _selectedTitles.isEmpty
                ? Expanded(
                    child: Text(widget.dropdownTitleTileText,
                        style: widget.dropdownTitleTileTextStyle))
                : Expanded(
                    child: Text(_selectedTitles.join(',  ').toString(),
                        style: widget.dropdownTitleTileTextStyle)),
            !showDropdown ? widget.expandedIcon : widget.collapsedIcon,
          ],
        );

    return Column(
      children: [
        InkWell(
            onTap: () {
              setState(() {
                showDropdown = !showDropdown;
              });
            },
            child: Container(
                margin: widget.dropdownTitleTileMargin,
                padding: widget.dropdownTitleTilePadding,
                decoration: BoxDecoration(
                    color: widget.dropdownTitleTileColor,
                    border: widget.dropdownTitleTileBorder,
                    borderRadius: widget.dropdownTitleTileBorderRadius),
                child: Container(
                  decoration: BoxDecoration(
                    border: widget.hideDropdownUnderline
                        ? const Border(
                            bottom: BorderSide(color: Colors.transparent))
                        : Border(bottom: widget.dropdownUnderlineBorder),
                  ),
                  child: widget.dropdownTitleTileHintText == null
                      ? dropdownTile()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.dropdownTitleTileHintText}',
                              style: widget.dropdownTitleTileHintTextStyle,
                            ),
                            dropdownTile(),
                            const SizedBox(
                              height: 2,
                            )
                          ],
                        ),
                ))),
        showDropdown
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: widget.dropdownBgColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                          children: List.generate(
                              widget.items.length,
                              (index) => NDCheckboxListTile(
                                    value: _selectedTitles
                                        .contains(widget.items[index]),
                                    onChanged: (bool selected) {
                                      _controller.text;
                                      _onItemSelect(selected, index);
                                      widget.onSelect(_selectedTitlesIndex);
                                    },
                                    selected: widget.selected,
                                    avatar: widget.avatar,
                                    titleText: widget.items[index],
                                    color: widget.color,
                                    padding: widget.padding,
                                    margin: widget.margin,
                                    size: widget.size,
                                    activeBgColor: widget.activeBgColor,
                                    inactiveIcon: widget.inactiveIcon,
                                    activeBorderColor: widget.activeBorderColor,
                                    inactiveBgColor: widget.inactiveBgColor,
                                    activeIcon: widget.activeIcon,
                                    inactiveBorderColor:
                                        widget.inactiveBorderColor,
                                    listItemTextColor: widget.listItemTextColor,
                                    customBgColor: widget.customBgColor,
                                    type: widget.type,
                                  ))),
                      widget.dropdownButton ??
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              NDButton(
                                color: widget.buttonColor,
                                onPressed: () {
                                  setState(() {
                                    showDropdown = !showDropdown;
                                    _selectedTitles.clear();
                                    _selectedTitlesIndex.clear();
                                  });
                                },
                                child:
                                    widget.cancelButton ?? const Text('CANCEL'),
                              ),
                              NDButton(
                                color: widget.buttonColor,
                                onPressed: () {
                                  setState(() {
                                    showDropdown = !showDropdown;
                                  });
                                },
                                child: widget.submitButton ?? const Text('OK'),
                              )
                            ],
                          )
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
