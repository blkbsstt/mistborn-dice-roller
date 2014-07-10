import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_icon_button.dart';
import 'package:core_elements/core_icon.dart';
import 'dart:html';
import 'dart:math';
import "package:range/range.dart";

/**
 * A Polymer click counter element.
 */
@CustomTag('mistborn-dice-roller')
class MistbornDiceRoller extends PolymerElement with ChangeNotifier  {
  static const int minDice = 2;
  @reflectable @published int get dice => __$dice; int __$dice = minDice; @reflectable set dice(int value) { __$dice = notifyPropertyChange(#dice, __$dice, value); }
  PaperIconButton dec;
  HtmlElement result_text;
  HtmlElement result_icons;

  MistbornDiceRoller.created() : super.created() {
    dec = shadowRoot.querySelector("#dec") as PaperIconButton;
    result_text = shadowRoot.querySelector("#result_text") as HtmlElement;
    result_icons = shadowRoot.querySelector("#result_icons") as HtmlElement;
    if (dice < minDice) dice = 2;
    set_button_state();
  }

  void increment() {
    dice++;
    set_button_state();
  }
  
  void decrement() {
    if (dice > minDice) dice--;
    set_button_state();
  }
  
  void roll() {
    clear_results();
    MistbornDicePool pool = new MistbornDicePool(dice);
    pool.roll();
    set_result_text(pool);
    set_result_icons(pool);
  }
  
  void set_button_state() {
    dec.disabled = dice == minDice;
  }
  
  void clear_results() {
    result_text.nodes.clear();
    result_icons.nodes.clear();
  }
  
  void set_result_text(MistbornDicePool pool) {
    result_text.append(new ParagraphElement()..text = "You rolled ${pool.result()}");
  }
  
  void set_result_icons(MistbornDicePool pool) {
    List<CoreIcon> icons = [];
    for (int i in pool.last_roll) {
      icons.add(D6.getIcon(i));
    }
    for(CoreIcon icon in icons) {
      result_icons.append(icon);
    }
  }
}

class Die {
  static final Random rand = new Random();
  int sides;
  Die(this.sides);
  int roll() => rand.nextInt(sides) + 1;
}

class D6 extends Die {
  D6() : super(6);
  static CoreIcon getIcon(int i) => new Element.tag('core-icon') as CoreIcon..icon="dice:die_$i"..size="48"..classes.add('dice-icon');
}

class DicePool {
  List<Die> dice = [];
  List<int> last_roll = [];
  DicePool(int size, {int sides: 6}) {
    for (int i in range(size)) dice.add(new Die(sides));
  }
  
  void addDie(Die d) => dice.add(d);
  List<int> roll() => last_roll = dice.map((Die d) => d.roll()).toList();
}

class MistbornDicePool extends DicePool {
  int nudges;
  MistbornDicePool(int size) : nudges = size - min(10, size), super(min(10, size));
  
  RollResult result() {
    Map<int, int> freq = count(last_roll)..putIfAbsent(6, () => 0);
    int high = last_roll.where((roll) => roll < 6 && freq[roll] >= 2).fold(0, max);
    return new RollResult(high, freq[6] + nudges);
  }
}

class RollResult {
  int high_value;
  int nudges;
  RollResult(this.high_value, this.nudges);
  
  String toString() => "${high_value == 0 ? 'nothing' : high_value} with ${nudges == 0 ? 'no' : nudges} ${nudges == 1 ? 'nudge' : 'nudges'}";
}

Map<dynamic, int> count(Iterable<dynamic> it) {
  return it.fold(new Map<dynamic,  int>(), (Map<dynamic, int> map, i) {map.putIfAbsent(i, () => 0); map[i] += 1; return map;});
}

