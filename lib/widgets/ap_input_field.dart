import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../bloc/global/global_bloc.dart';
import '../style/theme.dart';
import 'loading_indicator.dart';

final List<String> predictions = GlobalBloc.instance.state.stations;

class APInputField extends StatelessWidget {
  final SuggestionsBoxController suggestionsBoxController;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String? labelText;
  final bool isError;

  const APInputField({
    Key? key,
    required this.suggestionsBoxController,
    required this.focusNode,
    required this.textEditingController,
    this.labelText,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Theme.of(context).highlightColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15),
        child: TypeAheadFormField(
          loadingBuilder: (context) => const Center(
            child: LoadingIndicator(
              dotRadius: 3.24,
              radius: 8,
            ),
          ),
          suggestionsBoxController: suggestionsBoxController,
          textFieldConfiguration: TextFieldConfiguration(
            style: TextStyle(
              color:
                  isError == true ? Colors.red : Theme.of(context).primaryColor,
            ),
            textAlignVertical: TextAlignVertical.center,
            focusNode: focusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              labelStyle: TextStyle(
                color: isError == true ? Colors.red : myColors.labelColor,
              ),
            ),
            controller: textEditingController,
          ),
          suggestionsCallback: (pattern) {
            return getSuggestions(pattern);
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: Theme.of(context).cardColor,
            offsetX: -10,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
          ),
          noItemsFoundBuilder: (BuildContext context) => const Text(
            '\n   Neveljaven vnos!\n',
            style: TextStyle(color: Colors.red),
          ),
          animationDuration: const Duration(seconds: 1),
          getImmediateSuggestions: true,
          transitionBuilder: (context, suggestionsBox, controller) {
            return FadeTransition(
              opacity: CurvedAnimation(
                  parent: controller!.view, curve: Curves.fastOutSlowIn),
              child: suggestionsBox,
            );
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              selectedTileColor: Theme.of(context).shadowColor,
              title: Text(suggestion.toString()),
            );
          },
          onSuggestionSelected: (suggestion) {
            textEditingController.text = suggestion.toString();
          },
        ),
      ),
    );
  }
}

List<String> getSuggestions(String query) {
  final List<String> matches = [];

  matches.addAll(predictions);

  matches.retainWhere((s) => s
      .replaceAll('s', 'š')
      .replaceAll('c', 'č')
      .replaceAll('z', 'ž')
      .toLowerCase()
      .contains(
        query
            .replaceAll('s', 'š')
            .replaceAll('c', 'č')
            .replaceAll('z', 'ž')
            .toLowerCase(),
      ));

  return matches;
}
