import 'package:flutter/material.dart';

class ExpandableSection extends StatefulWidget {
  final String title;
  final bool initiallyExpanded;
  final List<Widget> children;
  final EdgeInsetsGeometry? childrenPadding;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.initiallyExpanded,
    required this.children,
    this.childrenPadding = const EdgeInsets.only(left: 16, top: 8),
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),

        if (_isExpanded)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 225),
            child: SingleChildScrollView(
              child: Padding(
                padding: widget.childrenPadding ?? EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.children,
                ),
              ),
            ),
          ),
      ],
    );
  }
}