import 'package:exchange_rate_calculator/data/data_adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFilters extends StatelessWidget {
  const MyFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const MyFilterListWidget(),
    );
  }
}

class MyFilterListWidget extends StatefulWidget {
  const MyFilterListWidget({super.key});

  @override
  State<MyFilterListWidget> createState() => _MyFilterListWidgetState();
}

class _MyFilterListWidgetState extends State<MyFilterListWidget> {
  String _query = '';

  void _onChanged(String value) {
    setState(() {
      _query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataAdapter>(
      builder: (context, dataAdapter, child) {
        List<String> currencyKeys = dataAdapter.currencies.keys.toList();
        List<String> filteredKeys = List.from(currencyKeys
            .where(
              (element) => dataAdapter.currencies[element]!
                  .toLowerCase()
                  .contains(_query.toLowerCase()),
            )
            .toList());

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredKeys.length,
                itemBuilder: (context, index) {
                  bool isChecked =
                      dataAdapter.orderedList.contains(filteredKeys[index]);
                  return ListTile(
                    title: Text(
                        dataAdapter.currencies[filteredKeys[index]].toString()),
                    trailing: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        if (value != null) {
                          isChecked = value;
                          if (value) {
                            dataAdapter.addToOrderedList(filteredKeys[index]);
                          } else {
                            dataAdapter
                                .removeFromOrderedList(filteredKeys[index]);
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            SearchView(
              onSearch: _onChanged,
            )
          ],
        );
      },
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView(
      {Key? key, this.enableSearchOnTextChange = true, required this.onSearch})
      : super(key: key);

  final bool enableSearchOnTextChange;
  final Function(String) onSearch;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
          child: TextField(
            autofocus: true,
            controller: _controller,
            onSubmitted: widget.onSearch,
            onChanged: widget.enableSearchOnTextChange ? widget.onSearch : null,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  widget.onSearch(_controller.text);
                },
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.text = '';
                  widget.onSearch('');
                },
                icon: const Icon(
                  Icons.clear_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
