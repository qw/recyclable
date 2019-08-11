import 'labelled_item.dart';
import 'labels.dart';

class LabelledItems {
  LabelledItems._();

  // Remember:
  //  - things after two slashes // are comments
  //  - code is very strict, case-sensitive and need to be correct character to character
  // and a single equal sign = means to assign (similar to what you've learnt in maths)
  // each tagged item has a name that the computer understands, and an english name for us humans to understand (the one in quotes).
  // The english name should be the same as the label you used in Custom Vision when you labelled the images.
  // EXAMPLE ONE shows that the name can is for the computer, and 'aluminium can' is the name for humans
  // static const TaggedItem at the start... have them in your example, don't worry about what they mean.

  // EXAMPLE ONE
  static const LabelledItem can = LabelledItem( // writing the name can = ... is like writing x = 1 in maths class
      englishName: 'aluminium can', // things in single or double quotes are like english words/sentences
      labels: [Labels.metal, Labels.recyclable] // square brackets means a list of things
  );

  static const LabelledItem apple = LabelledItem(
      englishName: 'apple',
      labels: [Labels.compost, Labels.recyclable]
  );

  static const LabelledItem serviette = LabelledItem(
      englishName: 'serviette',
      labels: [Labels.non_recyclable]
  );

  static const LabelledItem milkBottle = LabelledItem(
      englishName: 'bottle',
      labels: [Labels.plastic, Labels.recyclable]
  );

  // Remember to add your new tagged item into this list also
  static const List<LabelledItem> all = [apple, can, serviette, milkBottle];
  // Your code ends here

  static LabelledItem lookFor(String name) {
    name = name.trim().toLowerCase();
    LabelledItem item;
    for (LabelledItem taggedItem in all) {
      if (taggedItem.englishName == name) {
        item = taggedItem;
        break;
      }
    }
    return item ?? LabelledItem();
  }
}
