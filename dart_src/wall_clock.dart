// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library gjs_integration.test;

import 'dart:async';
import 'dart:js';
import 'dart:math';

import 'gdart.dart';
import 'cairo.dart';
import 'gdk.dart' hide Window, WindowType;
import 'gdk.dart' as gdk show Window;
import 'rsvg.dart';
import 'gtk.dart' hide main, init;
import 'gtk.dart' as gtk show main, init;

class ClockApp {
  ClockApp() ;
  ClockFace _face;

  activate() {
    _face = new ClockFace(160, this);
    _face.present();
    new Future(scheduleRedraws);
  }

  scheduleRedraws() {
    new Timer.periodic(new Duration(milliseconds: 250), _face.scheduleRedraw);
  }
}

class ClockFace {
  final int width;
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
      ..scale(scale / 2, scale / 2)
      ..setOperator(Operator.OVER);
    svg.render(context);
    context.restore();
  }

  ClockFace(int width, this._app) : width = width {
    var circleMap = new ImageSurface(Format.A1, width, width);
    var drawingContext = new Context(circleMap);
    drawingContext.arc(width / 2, width / 2, width / 2, 0.0, 2 * PI);
    drawingContext.fill();
    var pixbuf = Pixbuf.getFromSurface(circleMap, 0, 0, width, width);
    drawingArea = new DrawingArea()
      ..widthRequest = width
      ..heightRequest = width
      ..visible = true
      ..canFocus = false
      ..events = EventMask.STRUCTURE_MASK.value
      ..halign = Align.START
      ..onDraw.listen(redrawSurface);
    window = new Window(WindowType.TOPLEVEL)
      ..gravity = Gravity.SOUTH_EAST
      ..defaultHeight = width
      ..defaultHeight = width
      ..opacity = 1.0
      ..decorated = false
      ..title = "wallclock"
      ..acceptFocus = true
      ..skipPagerHint = true
      ..skipTaskbarHint = true
      ..role = "clock"
      ..appPaintable = true
      ..stick()
      ..setKeepAbove(true)
      ..setGeometryHints(
          null,
          new Geometry(
              minHeight: 100,
              minWidth: 100,
              maxWidth: 200,
              maxHeight: 200,
              minAspect: 1.0,
              maxAspect: 1.0),
          WindowHints.MAX_SIZE | WindowHints.MIN_SIZE | WindowHints.ASPECT)
      ..add(drawingArea);
    //..onDestroy.listen((_) => destroy());
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
    //_app.quitMainloop();
  }

  void realizeWindow() {
    //TODO(astark) this should have an inputCombineMask, but it uses a rectangle system, so it's
    //not quite the same as before.
  }

  void configureEvent(EventConfigure event) {
    //TODO(astark) On a resize event, this should reload the image from the file.
    var gdkWindow = event.window;
  }

  void redrawSurface(DrawEvent event) {
    gjsPrint('Redrawing');
    final context = event.cr;
    context
      ..save()
      ..setOperator(Operator.SOURCE)
      ..setSourceRGBA(0, 0, 0, 0)
      ..setSourceSurface(imageSurface, 0, 0)
      ..paint()
      ..restore();
    redrawHands(context, width);
    event.stopPropagation();
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
      ..setSourceRGB(0, 0, 0)
      ..moveTo(-0.057, 0.0115)
      ..lineTo(-0.057, -0.0115)
      ..lineTo(0.2275, -0.00725)
      ..lineTo(0.2275, 0.00725)
      ..fill()
      ..restore()
    //Draw the minutes
      ..save()
      ..rotate(seconds * PI / 1800 + minutes * PI / 30 - PI / 2)
      ..setSourceRGB(0, 0, 0)
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
      ..setSourceRGB(0.83, 0, 0)
      ..moveTo(-0.075, 0.0)
      ..lineTo(0.415, 0.0)
      ..setLineWidth(0.0075)
      ..setLineCap(LineCap.ROUND)
      ..stroke()
      ..restore()
      ..restore();
  }

  void scheduleRedraw(Timer timer) {
    if (drawingArea.visible) {
      drawingArea.queueDraw();
    }
  }
}

void main(List args) {
  gtk.init();
  var app = new ClockApp();
  app.activate();
  gtk.main();