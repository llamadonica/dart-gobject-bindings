// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library gjs_integration.test;

import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'gdart.dart';
import 'cairo.dart';
import 'gdk.dart' hide Window, WindowType;
import 'gdk.dart' as gdk show Window;
import 'rsvg.dart' hide initLibrary;
import 'rsvg.dart' as rsvg show initLibrary;
import 'gtk.dart' hide main, init, initLibrary;
import 'gtk.dart' as gtk show main, init, initLibrary;
import 'glib.dart' hide main, init, initLibrary;
import 'glib.dart' as glib show main, init, initLibrary;

class ClockApp {
  ClockApp() ;
  ClockFace _face;

  activate() {
    _face = new ClockFace(160, this);
    _face.present();
    new Future(scheduleRedraws);
  }

  scheduleRedraws() {
    new Timer.periodic(new Duration(milliseconds: 250), (_) => _face.scheduleRedraw());
  }
}

class ClockFace {
  int width;
  ClockApp _app;
  Window window;
  DrawingArea drawingArea;

  ImageSurface _imageSurface;
  ImageSurface get imageSurface {
    if (_imageSurface == null) {
      loadImageSurface();
    }
    return _imageSurface;
  }

  void loadImageSurface() {
    _imageSurface = new ImageSurface(Format.ARGB32, width, width);
    var context = new Context(_imageSurface);
    loadClockFace(context, width);
  }

  void loadClockFace(Context context, int targetWidth) {
    print('Loading clock face.');
    var svg = new Handle.fromFile('clock-bg.svg');
    final width = svg.width;
    final height = svg.height;
    final scale = min(width, height).toDouble() / targetWidth.toDouble();
    context
      ..save()
      ..scale(1 / scale, 1 / scale)
      ..operator = Operator.OVER;
    svg.renderCairo(context);
    context.restore();
  }

  ClockFace(int width_, this._app) : width = width_ {
    var geo = new Geometry();
    var circleMap = new ImageSurface(Format.A1, width_, width_);
    var drawingContext = new Context(circleMap);
    drawingContext.arc(width_ / 2, width_ / 2, width_ / 2, 0.0, 2 * PI);
    drawingContext.fill();
    var pixbuf = pixbufGetFromSurface(circleMap, 0, 0, width_, width_);
    drawingArea = new DrawingArea()
      ..widthRequest = width_
      ..heightRequest = width_
      ..visible = true
      ..canFocus = false
      ..events = EventMask.STRUCTURE_MASK
      ..onDraw.listen(redrawSurface)
      ..onConfigureEvent.listen((WidgetConfigureEventEvent event) {
        var width_ = event.event.width;
        var height_ = event.event.height;
        width = min(width_, height_);
        loadImageSurface();
        scheduleRedraw();
      });
    window = new Window(WindowType.TOPLEVEL)
      ..gravity = Gravity.SOUTH_EAST
      ..defaultHeight = width_
      ..defaultHeight = width_
      ..opacity = 1.0
      ..decorated = false
      ..title = "wallclock"
      ..acceptFocus = true
      //..skipPagerHint = true
      //..skipTaskbarHint = true
      ..role = "clock"
      ..appPaintable = true
      ..stick()
      ..setKeepAbove(true)
/*      ..setGeometryHints(
          null,
          new Geometry(
              minHeight: 100,
              minWidth: 100,
              maxWidth: 200,
              maxHeight: 200,
              minAspect: 1.0,
              maxAspect: 1.0),
          WindowHints.MAX_SIZE | WindowHints.MIN_SIZE | WindowHints.ASPECT)
*/
      ..add(drawingArea)
/*      ..onConfigureEvent.listen((event) {
        event.event.height.
      })
*/
      ..onDestroy.listen((_) => destroy());
    var windowVisual = window.screen.rgbaVisual;
    if (windowVisual == null) {
      windowVisual = window.screen.systemVisual;
    }
    window.setVisual(windowVisual);
    bool shapesOkay = window.getDisplay().supportsShapes();
  }

  void present() {
    window.showAll();
    window.present();
    print('Presenting');
  }

  void destroy() {
    glibMainQuit();
  }

  void realizeWindow() {
    //TODO(astark) this should have an inputCombineMask, but it uses a rectangle system, so it's
    //not quite the same as before.
  }

  void configureEvent(EventConfigure event) {
    //TODO(astark) On a resize event, this should reload the image from the file.
    var gdkWindow = event.window;
  }

  void redrawSurface(WidgetDrawEvent event) {
    final context = event.cr;
    context
      ..save()
      ..operator = (Operator.SOURCE)
      ..setSourceRgba(0.0,  0.0, 0.0, 0.0)
      ..setSourceSurface(imageSurface, 0.0, 0.0)
      ..paint()
      ..restore();
    redrawHands(context, width);
    event.cancelPropagation();
  }

  void redrawHands(Context context, int width) {
    final scale = width.toDouble();
    var currentTime = new DateTime.now();
    final seconds = currentTime.second.toDouble();
    final minutes = currentTime.minute.toDouble();
    final hours = currentTime.hour.toDouble();
    context
      ..save()
      ..scale(scale, scale)
      ..translate(0.52, 0.52)
      ..scale(0.9, 0.9)
    //Draw the hours
      ..save()
      ..rotate(
          seconds * PI / 21600 + minutes * PI / 360 + hours * PI / 6 - PI / 2)
      ..setSourceRgb(0.0, 0.0, 0.0)
      ..moveTo(-0.057, 0.0115)
      ..lineTo(-0.057, -0.0115)
      ..lineTo(0.2275, -0.00725)
      ..lineTo(0.2275, 0.00725)
      ..fill()
      ..restore()
    //Draw the minutes
      ..save()
      ..rotate(seconds * PI / 1800 + minutes * PI / 30 - PI / 2)
      ..setSourceRgb(0.0, 0.0, 0.0)
      ..moveTo(-0.065, 0.00833)
      ..lineTo(-0.065, -0.00833)
      ..lineTo(0.3265, -0.00433)
      ..lineTo(0.3265, 0.00433)
      ..fill()
      ..restore()
    //Draw the seconds
      ..save();
    context
      ..rotate(seconds * PI / 30 - PI / 2)
      ..setSourceRgb(0.83, 0.0, 0.0)
      ..moveTo(-0.075, 0.0)
      ..lineTo(0.415, 0.0)
      ..lineWidth = (0.0075)
      ..lineCap = (LineCap.ROUND)
      ..stroke()
      ..restore()
      ..restore();
  }

  void scheduleRedraw() {
    if (drawingArea.visible) {
      drawingArea.queueDraw();
    }
  }


}

void main(List args) {
  gtk.initLibrary();
  rsvg.initLibrary();
  gtk.init(args);
  var app = new ClockApp();

  app.activate();
  glibMainLoop().then((_) {
    exit(0);
  });

}

bool _glibMainLoopHasQuit = false;

Future glibMainLoop() async {
  var context = MainContext.default_();
  var controller = new StreamController();
  new Timer.periodic(new Duration(milliseconds: 50), (_) => controller.add(null));
  await for (var _ in controller.stream) {
    if (_glibMainLoopHasQuit) return;
    context.iteration(false);
  }
}

glibMainQuit() {
  _glibMainLoopHasQuit = true;
}