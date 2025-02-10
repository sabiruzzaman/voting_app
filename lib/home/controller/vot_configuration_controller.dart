import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VotConfigurationController extends GetxController {
  final title = ''.obs;
  final options = <String>[].obs;
  final box = GetStorage();

  final newOptionController = TextEditingController();
  final titleController = TextEditingController();

  final titleError = ''.obs;
  final optionError = ''.obs;

  final selectionCounts = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadConfig();
  }

  void incrementSelection(String option) {
    if (selectionCounts.containsKey(option)) {
      selectionCounts[option] = selectionCounts[option]! + 1;
    } else {
      selectionCounts[option] = 1;
    }
  }

  void addOption() {
    if (newOptionController.text.length < 2) {
      optionError.value = 'Option must be at least 2 characters long';
    } else {
      optionError.value = '';
      options.add(newOptionController.text);
      newOptionController.clear();
    }
  }

  void updateTitle(String newTitle) {
    if (newTitle.length < 4) {
      titleError.value = 'Title must be at least 4 characters long';
    } else {
      titleError.value = '';
      title.value = newTitle;
      titleController.text = newTitle;
    }
  }

  void saveConfig() {
    if (title.value.length < 4) {
      titleError.value = 'Title must be at least 4 characters long';
      return;
    }

    if (options.any((option) => option.length < 2)) {
      optionError.value = 'All options must be at least 2 characters long';
      return;
    }

    box.write('title', title.value);
    box.write('options', options);
    box.write('selectionCounts', selectionCounts);
    Get.back();
  }

  void loadConfig() {
    title.value = box.read('title') ?? '';
    titleController.text = title.value;
    options.value = List<String>.from(box.read('options') ?? []);

    var storedCounts = box.read('selectionCounts');

    if (storedCounts is Map) {
      selectionCounts.value = Map<String, int>.from(storedCounts);
    } else {
      selectionCounts.value = {};
    }
  }

  // dressing order by votes and also show options with no votes
  List<MapEntry<String, int>> getSortedResults() {
    // all options and their vote count
    final Map<String, int> allOptionsWithVotes = {
      for (var option in options) option: selectionCounts[option] ?? 0
    };

    // dressing order by votes
    var sortedList = allOptionsWithVotes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedList;
  }

  // if there is a tie, return all options that have the highest votes
  List<String> getHighestVotedOptions() {
    var sortedResults = getSortedResults();
    if (sortedResults.isEmpty) return [];

    int highestVotes = sortedResults.first.value;
    // return all options that have the highest votes
    return sortedResults
        .where((entry) => entry.value == highestVotes)
        .map((entry) => entry.key)
        .toList();
  }

  int totalSelections() {
    int total = 0;
    selectionCounts.forEach((key, value) {
      total += value;
    });
    return total;
  }

  void resetConfig() {
    title.value = '';
    titleController.clear();
    options.clear();
    selectionCounts.clear();

    box.write('title', title.value);
    box.write('options', options);
    box.write('selectionCounts', selectionCounts);
  }
}
