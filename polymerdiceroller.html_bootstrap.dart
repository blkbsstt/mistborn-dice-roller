library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_meta.dart' as i0;
import 'package:core_elements/core_iconset.dart' as i1;
import 'package:core_elements/core_icon.dart' as i2;
import 'package:paper_elements/paper_focusable.dart' as i3;
import 'package:paper_elements/paper_ripple.dart' as i4;
import 'package:paper_elements/paper_shadow.dart' as i5;
import 'package:paper_elements/paper_button.dart' as i6;
import 'package:paper_elements/paper_icon_button.dart' as i7;
import 'package:paper_elements/paper_fab.dart' as i8;
import 'package:core_elements/core_icons.dart' as i9;
import 'package:core_elements/core_iconset_svg.dart' as i10;
import 'mistborn_dice_roller.dart' as i11;
import 'polymerdiceroller.html.0.dart' as i12;
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'mistborn_dice_roller.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:observe/src/metadata.dart' as smoke_2;
abstract class _M0 {} // PolymerElement & ChangeNotifier

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #blurAction: (o) => o.blurAction,
        #contextMenuAction: (o) => o.contextMenuAction,
        #decrement: (o) => o.decrement,
        #dice: (o) => o.dice,
        #focusAction: (o) => o.focusAction,
        #icon: (o) => o.icon,
        #iconSrc: (o) => o.iconSrc,
        #increment: (o) => o.increment,
        #label: (o) => o.label,
        #raisedButton: (o) => o.raisedButton,
        #roll: (o) => o.roll,
        #z: (o) => o.z,
      },
      setters: {
        #dice: (o, v) { o.dice = v; },
        #icon: (o, v) { o.icon = v; },
        #iconSrc: (o, v) { o.iconSrc = v; },
        #z: (o, v) { o.z = v; },
      },
      parents: {
        smoke_0.MistbornDiceRoller: _M0,
        _M0: smoke_1.PolymerElement,
      },
      declarations: {
        smoke_0.MistbornDiceRoller: {
          #dice: const Declaration(#dice, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
      },
      names: {
        #blurAction: r'blurAction',
        #contextMenuAction: r'contextMenuAction',
        #decrement: r'decrement',
        #dice: r'dice',
        #focusAction: r'focusAction',
        #icon: r'icon',
        #iconSrc: r'iconSrc',
        #increment: r'increment',
        #label: r'label',
        #raisedButton: r'raisedButton',
        #roll: r'roll',
        #z: r'z',
      }));
  configureForDeployment([
      i0.upgradeCoreMeta,
      i1.upgradeCoreIconset,
      i2.upgradeCoreIcon,
      i3.upgradePaperFocusable,
      i4.upgradePaperRipple,
      i5.upgradePaperShadow,
      i6.upgradePaperButton,
      i7.upgradePaperIconButton,
      i8.upgradePaperFab,
      i10.upgradeCoreIconsetSvg,
      () => Polymer.register('mistborn-dice-roller', i11.MistbornDiceRoller),
    ]);
  i12.main();
}
