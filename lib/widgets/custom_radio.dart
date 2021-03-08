import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

const double _kInnerRadius = 5.5;
const double _kOuterRadius = 10.5;

class CustomRadio<T> extends StatefulWidget {
  const CustomRadio({
    Key key,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
  }) : assert(autofocus != null),
        assert(toggleable != null),
        super(key: key);
  final Color inactiveColor;
  final Color backgroundColor;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final MouseCursor mouseCursor;
  final bool toggleable;
  final Color activeColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final VisualDensity visualDensity;
  final Color focusColor;
  final Color hoverColor;
  final FocusNode focusNode;
  final bool autofocus;

  @override
  _CustomRadioState<T> createState() => _CustomRadioState<T>();
}

class _CustomRadioState<T> extends State<CustomRadio<T>> with TickerProviderStateMixin {
  bool get enabled => widget.onChanged != null;
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: _actionHandler,
      ),
    };
  }

  void _actionHandler(ActivateIntent intent) {
    if (widget.onChanged != null) {
      widget.onChanged(widget.value);
    }
    final RenderObject renderObject = context.findRenderObject();
    renderObject.sendSemanticsEvent(const TapSemanticEvent());
  }

  bool _focused = false;
  void _handleHighlightChanged(bool focused) {
    if (_focused != focused) {
      setState(() { _focused = focused; });
    }
  }

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    if (_hovering != hovering) {
      setState(() { _hovering = hovering; });
    }
  }

  Color _getInactiveColor(ThemeData themeData) {
    return enabled ? themeData.unselectedWidgetColor : themeData.disabledColor;
  }

  void _handleChanged(bool selected) {
    if (selected == null) {
      widget.onChanged(null);
      return;
    }
    if (selected) {
      widget.onChanged(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    Size size;
    switch (widget.materialTapTargetSize ?? themeData.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        size = const Size(2 * kRadialReactionRadius + 8.0, 2 * kRadialReactionRadius + 8.0);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        size = const Size(2 * kRadialReactionRadius, 2 * kRadialReactionRadius);
        break;
    }
    size += (widget.visualDensity ?? themeData.visualDensity).baseSizeAdjustment;
    final BoxConstraints additionalConstraints = BoxConstraints.tight(size);
    final bool selected = widget.value == widget.groupValue;
    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!enabled) MaterialState.disabled,
        if (_hovering) MaterialState.hovered,
        if (_focused) MaterialState.focused,
        if (selected) MaterialState.selected,
      },
    );

    return FocusableActionDetector(
      actions: _actionMap,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      mouseCursor: effectiveMouseCursor,
      enabled: enabled,
      onShowFocusHighlight: _handleHighlightChanged,
      onShowHoverHighlight: _handleHoverChanged,
      child: Builder(
        builder: (BuildContext context) {
          return _RadioRenderObjectWidget(
            backgroundColor: widget.backgroundColor ?? Colors.white,
            selected: selected,
            activeColor: widget.activeColor ?? themeData.toggleableActiveColor,
            inactiveColor: widget.inactiveColor?? _getInactiveColor(themeData),
            focusColor: widget.focusColor ?? themeData.focusColor,
            hoverColor: widget.hoverColor ?? themeData.hoverColor,
            onChanged: enabled ? _handleChanged : null,
            toggleable: widget.toggleable,
            additionalConstraints: additionalConstraints,
            vsync: this,
            hasFocus: _focused,
            hovering: _hovering,
          );
        },
      ),
    );
  }
}

class _RadioRenderObjectWidget extends LeafRenderObjectWidget {
  const _RadioRenderObjectWidget({
    Key key,
    @required this.selected,
    @required this.activeColor,
    @required this.inactiveColor,
    @required this.focusColor,
    @required this.hoverColor,
    @required this.backgroundColor,
    @required this.additionalConstraints,
    this.onChanged,
    @required this.toggleable,
    @required this.vsync,
    @required this.hasFocus,
    @required this.hovering,
  }) : assert(selected != null),
        assert(activeColor != null),
        assert(inactiveColor != null),
        assert(vsync != null),
        assert(toggleable != null),
        super(key: key);

  final bool selected;
  final bool hasFocus;
  final bool hovering;
  final Color inactiveColor;
  final Color activeColor;
  final Color focusColor;
  final Color backgroundColor;
  final Color hoverColor;
  final ValueChanged<bool> onChanged;
  final bool toggleable;
  final TickerProvider vsync;
  final BoxConstraints additionalConstraints;

  @override
  _RenderRadio createRenderObject(BuildContext context) => _RenderRadio(
    value: selected,
    activeColor: activeColor,
    inactiveColor: inactiveColor,
    backgroundColor: backgroundColor,
    focusColor: focusColor,
    hoverColor: hoverColor,
    onChanged: onChanged,
    tristate: toggleable,
    vsync: vsync,
    additionalConstraints: additionalConstraints,
    hasFocus: hasFocus,
    hovering: hovering,
  );

  @override
  void updateRenderObject(BuildContext context, _RenderRadio renderObject) {
    renderObject
      ..value = selected
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor
      ..focusColor = focusColor
      ..hoverColor = hoverColor
      ..onChanged = onChanged
      ..tristate = toggleable
      ..additionalConstraints = additionalConstraints
      ..vsync = vsync
      ..hasFocus = hasFocus
      ..hovering = hovering;
  }
}

class _RenderRadio extends RenderToggleable {
  _RenderRadio({
    bool value,
    Color activeColor,
    Color inactiveColor,
    Color focusColor,
    this.backgroundColor,
    Color hoverColor,
    ValueChanged<bool> onChanged,
    bool tristate,
    BoxConstraints additionalConstraints,
    @required TickerProvider vsync,
    bool hasFocus,
    bool hovering,
  }) : super(
    value: value,
    activeColor: activeColor,
    inactiveColor: inactiveColor,
    focusColor: focusColor,
    hoverColor: hoverColor,
    onChanged: onChanged,
    tristate: tristate,
    additionalConstraints: additionalConstraints,
    vsync: vsync,
    hasFocus: hasFocus,
    hovering: hovering,
  );
  final Color backgroundColor;
  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    paintRadialReaction(canvas, offset, size.center(Offset.zero));
    final Offset center = (offset & size).center;
    final Color radioColor = onChanged != null ? activeColor : inactiveColor;
    // Outer circle
    final Paint paint = Paint()
      ..color = Color.lerp(inactiveColor, radioColor, position.value)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, _kOuterRadius, paint);

    // Inner circle
    if (!position.isDismissed) {
      paint.style = PaintingStyle.fill;
      paint.color = activeColor;
      canvas.drawCircle(center, _kOuterRadius * position.value, paint);
      paint.style = PaintingStyle.fill;
      paint.color = backgroundColor;
      canvas.drawCircle(center, _kInnerRadius * position.value, paint);

    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isInMutuallyExclusiveGroup = true
      ..isChecked = value == true;
  }
}