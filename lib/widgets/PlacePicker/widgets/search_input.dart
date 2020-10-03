import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cyclist/utils/locales/app_translations.dart';

/// Custom Search input field, showing the search and clear icons.
class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;
  final AppTranslations trs;

  SearchInput(this.onSearchInput, this.trs, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  TextEditingController editController = TextEditingController();

  Timer debouncer;

  bool hasSearchEntry = false;

  SearchInputState();

  @override
  void initState() {
    super.initState();
    this.editController.addListener(this.onSearchInputChange);
  }

  @override
  void dispose() {
    this.editController.removeListener(this.onSearchInputChange);
    this.editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (this.editController.text.isEmpty) {
      this.debouncer?.cancel();
      widget.onSearchInput(this.editController.text);
      return;
    }

    if (this.debouncer?.isActive ?? false) {
      this.debouncer.cancel();
    }

    this.debouncer = Timer(Duration(milliseconds: 500), () {
      widget.onSearchInput(this.editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 3,
        // padding: EdgeInsets.symmetric(horizontal: 8),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(16),
        //   color: Theme.of(context).canvasColor,
        // ),
        child: Row(
          children: <Widget>[
            Icon(Icons.search, color: Theme.of(context).textTheme.bodyText2.color),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(hintText: widget.trs.translate("search"), border: InputBorder.none),
                controller: this.editController,
                onChanged: (value) {
                  setState(() {
                    this.hasSearchEntry = value.isNotEmpty;
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            if (this.hasSearchEntry)
              GestureDetector(
                child: Icon(Icons.clear),
                onTap: () {
                  this.editController.clear();
                  setState(() {
                    this.hasSearchEntry = false;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
