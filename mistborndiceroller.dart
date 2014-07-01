import 'dart:html';
import 'dart:math';
import "package:range/range.dart";

void main() {
  print(getPoolSize());
  querySelector('#roll').onClick.listen(rollDie);
}

int getPoolSize() => (querySelector('#poolSize') as NumberInputElement).valueAsNumber.toInt();

void rollDie(Event e) {
  var button = e.target as ButtonElement;
  var pool = new MistbornDicePool(getPoolSize());
  pool.roll();
  print(pool.last_roll);
  var result = pool.result();
  print(result.high_value);
  print(result.nudges);
  Element result_comp = querySelector('#dice_result');
  result_comp.nodes.clear();
  List<ImageElement> images = [];
  for(int i in pool.last_roll) {
    images.add(new ImageElement()..src = D6.imageMap[i]);
  }
  for(ImageElement img in images) {
    result_comp.append(img);
  }
  Element text = querySelector('#result_text');
  text.nodes.clear();
  text.nodes.add(new ParagraphElement()..text = "You rolled $result.");
}

class Die {
  static final Random rand = new Random();
  int sides;
  Die(this.sides);
  int roll() => rand.nextInt(sides) + 1;
}

class D6 extends Die {
  D6() : super(6);
  
  static final Map<int, String> imageMap = {
    1: "http://upload.wikimedia.org/wikipedia/commons/c/c5/Dice-1.png",
    2: "http://upload.wikimedia.org/wikipedia/commons/1/18/Dice-2.png",
    3: "http://upload.wikimedia.org/wikipedia/commons/7/70/Dice-3.png",
    4: "http://upload.wikimedia.org/wikipedia/commons/a/a9/Dice-4.png",
    5: "http://upload.wikimedia.org/wikipedia/commons/6/6c/Dice-5.png",
    6: "http://upload.wikimedia.org/wikipedia/commons/5/5c/Dice-6.png"
  };
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