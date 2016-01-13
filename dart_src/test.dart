import 'gtk.dart' hide main;
import 'gtk.dart' as gtk;

main(List<String> args) {
  gtk.initLibrary();
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
  button.onClicked.listen((_) {
    print("Hello world.");
  });
  window.add(button);
  window.showAll();
  gtk.main();
}
