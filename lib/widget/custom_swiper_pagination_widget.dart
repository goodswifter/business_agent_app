import 'package:flutter/material.dart';

enum PageIndicatorLayout {
  NONE,
  SLIDE,
  WARM,
  COLOR,
  SCALE,
  DROP,
  LINE, // 添加的横线类型
  NIO,
}

class NioPainter extends NioBasePainter {
  NioPainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double secondOffset = index == widget.count - 1
        ? radius
        : radius + ((index + 1) * (size + space));
    _paint.color = widget.activeColor; //styles.ComponentStyle.APP_MAIN_COLOR;
    _paint.strokeWidth = 3;
    //只修改这里就可以满足效果
    canvas.drawLine(Offset(secondOffset - 8, radius),
        Offset(secondOffset + 8, radius), _paint);
  }
}

abstract class NioBasePainter extends BasePainter {
  NioBasePainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = widget.color;
    double space = widget.space;
    double size = widget.size;
    double radius = size / 2;
    for (int i = 0, c = widget.count; i < c; ++i) {
      if (_shouldSkip(i)) {
        continue;
      }
      //8只是一种横线多宽自己算吧，反正就是一个不同x坐标同y坐标的一条直线
      canvas.drawLine(Offset(i * (size + space) + radius - 8, radius),
          Offset(i * (size + space) + radius + 8, radius), _paint);
    }

    double page = this.page;
    if (page < index) {
      page = 0.0;
    }
    _paint.color = widget.activeColor;
    draw(canvas, space, size, radius);
  }
}

class LinePainter extends LineBasePainter {
  LinePainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    // double secondOffset = index == widget.count - 1
    //     ? radius
    //     : radius + ((index + 1) * (size + space));

    //lixiao add fix 进度相反的问题
    double secondOffset = index == widget.count - 1
        ? radius + ((index) * (size + space))
        : radius;
    //end by lixiao

    _paint.color = widget.activeColor; //AppColors.app_main;
    _paint.strokeWidth = 3;
    canvas.drawLine(Offset(secondOffset - 8, radius),
        Offset(secondOffset + 8, radius), _paint);
  }
}

abstract class LineBasePainter extends BasePainter {
  final PageIndicator widget;
  final double page;
  final int index;
  final Paint _paint;

  double lerp(double begin, double end, double progress) {
    return begin + (end - begin) * progress;
  }

  LineBasePainter(this.widget, this.page, this.index, this._paint)
      : super(widget, page, index, _paint);

  void draw(Canvas canvas, double space, double size, double radius);

  bool _shouldSkip(int index) {
    return false;
  }
  //double secondOffset = index == widget.count-1 ? radius : radius + ((index + 1) * (size + space));

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = widget.color;
    double space = widget.space;
    double size = widget.size;
    double radius = size / 2;
    for (int i = 0, c = widget.count; i < c; ++i) {
      if (_shouldSkip(i)) {
        continue;
      }
      // 这里的4指不是当前index的宽度，8是当前index的宽度，效果请看下面效果图
      canvas.drawLine(Offset(i * (size + space) + radius - 4, radius),
          Offset(i * (size + space) + radius + 8, radius), _paint);
    }

    double page = this.page;
    if (page < index) {
      page = 0.0;
    }
    _paint.color = widget.activeColor;
    draw(canvas, space, size, radius);
  }

  @override
  bool shouldRepaint(BasePainter oldDelegate) {
    return oldDelegate.page != page;
  }
}

class WarmPainter extends BasePainter {
  WarmPainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  void draw(Canvas canvas, double space, double size, double radius) {
    double progress = page - index;
    double distance = size + space;
    double start = index * (size + space);

    if (progress > 0.5) {
      double right = start + size + distance;
      //progress=>0.5-1.0
      //left:0.0=>distance

      double left = index * distance + distance * (progress - 0.5) * 2;
      canvas.drawRRect(
          RRect.fromLTRBR(left, 0.0, right, size, Radius.circular(radius)),
          _paint);
    } else {
      double right = start + size + distance * progress * 2;

      canvas.drawRRect(
          RRect.fromLTRBR(start, 0.0, right, size, Radius.circular(radius)),
          _paint);
    }
  }
}

class DropPainter extends BasePainter {
  DropPainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double progress = page - index;
    double dropHeight = widget.dropHeight;
    double rate = (0.5 - progress).abs() * 2;
    double scale = widget.scale;

    //lerp(begin, end, progress)

    canvas.drawCircle(
        Offset(radius + ((page) * (size + space)),
            radius - dropHeight * (1 - rate)),
        radius * (scale + rate * (1.0 - scale)),
        _paint);
  }
}

class NonePainter extends BasePainter {
  NonePainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double progress = page - index;
    double secondOffset = index == widget.count - 1
        ? radius
        : radius + ((index + 1) * (size + space));

    if (progress > 0.5) {
      canvas.drawCircle(Offset(secondOffset, radius), radius, _paint);
    } else {
      canvas.drawCircle(
          Offset(radius + (index * (size + space)), radius), radius, _paint);
    }
  }
}

class SlidePainter extends BasePainter {
  SlidePainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    canvas.drawCircle(
        Offset(radius + (page * (size + space)), radius), radius, _paint);
  }
}

class ScalePainter extends BasePainter {
  ScalePainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  // 连续的两个点，含有最后一个和第一个
  @override
  bool _shouldSkip(int i) {
    if (index == widget.count - 1) {
      return i == 0 || i == index;
    }
    return (i == index || i == index + 1);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = widget.color;
    double space = widget.space;
    double size = widget.size;
    double radius = size / 2;
    for (int i = 0, c = widget.count; i < c; ++i) {
      if (_shouldSkip(i)) {
        continue;
      }
      canvas.drawCircle(Offset(i * (size + space) + radius, radius),
          radius * widget.scale, _paint);
    }

    _paint.color = widget.activeColor;
    draw(canvas, space, size, radius);
  }

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double secondOffset = index == widget.count - 1
        ? radius
        : radius + ((index + 1) * (size + space));

    double progress = page - index;
    _paint.color = Color.lerp(widget.activeColor, widget.color, progress)!;
    //last
    canvas.drawCircle(Offset(radius + (index * (size + space)), radius),
        lerp(radius, radius * widget.scale, progress), _paint);
    //first
    _paint.color = Color.lerp(widget.color, widget.activeColor, progress)!;
    canvas.drawCircle(Offset(secondOffset, radius),
        lerp(radius * widget.scale, radius, progress), _paint);
  }
}

class ColorPainter extends BasePainter {
  ColorPainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  // 连续的两个点，含有最后一个和第一个
  @override
  bool _shouldSkip(int i) {
    if (index == widget.count - 1) {
      return i == 0 || i == index;
    }
    return (i == index || i == index + 1);
  }

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double progress = page - index;
    double secondOffset = index == widget.count - 1
        ? radius
        : radius + ((index + 1) * (size + space));

    _paint.color = Color.lerp(widget.activeColor, widget.color, progress)!;
    //left
    canvas.drawCircle(
        Offset(radius + (index * (size + space)), radius), radius, _paint);
    //right
    _paint.color = Color.lerp(widget.color, widget.activeColor, progress)!;
    canvas.drawCircle(Offset(secondOffset, radius), radius, _paint);
  }
}

abstract class BasePainter extends CustomPainter {
  final PageIndicator widget;
  final double page;
  final int index;
  final Paint _paint;

  double lerp(double begin, double end, double progress) {
    return begin + (end - begin) * progress;
  }

  BasePainter(this.widget, this.page, this.index, this._paint);

  void draw(Canvas canvas, double space, double size, double radius);

  bool _shouldSkip(int index) {
    return false;
  }
  //double secondOffset = index == widget.count-1 ? radius : radius + ((index + 1) * (size + space));

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = widget.color;
    double space = widget.space;
    double size = widget.size;
    double radius = size / 2;
    for (int i = 0, c = widget.count; i < c; ++i) {
      if (_shouldSkip(i)) {
        continue;
      }
      canvas.drawCircle(
          Offset(i * (size + space) + radius, radius), radius, _paint);
    }

    double page = this.page;
    if (page < index) {
      page = 0.0;
    }
    _paint.color = widget.activeColor;
    draw(canvas, space, size, radius);
  }

  @override
  bool shouldRepaint(BasePainter oldDelegate) {
    return oldDelegate.page != page;
  }
}

class _PageIndicatorState extends State<PageIndicator> {
  int index = 0;
  Paint _paint = Paint();

  BasePainter _createPainer() {
    switch (widget.layout) {
      case PageIndicatorLayout.NIO:
        //添加自己新加的枚举值多对应的动态指示器实现
        return NioPainter(widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.LINE:
        return LinePainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.NONE:
        return NonePainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.SLIDE:
        return SlidePainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.WARM:
        return WarmPainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.COLOR:
        return ColorPainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.SCALE:
        return ScalePainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.DROP:
        return DropPainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      default:
        throw Exception("Not a valid layout");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      width: widget.count * widget.size + (widget.count - 1) * widget.space,
      height: widget.size,
      child: CustomPaint(
        painter: _createPainer(),
      ),
    );

    if (widget.layout == PageIndicatorLayout.SCALE ||
        widget.layout == PageIndicatorLayout.COLOR) {
      child = ClipRect(
        child: child,
      );
    }

    return IgnorePointer(
      child: child,
    );
  }

  void _onController() {
    double page = widget.controller.page ?? 0.0;
    index = page.floor();

    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(_onController);
    super.initState();
  }

  @override
  void didUpdateWidget(PageIndicator oldWidget) {
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onController);
      widget.controller.addListener(_onController);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onController);
    super.dispose();
  }
}

// enum PageIndicatorLayout {
//   NONE,
//   SLIDE,
//   WARM,
//   COLOR,
//   SCALE,
//   DROP,
// }

class PageIndicator extends StatefulWidget {
  /// size of the dots
  final double size;

  /// space between dots.
  final double space;

  /// count of dots
  final int count;

  /// active color
  final Color activeColor;

  /// normal color
  final Color color;

  /// layout of the dots,default is [PageIndicatorLayout.SLIDE]
  final PageIndicatorLayout layout;

  // Only valid when layout==PageIndicatorLayout.scale
  final double scale;

  // Only valid when layout==PageIndicatorLayout.drop
  final double dropHeight;

  final PageController controller;

  final double activeSize;

  PageIndicator(
      {Key? key,
      this.size: 20.0,
      this.space: 5.0,
      required this.count,
      this.activeSize: 20.0,
      required this.controller,
      this.color: Colors.white30,
      this.layout: PageIndicatorLayout.SLIDE,
      this.activeColor: Colors.white,
      this.scale: 0.6,
      this.dropHeight: 20.0})
      : assert(count != null),
        assert(controller != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageIndicatorState();
  }
}
