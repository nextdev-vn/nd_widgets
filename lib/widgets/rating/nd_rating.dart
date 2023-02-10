import 'package:flutter/material.dart';

import '../../constants/size/nd_size.dart';

typedef RatingChangeCallback = void Function(double rating);

class NDRating extends StatefulWidget {
  const NDRating({
    Key? key,
    required this.onChanged,
    required this.value,
    this.itemCount = 5,
    this.spacing = 0.0,
    this.defaultIcon,
    this.color,
    this.borderColor,
    this.size = NDSize.MEDIUM,
    this.filledIcon,
    this.halfFilledIcon,
    this.allowHalfRating = true,
    this.showTextForm = false,
    this.suffixIcon,
    this.controller,
    this.inputDecorations,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  }) : super(key: key);

  final int itemCount;

  final Color? color;

  final Color? borderColor;

  final double size;

  final bool allowHalfRating;

  final Widget? filledIcon;

  final Widget? halfFilledIcon;

  final Widget? defaultIcon;

  final double spacing;

  final double value;

  final RatingChangeCallback onChanged;

  final bool showTextForm;

  final Widget? suffixIcon;

  final TextEditingController? controller;

  final InputDecoration? inputDecorations;

  final EdgeInsets margin;

  final EdgeInsets padding;

  @override
  _NDRatingState createState() => _NDRatingState();
}

class _NDRatingState extends State<NDRating> {
  Widget buildRatingBar(BuildContext context, int index) {
    Widget icon;
    if (index >= widget.value) {
      icon = widget.defaultIcon ??
          Icon(
            Icons.star_border,
            color: widget.borderColor ?? Theme.of(context).primaryColor,
            size: widget.size,
          );
    } else if (!widget.showTextForm
        ? index > widget.value - (widget.allowHalfRating ? 0.5 : 1.0) &&
            index < widget.value
        : index + 1 == widget.value + 0.5) {
      icon = widget.halfFilledIcon ??
          Icon(
            Icons.star_half,
            color: widget.color ?? Theme.of(context).primaryColor,
            size: widget.size,
          );
    } else {
      icon = widget.filledIcon ??
          Icon(
            Icons.star,
            color: widget.color ?? Theme.of(context).primaryColor,
            size: widget.size,
          );
    }

    return GestureDetector(
      onTap: () {
        widget.onChanged(index + 1.0);
      },
      onHorizontalDragUpdate: (dragDetails) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final _pos = box.globalToLocal(dragDetails.globalPosition);
        final i = _pos.dx / widget.size;
        var newRating = widget.allowHalfRating ? i : i.round().toDouble();
        if (newRating > widget.itemCount) {
          newRating = widget.itemCount.toDouble();
        }
        if (newRating < 0) {
          newRating = 0.0;
        }
        widget.onChanged(newRating);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) => widget.showTextForm
      ? Column(children: <Widget>[
          Container(
            margin: widget.margin,
            padding: widget.padding,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              decoration: widget.inputDecorations ??
                  InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter rating',
                    labelText: 'Enter rating',
                    suffixIcon: widget.suffixIcon,
                  ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: widget.spacing,
              children: List.generate(
                widget.itemCount,
                (index) => buildRatingBar(context, index),
              ),
            ),
          )
        ])
      : Material(
          color: Colors.transparent,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: widget.spacing,
            children: List.generate(
              widget.itemCount,
              (index) => buildRatingBar(context, index),
            ),
          ),
        );
}
