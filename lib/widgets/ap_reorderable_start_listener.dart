import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class APReorderableDragStartListener extends ReorderableDragStartListener {
  const APReorderableDragStartListener({
    required super.child,
    required super.index,
    super.key,
    super.enabled,
  }) : super();

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(
      debugOwner: this,
      delay: Duration.zero,
    );
  }
}
