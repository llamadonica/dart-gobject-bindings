import 'gtk.dart' hide main;
import 'gtk.dart' as gtk;
import 'cairo.dart';

main(List<String> args) {
  gtk.initLibrary();
  var x = new ImageSurface(Format.ARGB32, 400, 400);
  var y = new Context(x);

  init(args);
  var window = new Window(WindowType.TOPLEVEL);
  window.onDeleteEvent.listen((WidgetDeleteEventEvent event) {
    print("Delete event ocurred.");
  });
  window.onDestroy.listen((_) {
    mainQuit();
  });
  window.borderWidth = 10;
  var button = new Button.withLabel("Hello world");
  button.onClicked.first.then((_) {
    print("Hello world.");
  });
  button.xalign = 0.0;
  window.add(button);
  window.showAll();

  gtk.main();
}
