library breathing_background;

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

/// A breathing background widget.
///
/// Use this widget in a [Stack] as background.
///
/// Users should experiment with different colors to get their intended effect.
///
/// For example, a light breathing effect:
///
/// ```
/// initialMainColor = Color(0xFFDAD9E7);
/// transformedMainColor = Color(0xFFB1B1BD);
/// initialSecondaryColor = Color(0xFFB1B1BD);
/// transformedSecondaryColor = Colors.white;
/// ```
///
class BreathingBackground extends StatelessWidget {
  /// The initial color that starts from [begin].
  final Color? initialMainColor;

  /// The color which [initialMainColor] will be transformed to.
  final Color? transformedMainColor;

  /// The initial color that starts from [end].
  final Color? initialSecondaryColor;

  /// The color which [initialSecondaryColor] will be transformed to.
  final Color? transformedSecondaryColor;

  /// The begin position of the animation.
  final Alignment? begin;

  /// The end postion of the animation.
  final Alignment? end;

  /// The duration for the animation to complete.
  final Duration? duration;

  BreathingBackground({
    this.initialMainColor,
    this.transformedMainColor,
    this.initialSecondaryColor,
    this.transformedSecondaryColor,
    this.begin,
    this.end,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final Color _initialMainColor = initialMainColor ?? Color(0xFFDAD9E7);
    final Color _transformedMainColor =
        transformedMainColor ?? Color(0xFFB1B1BD);
    final Color _initialSecondaryColor =
        initialSecondaryColor ?? Color(0xFFB1B1BD);
    final Color _transformedSecondaryColor =
        transformedSecondaryColor ?? Colors.white;
    final Alignment _begin = begin ?? Alignment.topCenter;
    final Alignment _end = end ?? Alignment.bottomCenter;
    final Duration _duration = duration ?? Duration(seconds: 3);

    // background color animations
    final tween = MultiTween<_BgProps>()
      ..add(_BgProps.color1, _initialMainColor.tweenTo(_transformedMainColor))
      ..add(_BgProps.color2,
          _initialSecondaryColor.tweenTo(_transformedSecondaryColor));

    return MirrorAnimation<MultiTweenValues<_BgProps>>(
      tween: tween,
      duration: _duration,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: _begin,
              end: _end,
              colors: [
                value.get(_BgProps.color1),
                value.get(_BgProps.color2),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum _BgProps {
  color1,
  color2,
}
