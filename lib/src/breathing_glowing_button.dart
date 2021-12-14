library breathing_glowing_button;

import 'package:flutter/material.dart';

/// A Breathing Glowing Button widget.
///
/// If properties are not given, default value is used.
class BreathingGlowingButton extends StatefulWidget {
  /// Width of the button.
  ///
  /// Default value: 60.0.
  final double? width;

  /// Height of the button.
  ///
  /// Default value: 60.0.
  final double? height;

  /// The color for button background.
  ///
  /// Default value: Color(0xFF373A49).
  final Color? buttonBackgroundColor;

  /// The color of the breathing glow animation.
  ///
  /// Default value: Color(0xFF777AF9).
  final Color? glowColor;

  /// Icon inside the button.
  ///
  /// Default value: Icons.mic.
  final IconData? icon;

  /// The color of the icon.
  ///
  /// Default [iconColor] value: Colors.white.
  final Color? iconColor;

  /// Function to be executed onTap.
  ///
  /// Default [onTap] value: null
  final Function? onTap;

  BreathingGlowingButton({
    this.width,
    this.height,
    this.buttonBackgroundColor,
    this.glowColor,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  _BreathingGlowingButtonState createState() => _BreathingGlowingButtonState();
}

class _BreathingGlowingButtonState extends State<BreathingGlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    tenet();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  /// Core animation control is done here.
  /// Animation completes in 2 seconds then repeat by reversing.
  void tenet() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 10.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final double _width = widget.width ?? 60;
    final double _height = widget.height ?? 60;
    final Color _buttonBackgroundColor =
        widget.buttonBackgroundColor ?? Color(0xFF373A49);
    final Color _glowColor = widget.glowColor ?? Color(0xFF777AF9);
    final IconData _icon = widget.icon ?? Icons.mic;
    final Color _iconColor = widget.iconColor ?? Colors.white;
    final Function _onTap = widget.onTap ?? () {};

    /// A simple breathing glowing button.
    /// Built using [Container] and [InkWell].
    return InkWell(
      child: Container(
        width: _width,
        height: _height,
        child: Icon(
          _icon,
          color: _iconColor,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _buttonBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: _glowColor,
              blurRadius: _animation.value,
              spreadRadius: _animation.value,
            ),
          ],
        ),
      ),
      onTap: () => _onTap,
    );
  }
}
