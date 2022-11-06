import 'package:common/search_view.dart';
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

  bool containsInitialConsonant(String string, String query) {
    /*
      Hangul UTF16 structure :
      ① Hangul characters start from 44032(== '가').
      ② A group of same initial consonant has 588 characters.
      ③ Initial consonants are 19ea,
        such as 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
      ④ Hangul initial consonant characters start from 12593 to 12622
        'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ', 
    */
    const codeOfFirstHangulLetter = 44032;
    const numberOfSameInitialConsonant = 588;
    final initialConsonants = [
      'ㄱ',
      'ㄲ',
      'ㄴ',
      'ㄷ',
      'ㄸ',
      'ㄹ',
      'ㅁ',
      'ㅂ',
      'ㅃ',
      'ㅅ',
      'ㅆ',
      'ㅇ',
      'ㅈ',
      'ㅉ',
      'ㅊ',
      'ㅋ',
      'ㅌ',
      'ㅍ',
      'ㅎ'
    ];

    if (string.length < query.length) return false;

    if (query.isEmpty) return true;

    for (int i = 0; i < string.length - query.length + 1; i++) {
      bool contains = true;
      for (int j = 0; j < query.length; j++) {
        if (initialConsonants.contains(query.substring(j, j + 1))) {
          if ((string.substring(i + j, i + j + 1).codeUnitAt(0) -
                      codeOfFirstHangulLetter) ~/
                  numberOfSameInitialConsonant !=
              initialConsonants.indexOf(query.substring(j, j + 1))) {
            contains = false;
            break;
          }
        } else {
          if (query.substring(j, j + 1) != string.substring(i + j, i + j + 1)) {
            contains = false;
            break;
          }
        }
      }
      if (contains) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataAdapter>(
      builder: (context, dataAdapter, child) {
        List<String> currencyKeys = dataAdapter.currencies.keys.toList();
        List<String> filteredKeys = List.from(currencyKeys
            .where(
              (element) => containsInitialConsonant(
                  dataAdapter.currencies[element]!.toLowerCase(),
                  _query.toLowerCase()),
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
