library cairo.gdart;

import "gdart.dart";
import "introspection_compat_classes.dart";
import "girepository.dart" as girepository;

String _cairoLib = "/usr/lib64/libcairo.so.2";

class Context extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('cairo', 'Context');

  static FunctionInfo _cairoCreate = new FunctionInfo(
      new TypeInfo.forInterface(_staticInfo),
      "cairo_create",
      [
        new ArgInfo(
            new TypeInfo.forInterface(ImageSurface._cairoSurfaceT), "target")
      ],
      new FunctionSymbol(_cairoLib, "cairo_create"));

  Context.fromNative();

  factory Context(Surface target) => _cairoCreate.call([target]);

  static FunctionInfo _cairoStatus = new FunctionInfo(
      new TypeInfo.forInterface(Status._cairoStatusT), //insert return type
      "cairo_status",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_status"));

  static FunctionInfo _cairoSave = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_save",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_save"));

  static FunctionInfo _cairoRestore = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_restore",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_restore"));

  static FunctionInfo _cairoGetTarget = new FunctionInfo(
      new TypeInfo.forInterface(Surface._staticInfo), //insert return type
      "cairo_get_target",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_target"),
      callerOwns: girepository.Transfer.NOTHING);

  static FunctionInfo _cairoPushGroup = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_push_group",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_push_group"));

  static FunctionInfo _cairoPushGroupWithContent = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_push_group_with_content",
      [
        //insert args for [Content content]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_push_group_with_content"));

  static FunctionInfo _cairoPopGroup = new FunctionInfo(
      new TypeInfo.forInterface(CairoPattern._staticInfo), //insert return type
      "cairo_pop_group",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_pop_group"));

  static FunctionInfo _cairoPopGroupToSource = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_pop_group_to_source",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_pop_group_to_source"));

  static FunctionInfo _cairoGetGroupTarget = new FunctionInfo(
      new TypeInfo.forInterface(Surface._staticInfo), //insert return type
      "cairo_get_group_target",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_group_target"));

  static FunctionInfo _cairoSetSourceRgb = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_source_rgb",
      [
        //insert args for [double red, double green, double blue]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "red"),
        new ArgInfo(TypeInfo.double, "green"),
        new ArgInfo(TypeInfo.double, "blue")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_source_rgb"));

  static FunctionInfo _cairoSetSourceRgba = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_source_rgba",
      [
        //insert args for [double red, double green, double blue, double alpha]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "red"),
        new ArgInfo(TypeInfo.double, "green"),
        new ArgInfo(TypeInfo.double, "blue"),
        new ArgInfo(TypeInfo.double, "alpha")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_source_rgba"));

  static FunctionInfo _cairoSetSource = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_source",
      [
        //insert args for [Pattern source]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(CairoPattern._staticInfo), "source")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_source"));

  static FunctionInfo _cairoSetSourceSurface = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_source_surface",
      [
        //insert args for [Surface surface, double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Surface._staticInfo), "surface"),
        new ArgInfo(TypeInfo.double, "x"),
        new ArgInfo(TypeInfo.double, "y")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_source_surface"));

  static FunctionInfo _cairoGetSource = new FunctionInfo(
      new TypeInfo.forInterface(CairoPattern._staticInfo), //insert return type
      "cairo_get_source",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_source"));

  static FunctionInfo _cairoSetMatrix = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_matrix",
      [
        //insert args for [Matrix matrix]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Matrix._staticInfo), "matrix")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_matrix"));

  static FunctionInfo _cairoGetMatrix = new FunctionInfo(
      new TypeInfo.forInterface(Matrix._staticInfo), //insert return type
      "cairo_get_matrix",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_matrix"));

  static FunctionInfo _cairoSetAntialias = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_antialias",
      [
        //insert args for [Antialias antialias]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(Antialias._cairoAntialiasT), "antialias")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_antialias"));

  static FunctionInfo _cairoGetAntialias = new FunctionInfo(
      new TypeInfo.forInterface(
          Antialias._cairoAntialiasT), //insert return type
      "cairo_get_antialias",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_antialias"));

  static FunctionInfo _cairoSetDash = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_dash",
      [
        //insert args for [double[]? dashes, double offset]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.array(TypeInfo.double, 1), "dashes"),
        new ArgInfo(TypeInfo.double, "offset")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_dash"));

  //TODO: I can't represent this yet because dashes is really an out parameter
  /*
  static FunctionInfo _cairoGetDash = new FunctionInfo(
      TypeInfo.void_,//insert return type
    "cairo_get_dash",
    [ //insert args for [double[]? dashes, double[]? offset]
      new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
      new ArgInfo(new TypeInfo.array(TypeInfo.double, 1), "dashes"),
      new ArgInfo(TypeInfo.double, "offset", direction: girepository.Direction.OUT)
    ],
    new FunctionSymbol(_cairoLib, "cairo_get_dash"));
  */

  static FunctionInfo _cairoGetDashCount = new FunctionInfo(
      TypeInfo.int32, //insert return type
      "cairo_get_dash_count",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_dash_count"));

  static FunctionInfo _cairoSetFillRule = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_fill_rule",
      [
        //insert args for [FillRule fill_rule]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(FillRule._cairoFillRuleT), "fillRule")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_fill_rule"));

  static FunctionInfo _cairoGetFillRule = new FunctionInfo(
      new TypeInfo.forInterface(FillRule._cairoFillRuleT), //insert return type
      "cairo_get_fill_rule",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_fill_rule"));

  static FunctionInfo _cairoSetLineCap = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_line_cap",
      [
        //insert args for [LineCap line_cap]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(LineCap._cairoLineCapT), "lineCap")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_line_cap"));

  static FunctionInfo _cairoGetLineCap = new FunctionInfo(
      new TypeInfo.forInterface(LineCap._cairoLineCapT), //insert return type
      "cairo_get_line_cap",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_line_cap"));

  static FunctionInfo _cairoSetLineJoin = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_line_join",
      [
        //insert args for [LineJoin line_join]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(LineJoin._cairoLineJoinT), "lineJoin")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_line_join"));

  static FunctionInfo _cairoGetLineJoin = new FunctionInfo(
      new TypeInfo.forInterface(LineJoin._cairoLineJoinT), //insert return type
      "cairo_get_line_join",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_line_join"));

  static FunctionInfo _cairoSetLineWidth = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_line_width",
      [
        //insert args for [double width]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "width")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_line_width"));

  static FunctionInfo _cairoGetLineWidth = new FunctionInfo(
      TypeInfo.double, //insert return type
      "cairo_get_line_width",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_line_width"));

  static FunctionInfo _cairoSetMiterLimit = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_miter_limit",
      [
        //insert args for [double limit]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "limit")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_miter_limit"));

  static FunctionInfo _cairoGetMiterLimit = new FunctionInfo(
      TypeInfo.double, //insert return type
      "cairo_get_miter_limit",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_miter_limit"));

  static FunctionInfo _cairoSetOperator = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_operator",
      [
        //insert args for [Operator op]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Operator._cairoOperatorT), "op")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_operator"));

  static FunctionInfo _cairoGetOperator = new FunctionInfo(
      new TypeInfo.forInterface(Operator._cairoOperatorT), //insert return type
      "cairo_get_operator",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_operator"));

  static FunctionInfo _cairoSetTolerance = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_set_tolerance",
      [
        //insert args for [double tolerance]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "tolerance")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_tolerance"));

  static FunctionInfo _cairoGetTolerance = new FunctionInfo(
      TypeInfo.double, //insert return type
      "cairo_get_tolerance",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_tolerance"));

  static FunctionInfo _cairoClip = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_clip",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_clip"));

  static FunctionInfo _cairoClipPreserve = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_clip_preserve",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_clip_preserve"));

  static FunctionInfo _cairoClipExtents = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_clip_extents",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "x2",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y2",
            direction: girepository.Direction.OUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_clip_extents"));

  static FunctionInfo _cairoResetClip = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_reset_clip",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_reset_clip"));

  static FunctionInfo _cairoInClip = new FunctionInfo(
      TypeInfo.boolean, //insert return type
      "cairo_in_clip",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x"),
        new ArgInfo(TypeInfo.double, "y")
      ],
      new FunctionSymbol(_cairoLib, "cairo_in_clip"));

  static FunctionInfo _cairoCopyClipRectangleList = new FunctionInfo(
      new TypeInfo.forInterface(
          RectangleList._cairoRectangleListT), //insert return type
      "cairo_copy_clip_rectangle_list",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_copy_clip_rectangle_list"));

  static FunctionInfo _cairoFill = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_fill",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_fill"));

  static FunctionInfo _cairoFillPreserve = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_fill_preserve",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_fill_preserve"));

  static FunctionInfo _cairoFillExtents = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_fill_extents",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "x2",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y2",
            direction: girepository.Direction.OUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_fill_extents"));

  static FunctionInfo _cairoInFill = new FunctionInfo(
      TypeInfo.boolean, //insert return type
      "cairo_in_fill",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x"),
        new ArgInfo(TypeInfo.double, "y")
      ],
      new FunctionSymbol(_cairoLib, "cairo_in_fill"));

  static FunctionInfo _cairoMask = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_mask",
      [
        //insert args for [Pattern pattern]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(CairoPattern._staticInfo), "pattern")
      ],
      new FunctionSymbol(_cairoLib, "cairo_mask"));

  static FunctionInfo _cairoMaskSurface = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_mask_surface",
      [
        //insert args for [Surface surface, double surface_x, double surface_y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Surface._staticInfo), "surface"),
        new ArgInfo(TypeInfo.double, "surface_x"),
        new ArgInfo(TypeInfo.double, "aurface_y")
      ],
      new FunctionSymbol(_cairoLib, "cairo_mask_surface"));

  static FunctionInfo _cairoPaint = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_paint",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_paint"));

  static FunctionInfo _cairoPaintWithAlpha = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_paint_with_alpha",
      [
        //insert args for [double alpha]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "alpha")
      ],
      new FunctionSymbol(_cairoLib, "cairo_paint_with_alpha"));

  static FunctionInfo _cairoStroke = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_stroke",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_stroke"));

  static FunctionInfo _cairoStrokePreserve = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_stroke_preserve",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_stroke_preserve"));

  static FunctionInfo _cairoStrokeExtents = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_stroke_extents",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "x2",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y2",
            direction: girepository.Direction.OUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_stroke_extents"));

  static FunctionInfo _cairoInStroke = new FunctionInfo(
      TypeInfo.boolean, //insert return type
      "cairo_in_stroke",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x"),
        new ArgInfo(TypeInfo.double, "y")
      ],
      new FunctionSymbol(_cairoLib, "cairo_in_stroke"));

  static FunctionInfo _cairoCopyPage = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_copy_page",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_copy_page"));

  static FunctionInfo _cairoShowPage = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_show_page",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_show_page"));

  static FunctionInfo _cairoCopyPath = new FunctionInfo(
      new TypeInfo.forInterface(Path._staticInfo), //insert return type
      "cairo_copy_path",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_copy_path"));

  static FunctionInfo _cairoCopyPathFlat = new FunctionInfo(
      new TypeInfo.forInterface(Path._staticInfo), //insert return type
      "cairo_copy_path_flat",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_copy_path_flat"));

  static FunctionInfo _cairoAppendPath = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_append_path",
      [
        //insert args for [Path path]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Path._staticInfo), "path")
      ],
      new FunctionSymbol(_cairoLib, "cairo_append_path"));

  static FunctionInfo _cairoGetCurrentPoint = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_get_current_point",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y1",
            direction: girepository.Direction.OUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_current_point"));

  static FunctionInfo _cairoHasCurrentPoint = new FunctionInfo(
      TypeInfo.boolean, //insert return type
      "cairo_has_current_point",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_has_current_point"));

  static FunctionInfo _cairoNewPath = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_new_path",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_new_path"));

  static FunctionInfo _cairoNewSubPath = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_new_sub_path",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_new_sub_path"));

  static FunctionInfo _cairoClosePath = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_close_path",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_close_path"));

  static FunctionInfo _cairoArc = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_arc",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "xc"),
        new ArgInfo(TypeInfo.double, "yc"),
        new ArgInfo(TypeInfo.double, "radius"),
        new ArgInfo(TypeInfo.double, "angle1"),
        new ArgInfo(TypeInfo.double, "angle2")
      ],
      new FunctionSymbol(_cairoLib, "cairo_arc"));

  static FunctionInfo _cairoArcNegative = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_arc_negative",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "xc"),
        new ArgInfo(TypeInfo.double, "yc"),
        new ArgInfo(TypeInfo.double, "radius"),
        new ArgInfo(TypeInfo.double, "angle1"),
        new ArgInfo(TypeInfo.double, "angle2")
      ],
      new FunctionSymbol(_cairoLib, "cairo_arc_negative"));

  static FunctionInfo _cairoCurveTo = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_curve_to",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x1"),
        new ArgInfo(TypeInfo.double, "y1"),
        new ArgInfo(TypeInfo.double, "x2"),
        new ArgInfo(TypeInfo.double, "y2"),
        new ArgInfo(TypeInfo.double, "x3"),
        new ArgInfo(TypeInfo.double, "y3")
      ],
      new FunctionSymbol(_cairoLib, "cairo_curve_to"));

  static FunctionInfo _cairoLineTo = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_line_to",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x"),
        new ArgInfo(TypeInfo.double, "y")
      ],
      new FunctionSymbol(_cairoLib, "cairo_line_to"));

  static FunctionInfo _cairoMoveTo = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_move_to",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x"),
        new ArgInfo(TypeInfo.double, "y")
      ],
      new FunctionSymbol(_cairoLib, "cairo_move_to"));

  static FunctionInfo _cairoRectangle = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_rectangle",
      [
        //insert args for [double x, double y, double width, double height]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x"),
        new ArgInfo(TypeInfo.double, "y"),
        new ArgInfo(TypeInfo.double, "width"),
        new ArgInfo(TypeInfo.double, "height")
      ],
      new FunctionSymbol(_cairoLib, "cairo_rectangle"));

  //TODO: There's no way to represent this yet because glyphs is a compact list.
  /*
  static FunctionInfo _cairoGlyphPath = new FunctionInfo(
      TypeInfo.void_,//insert return type
    "cairo_glyph_path",
    [ //insert args for [Glyph[] glyphs]
      new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
      new ArgInfo(new TypeInfo.forInterface(_staticInfo), "glyphs")
    ],
    new FunctionSymbol(_cairoLib, "cairo_glyph_path"));
  */

  static FunctionInfo _cairoTextPath = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_text_path",
      [
        //insert args for [double x, double y, double width, double height]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.string, "utf8")
      ],
      new FunctionSymbol(_cairoLib, "cairo_text_path"));

  static FunctionInfo _cairoRelCurveTo = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_rel_curve_to",
      [
        //insert args for [double x, double y]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x1"),
        new ArgInfo(TypeInfo.double, "y1"),
        new ArgInfo(TypeInfo.double, "x2"),
        new ArgInfo(TypeInfo.double, "y2"),
        new ArgInfo(TypeInfo.double, "x3"),
        new ArgInfo(TypeInfo.double, "y3")
      ],
      new FunctionSymbol(_cairoLib, "cairo_rel_curve_to"));

  static FunctionInfo _cairoRelLineTo = new FunctionInfo(
      TypeInfo.void_,
      "cairo_rel_line_to",
      [
        //insert args for [double dx, double dy]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "dx"),
        new ArgInfo(TypeInfo.double, "dy")
      ],
      new FunctionSymbol(_cairoLib, "cairo_rel_line_to"));

  static FunctionInfo _cairoRelMoveTo = new FunctionInfo(
      TypeInfo.void_,
      "cairo_rel_move_to",
      [
        //insert args for [double dx, double dy]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "dx"),
        new ArgInfo(TypeInfo.double, "dy")
      ],
      new FunctionSymbol(_cairoLib, "cairo_rel_move_to"));

  static FunctionInfo _cairoTranslate = new FunctionInfo(
      TypeInfo.void_,
      "cairo_translate",
      [
        //insert args for [double tx, double ty]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "tx"),
        new ArgInfo(TypeInfo.double, "ty")
      ],
      new FunctionSymbol(_cairoLib, "cairo_translate"));

  static FunctionInfo _cairoScale = new FunctionInfo(
      TypeInfo.void_,
      "cairo_scale",
      [
        //insert args for [double sx, double sy]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "sx"),
        new ArgInfo(TypeInfo.double, "sy")
      ],
      new FunctionSymbol(_cairoLib, "cairo_scale"));

  static FunctionInfo _cairoRotate = new FunctionInfo(
      TypeInfo.void_,
      "cairo_rotate",
      [
        //insert args for [double angle]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "angle")
      ],
      new FunctionSymbol(_cairoLib, "cairo_rotate"));

  static FunctionInfo _cairoTransform = new FunctionInfo(
      TypeInfo.void_,
      "cairo_transform",
      [
        //insert args for [Matrix matrix]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Matrix._staticInfo), "matrix")
      ],
      new FunctionSymbol(_cairoLib, "cairo_transform"));

  static FunctionInfo _cairoIdentityMatrix = new FunctionInfo(
      TypeInfo.void_,
      "cairo_identity_matrix",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_identity_matrix"));

  static FunctionInfo _cairoUserToDevice = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_user_to_device",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x",
            direction: girepository.Direction.INOUT),
        new ArgInfo(TypeInfo.double, "y",
            direction: girepository.Direction.INOUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_user_to_device"));

  static FunctionInfo _cairoUserToDeviceDistance = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_user_to_device_distance",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "dx",
            direction: girepository.Direction.INOUT),
        new ArgInfo(TypeInfo.double, "dy",
            direction: girepository.Direction.INOUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_user_to_device_distance"));

  static FunctionInfo _cairoDeviceToUser = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_device_to_user",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x",
            direction: girepository.Direction.INOUT),
        new ArgInfo(TypeInfo.double, "y",
            direction: girepository.Direction.INOUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_device_to_user"));

  static FunctionInfo _cairoDeviceToUserDistance = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_device_to_user_distance",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "dx",
            direction: girepository.Direction.INOUT),
        new ArgInfo(TypeInfo.double, "dy",
            direction: girepository.Direction.INOUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_device_to_user_distance"));

  static FunctionInfo _cairoSelectFontFace = new FunctionInfo(
      TypeInfo.void_,
      "cairo_select_font_face",
      [
        //insert args for [string family, FontSlant slant, FontWeight weight]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.string, "family"),
        new ArgInfo(
            new TypeInfo.forInterface(FontSlant._cairoFontSlantT), "slant"),
        new ArgInfo(
            new TypeInfo.forInterface(FontWeight._cairoFontWeightT), "weight")
      ],
      new FunctionSymbol(_cairoLib, "cairo_select_font_face"));

  static FunctionInfo _cairoSetFontSize = new FunctionInfo(
      TypeInfo.void_,
      "cairo_set_font_size",
      [
        //insert args for [double size]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "size")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_font_size"));

  static FunctionInfo _cairoSetFontMatrix = new FunctionInfo(
      TypeInfo.void_,
      "cairo_set_font_matrix",
      [
        //insert args for [Matrix matrix]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Matrix._staticInfo), "matrix")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_font_matrix"));

  static FunctionInfo _cairoGetFontMatrix = new FunctionInfo(
      TypeInfo.void_,
      "cairo_set_font_matrix",
      [
        //insert args for [Matrix matrix]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(Matrix._staticInfo), "matrix",
            direction: girepository.Direction.OUT, isCallerAllocates: true)
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_font_matrix"));

  static FunctionInfo _cairoSetFontOptions = new FunctionInfo(
      TypeInfo.void_,
      "cairo_set_font_options",
      [
        //insert args for [FontOptions options]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(FontOptions._staticInfo), "options")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_font_options"));

  static FunctionInfo _cairoGetFontOptions = new FunctionInfo(
      TypeInfo.void_,
      "cairo_get_font_options",
      [
        //insert args for [FontOptions options]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(FontOptions._staticInfo), "options",
            direction: girepository.Direction.OUT, isCallerAllocates: true)
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_font_options"));

  static FunctionInfo _cairoShowText = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_show_text",
      [
        //insert args for [double x, double y, double width, double height]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.string, "utf8")
      ],
      new FunctionSymbol(_cairoLib, "cairo_show_text"));

  //TODO: There's no way to represent this yet because glyphs is a compact list.
  /*
  static FunctionInfo _cairoShowGlyphs = new FunctionInfo(
    TypeInfo.void_,
    "cairo_show_glyphs",
    [ //insert args for [Glyph[] glyphs]
    ],
    new FunctionSymbol(_cairoLib, "cairo_show_glyphs"));
  */

  //TODO: This will also need some tweaking for the compact list.
  //public Status show_text_glyphs (string utf8, int utf8_len, out Glyph[] glyphs, out TextCluster[] clusters, out TextClusterFlags cluster_flags)

  static FunctionInfo _cairoGetFontFace = new FunctionInfo(
      new TypeInfo.forInterface(FontFace._staticInfo),
      "cairo_get_font_face",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_font_face"));

  //public void font_extents (out FontExtents extents)
  static FunctionInfo _cairoFontExtents = new FunctionInfo(
      new TypeInfo.forInterface(FontFace._staticInfo),
      "cairo_font_extents",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(FontExtents._cairoFontExtentsT),
            "extents",
            direction: girepository.Direction.OUT, isCallerAllocates: true)
      ],
      new FunctionSymbol(_cairoLib, "cairo_font_extents"));

  static FunctionInfo _cairoSetFontFace = new FunctionInfo(
      TypeInfo.void_,
      "cairo_set_font_face",
      [
        //insert args for [FontFace font_face]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(new TypeInfo.forInterface(FontFace._staticInfo), "fontFace")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_font_face"));

  static FunctionInfo _cairoSetScaledFont = new FunctionInfo(
      TypeInfo.void_,
      "cairo_set_scaled_font",
      [
        //insert args for [ScaledFont font]
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(
            new TypeInfo.forInterface(ScaledFont._staticInfo), "scaledFont")
      ],
      new FunctionSymbol(_cairoLib, "cairo_set_scaled_font"));

  static FunctionInfo _cairoGetScaledFont = new FunctionInfo(
      new TypeInfo.forInterface(ScaledFont._staticInfo), //insert return type
      "cairo_get_scaled_font",
      [
        //insert args for []
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context")
      ],
      new FunctionSymbol(_cairoLib, "cairo_get_scaled_font"));

  //public void text_extents (string utf8, out TextExtents extents)
  static FunctionInfo _cairoTextExtents = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_text_extents",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.string, "utf8"),
        new ArgInfo(new TypeInfo.forInterface(TextExtents._cairoTextExtentsT),
            "extents",
            direction: girepository.Direction.OUT, isCallerAllocates: true)
      ],
      new FunctionSymbol(_cairoLib, "cairo_text_extents"));
  //TODO: This will need some tweaking for the glyphs
  //public void glyph_extents (Glyph[] glyphs, out TextExtents extents)
  //public void path_extents (out double x1, out double y1, out double x2, out double y2)

  static FunctionInfo _cairoPathExtents = new FunctionInfo(
      TypeInfo.void_, //insert return type
      "cairo_path_extents",
      [
        new ArgInfo(new TypeInfo.forInterface(_staticInfo), "context"),
        new ArgInfo(TypeInfo.double, "x1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y1",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "x2",
            direction: girepository.Direction.OUT),
        new ArgInfo(TypeInfo.double, "y2",
            direction: girepository.Direction.OUT)
      ],
      new FunctionSymbol(_cairoLib, "cairo_path_extents"));

  Status get status => _cairoStatus.call([this]);
  void save() => _cairoSave.call([this]);
  void restore() => _cairoRestore.call([this]);
  Surface get target => _cairoGetTarget.call([this]);
  void pushGroup() => _cairoPushGroup.call([this]);
  void pushGroupWithContent(Content content) =>
      _cairoPushGroupWithContent.call([this, content]);
  Pattern popGroup() => _cairoPopGroup.call([this]);
  void popGroupToSource() => _cairoPopGroupToSource.call([this]);
  Surface get groupTarget => _cairoGetGroupTarget.call([this]);
  void setSourceRgb(double red, double green, double blue) =>
      _cairoSetSourceRgb.call([this, red, green, blue]);
  void setSourceRgba(double red, double green, double blue, double alpha) =>
      _cairoSetSourceRgba.call([this, red, green, blue, alpha]);
  void set source(Pattern source) => _cairoSetSource.call([this, source]);
  void setSourceSurface(Surface surface, double x, double y) =>
      _cairoSetSourceSurface.call([this, surface, x, y]);
  Pattern get source => _cairoGetSource.call([this]);
  void set matrix(Matrix matrix) => _cairoSetMatrix.call([this, matrix]);
  Matrix get matrix => _cairoGetMatrix.call([this]);
  void set antialias(Antialias antialias) =>
      _cairoSetAntialias.call([this, antialias]);
  Antialias get antialias => _cairoGetAntialias.call([this]);
  void setDash(List<double> dashes, double offset) =>
      _cairoSetDash.call([this, dashes, offset]);
  //TODO: See above.
  //void getDash(List<double> dashes, List<double> offset) => _cairoGetDash.call([this, dashes, offset]);
  int get dashCount => _cairoGetDashCount.call([this]);
  void set fillRule(FillRule fillRule) =>
      _cairoSetFillRule.call([this, fillRule]);
  FillRule get fillRule => _cairoGetFillRule.call([this]);
  void set lineCap(LineCap lineCap) => _cairoSetLineCap.call([this, lineCap]);
  LineCap get lineCap => _cairoGetLineCap.call([this]);
  void set lineJoin(LineJoin lineJoin) =>
      _cairoSetLineJoin.call([this, lineJoin]);
  LineJoin get lineJoin => _cairoGetLineJoin.call([this]);
  void set lineWidth(double width) => _cairoSetLineWidth.call([this, width]);
  double get lineWidth => _cairoGetLineWidth.call([this]);
  void set miterLimit(double limit) => _cairoSetMiterLimit.call([this, limit]);
  double get miterLimit => _cairoGetMiterLimit.call([this]);
  void set operator(Operator op) => _cairoSetOperator.call([this, op]);
  Operator get operator => _cairoGetOperator.call([this]);
  void set tolerance(double tolerance) =>
      _cairoSetTolerance.call([this, tolerance]);
  double get tolerance => _cairoGetTolerance.call([this]);
  void clip() => _cairoClip.call([this]);
  void clipPreserve() => _cairoClipPreserve.call([this]);
  List clipExtents() => _cairoClipExtents.call([this]);
  void resetClip() => _cairoResetClip.call([this]);
  bool inClip(double x, double y) => _cairoInClip.call([this, x, y]);
  RectangleList copyClipRectangleList() =>
      _cairoCopyClipRectangleList.call([this]);
  void fill() => _cairoFill.call([this]);
  void fillPreserve() => _cairoFillPreserve.call([this]);
  List fillExtents() => _cairoFillExtents.call([this]);
  bool inFill(double x, double y) => _cairoInFill.call([this, x, y]);
  void mask(Pattern pattern) => _cairoMask.call([this, pattern]);
  void maskSurface(Surface surface, double surfaceX, double surfaceY) =>
      _cairoMaskSurface.call([this, surface, surfaceX, surfaceY]);
  void paint() => _cairoPaint.call([this]);
  void paintWithAlpha(double alpha) => _cairoPaintWithAlpha.call([this, alpha]);
  void stroke() => _cairoStroke.call([this]);
  void strokePreserve() => _cairoStrokePreserve.call([this]);
  List strokeExtents() => _cairoStrokeExtents.call([this]);
  bool inStroke(double x, double y) => _cairoInStroke.call([this, x, y]);
  void copyPage() => _cairoCopyPage.call([this]);
  void showPage() => _cairoShowPage.call([this]);
  Path copyPath() => _cairoCopyPath.call([this]);
  Path copyPathFlat() => _cairoCopyPathFlat.call([this]);
  void appendPath(Path path) => _cairoAppendPath.call([this, path]);
  List get currentPoint => _cairoGetCurrentPoint.call([this]);
  bool hasCurrentPoint() => _cairoHasCurrentPoint.call([this]);
  void newPath() => _cairoNewPath.call([this]);
  void newSubPath() => _cairoNewSubPath.call([this]);
  void closePath() => _cairoClosePath.call([this]);
  void arc(double xc, double yc, double radius, double angle1, double angle2) =>
      _cairoArc.call([this, xc, yc, radius, angle1, angle2]);
  void arcNegative(
          double xc, double yc, double radius, double angle1, double angle2) =>
      _cairoArcNegative.call([this, xc, yc, radius, angle1, angle2]);
  void curveTo(
          double x1, double y1, double x2, double y2, double x3, double y3) =>
      _cairoCurveTo.call([this, x1, y1, x2, y2, x3, y3]);
  void lineTo(double x, double y) => _cairoLineTo.call([this, x, y]);
  void moveTo(double x, double y) => _cairoMoveTo.call([this, x, y]);
  void rectangle(double x, double y, double width, double height) =>
      _cairoRectangle.call([this, x, y, width, height]);
  //TODO: See above
  //void glyphPath(List<Glyph> glyphs) => _cairoGlyphPath.call([this, glyphs]);
  void textPath(String utf8) => _cairoTextPath.call([this, utf8]);
  void relCurveTo(double dx1, double dy1, double dx2, double dy2, double dx3,
          double dy3) =>
      _cairoRelCurveTo.call([this, dx1, dy1, dx2, dy2, dx3, dy3]);
  void relLineTo(double dx, double dy) => _cairoRelLineTo.call([this, dx, dy]);
  void relMoveTo(double dx, double dy) => _cairoRelMoveTo.call([this, dx, dy]);
  void translate(double tx, double ty) => _cairoTranslate.call([this, tx, ty]);
  void scale(double sx, double sy) => _cairoScale.call([this, sx, sy]);
  void rotate(double angle) => _cairoRotate.call([this, angle]);
  void transform(Matrix matrix) => _cairoTransform.call([this, matrix]);
  void identityMatrix() => _cairoIdentityMatrix.call([this]);
  List userToDevice(double x, double y) =>
      _cairoUserToDevice.call([this, x, y]);
  List userToDeviceDistance(double dx, double dy) =>
      _cairoUserToDeviceDistance.call([this, dx, dy]);
  List deviceToUser(double x, double y) =>
      _cairoDeviceToUser.call([this, x, y]);
  List deviceToUserDistance(double dx, double dy) =>
      _cairoDeviceToUserDistance.call([this, dx, dy]);
  void selectFontFace(String family, FontSlant slant, FontWeight weight) =>
      _cairoSelectFontFace.call([this, family, slant, weight]);
  void set fontSize(double size) => _cairoSetFontSize.call([this, size]);
  void set fontMatrix(Matrix matrix) => _cairoSetFontMatrix.call([this, matrix]);
  Matrix get fontMatrix => _cairoGetFontMatrix.call([this]);
  void set fontOptions(FontOptions options) =>
      _cairoSetFontOptions.call([this, options]);
  FontOptions get fontOptions => _cairoGetFontOptions.call([this]);
  void showText(String utf8) => _cairoShowText.call([this, utf8]);
  //TODO: See above
  //void showGlyphs(List<Glyph> glyphs) => _cairoShowGlyphs.call([this, List<Glyph> glyphs]);
  //public Status showTextGlyphs (string utf8, int utf8Len, out List<Glyph> glyphs, out List<TextCluster> clusters, out TextClusterFlags clusterFlags)
  FontFace get fontFace => _cairoGetFontFace.call([this]);
  FontExtents fontExtents() => _cairoFontExtents.call([this]);
  void set fontFace(FontFace fontFace) =>
      _cairoSetFontFace.call([this, fontFace]);
  void set scaledFont(ScaledFont font) => _cairoSetScaledFont.call([this, font]);
  ScaledFont get scaledFont => _cairoGetScaledFont.call([this]);
  TextExtents textExtents(String utf8) => _cairoTextExtents.call([this, utf8]);

  //public void glyphExtents (List<Glyph> glyphs, out TextExtents extents)
  List pathExtents () =>
      _cairoPathExtents.call([this]);

}

class Surface extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('cairo', 'Surface');

  Surface.fromNative();
}

class Path extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('cairo', 'Path');
}

class RectangleList extends GObjectBase {
  static StructUnionInfo _cairoRectangleListT = new StructUnionInfo(
      0, "RectangleList", RectangleList,
      namespace: "cairo");

  RectangleList.fromNative();
}

class TextExtents extends GObjectBase {
  static StructUnionInfo _cairoTextExtentsT =
      new StructUnionInfo(0, "TextExtents", TextExtents, namespace: "cairo");

  TextExtents.fromNative();
}

class FontExtents extends GObjectBase {
  static StructUnionInfo _cairoFontExtentsT =
      new StructUnionInfo(0, "FontExtents", RectangleList, namespace: "cairo");

  FontExtents.fromNative();
}

class ImageSurface extends Surface {
  static StructUnionInfo _cairoSurfaceT = new StructUnionInfo(
      0, "ImageSurface", ImageSurface,
      namespace: "cairo",
      copyFunction: new FunctionSymbol(_cairoLib, "cairo_surface_reference"),
      freeFunction: new FunctionSymbol(_cairoLib, "cairo_surface_destroy"));
  static FunctionInfo _cairoImageSurfaceCreate = new FunctionInfo(
      new TypeInfo.forInterface(_cairoSurfaceT),
      "cairo_image_surface_create",
      [
        new ArgInfo(new TypeInfo.forInterface(Format._cairoFormatT), "format"),
        new ArgInfo(TypeInfo.int32, "width"),
        new ArgInfo(TypeInfo.int32, "height"),
      ],
      new FunctionSymbol(_cairoLib, "cairo_image_surface_create"));

  ImageSurface.fromNative() : super.fromNative();
  factory ImageSurface(Format format, int width, int height) =>
      _cairoImageSurfaceCreate.call([format, width, height]);
}

class Antialias extends GEnumBase {
  static EnumInfo _cairoAntialiasT =
      new EnumInfo(0, "Antialias", Antialias, namespace: "cairo");
  const Antialias(int index) : super(index);
  static const Antialias DEFAULT = const Antialias(0);
  static const Antialias NONE = const Antialias(1);
  static const Antialias GRAY = const Antialias(2);
  static const Antialias SUBPIXEL = const Antialias(3);
  static const Antialias FAST = const Antialias(4);
  static const Antialias GOOD = const Antialias(5);
  static const Antialias BEST = const Antialias(6);
}

class Status extends GEnumBase {
  static EnumInfo _cairoStatusT =
      new EnumInfo(0, "Status", Status, namespace: "cairo");
  const Status(int index) : super(index);
  static const Status SUCCESS = const Status(0);
  static const Status NO_MEMORY = const Status(1);
  static const Status INVALID_RESTORE = const Status(2);
  static const Status INVALID_POP_GROUP = const Status(3);
  static const Status NO_CURRENT_POINT = const Status(4);
  static const Status INVALID_MATRIX = const Status(5);
  static const Status INVALID_STATUS = const Status(6);
  static const Status NULL_POINTER = const Status(7);

  static const Status INVALID_STRING = const Status(8);

  static const Status INVALID_PATH_DATA = const Status(9);

  static const Status READ_ERROR = const Status(10);

  static const Status WRITE_ERROR = const Status(11);

  static const Status SURFACE_FINISHED = const Status(12);

  static const Status SURFACE_TYPE_MISMATCH = const Status(13);

  static const Status PATTERN_TYPE_MISMATCH = const Status(14);

  static const Status INVALID_CONTENT = const Status(15);

  static const Status INVALID_FORMAT = const Status(16);

  static const Status INVALID_VISUAL = const Status(17);

  static const Status FILE_NOT_FOUND = const Status(18);

  static const Status INVALID_DASH = const Status(19);

  static const Status INVALID_DSC_COMMENT = const Status(20);

  static const Status INVALID_INDEX = const Status(21);

  static const Status CLIP_NOT_REPRESENTABLE = const Status(22);

  static const Status TEMP_FILE_ERROR = const Status(23);

  static const Status INVALID_STRIDE = const Status(24);

  static const Status FONT_TYPE_MISMATCH = const Status(25);

  static const Status USER_FONT_IMMUTABLE = const Status(26);

  static const Status USER_FONT_ERROR = const Status(27);

  static const Status NEGATIVE_COUNT = const Status(28);

  static const Status INVALID_CLUSTERS = const Status(29);

  static const Status INVALID_SLANT = const Status(30);

  static const Status INVALID_WEIGHT = const Status(31);

  static const Status INVALID_SIZE = const Status(32);

  static const Status USER_FONT_NOT_IMPLEMENTED = const Status(33);

  static const Status DEVICE_TYPE_MISMATCH = const Status(34);

  static const Status DEVICE_ERROR = const Status(35);

  static const Status INVALID_MESH_CONSTRUCTION = const Status(36);
  static const Status DEVICE_FINISHED = const Status(37);
  static const Status JBIG2_GLOBAL_MISSING = const Status(38);
}

class FillRule extends GEnumBase {
  static EnumInfo _cairoFillRuleT =
      new EnumInfo(0, "FillRule", FillRule, namespace: "cairo");
  const FillRule(int index) : super(index);
  static const FillRule WINDING = const FillRule(0);
  static const FillRule EVEN_ODD = const FillRule(1);
}

class LineCap extends GEnumBase {
  static EnumInfo _cairoLineCapT =
      new EnumInfo(0, "LineCap", LineCap, namespace: "cairo");
  const LineCap(int index) : super(index);
  static const LineCap BUTT = const LineCap(0);
  static const LineCap ROUND = const LineCap(1);
  static const LineCap SQUARE = const LineCap(2);
}

class LineJoin extends GEnumBase {
  static EnumInfo _cairoLineJoinT =
      new EnumInfo(0, "LineJoin", LineJoin, namespace: "cairo");
  const LineJoin(int index) : super(index);
  static const LineJoin CLEAR = const LineJoin(0);
  static const LineJoin ROUND = const LineJoin(1);
  static const LineJoin BEVEL = const LineJoin(2);
}

class FontSlant extends GEnumBase {
  static EnumInfo _cairoFontSlantT =
      new EnumInfo(0, "FontSlant", FontSlant, namespace: "cairo");
  const FontSlant(int index) : super(index);
  static const FontSlant NORMAL = const FontSlant(0);
  static const FontSlant ITALIC = const FontSlant(1);
  static const FontSlant OBLIQUE = const FontSlant(2);
}

class FontWeight extends GEnumBase {
  static EnumInfo _cairoFontWeightT =
      new EnumInfo(0, "FontWeight", FontWeight, namespace: "cairo");
  const FontWeight(int index) : super(index);
  static const FontWeight NORMAL = const FontWeight(0);
  static const FontWeight BOLD = const FontWeight(1);
}

class Operator extends GEnumBase {
  static EnumInfo _cairoOperatorT =
      new EnumInfo(0, "Operator", Operator, namespace: "cairo");
  const Operator(int index) : super(index);
  static const Operator CLEAR = const Operator(0);
  static const Operator SOURCE = const Operator(1);
  static const Operator OVER = const Operator(2);
  static const Operator IN = const Operator(3);
  static const Operator OUT = const Operator(4);
  static const Operator ATOP = const Operator(5);
  static const Operator DEST = const Operator(6);
  static const Operator DEST_OVER = const Operator(7);
  static const Operator DEST_IN = const Operator(8);
  static const Operator DEST_OUT = const Operator(9);
  static const Operator DEST_ATOP = const Operator(10);

  static const Operator XOR = const Operator(11);
  static const Operator ADD = const Operator(12);
  static const Operator SATURATE = const Operator(13);
  static const Operator MULTIPLY = const Operator(14);
  static const Operator SCREEN = const Operator(15);
  static const Operator OVERLAY = const Operator(16);
  static const Operator DARKEN = const Operator(17);
  static const Operator LIGHTEN = const Operator(18);
  static const Operator COLOR_DODGE = const Operator(19);
  static const Operator COLOR_BURN = const Operator(20);
  static const Operator HARD_LIGHT = const Operator(21);
  static const Operator SOFT_LIGHT = const Operator(22);
  static const Operator DIFFERENCE = const Operator(23);
  static const Operator EXCLUSION = const Operator(24);
  static const Operator HSL_HUE = const Operator(25);
  static const Operator HSL_SATURATION = const Operator(26);
  static const Operator HSL_COLOR = const Operator(27);
  static const Operator HSL_LUMINOSITY = const Operator(28);
}

class Format extends GEnumBase {
  static EnumInfo _cairoFormatT = new EnumInfo(0, "cairo_format_t", Format);
  const Format(int value) : super(value);
  static const Format INVALID = const Format(-1);
  static const Format ARGB32 = const Format(0);
  static const Format RGB24 = const Format(1);
  static const Format A8 = const Format(2);
  static const Format A1 = const Format(3);
  static const Format RGB16_565 = const Format(4);
  static const Format RGB30 = const Format(5);
  String toString() {
    switch (index) {
      case -1:
        return 'Format.INVALID';
      case 0:
        return 'Format.ARGB32';
      case 1:
        return 'Format.RGB24';
      case 2:
        return 'Format.A8';
      case 3:
        return 'Format.A1';
      case 4:
        return 'Format.RGB16_565';
      case 5:
        return 'Format.RGB30';
      default:
        return 'new Format($index)';
    }
  }
}

class Matrix extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('cairo', 'Matrix');
  Matrix.fromNative();
}

class CairoPattern extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('cairo', 'Pattern');
  CairoPattern.fromNative();
}

class Region extends GObjectBase {
  Region.fromNative();
}

class Content extends GEnumBase {
  const Content(int value) : super(value);
  static const Content COLOR = const Content(4096);
  static const Content ALPHA = const Content(8192);
  static const Content COLOR_ALPHA = const Content(12288);
  String toString() {
    switch (index) {
      case 4096:
        return 'Content.COLOR';
      case 8192:
        return 'Content.ALPHA';
      case 12288:
        return 'Content.COLOR_ALPHA';
      default:
        return 'new Content($index)';
    }
  }
}

class FontOptions extends GObjectBase {
  static final GIObjectInfo _staticInfo =
      new GIObjectInfo('cairo', 'FontOptions');

  FontOptions.fromNative();
}

class FontType extends GObjectBase {
  FontType.fromNative();
}

class FontFace extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('cairo', 'FontFace');

  FontFace.fromNative();
}

class ScaledFont extends GObjectBase {
  static final GIObjectInfo _staticInfo =
      new GIObjectInfo('cairo', 'ScaledFont');

  ScaledFont.fromNative();
}

class RectangleInt extends GObjectBase {
  RectangleInt.fromNative();

  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
  int get width => getFieldOfObject('width', 2);
  void set width(int value) => setFieldOfObject('width', 2, value);
  int get height => getFieldOfObject('height', 3);
  void set height(int value) => setFieldOfObject('height', 3, value);
}

void imageSurfaceCreate() =>
    callStaticGlobal('cairo', 'image_surface_create', []);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  registerInterceptorTypeForNamedType("cairo", "Context", Context);
  registerCopyFuncForNamedType("cairo", "Context", "cairo_reference");
  registerFreeFuncForNamedType("cairo", "Context", "cairo_destroy");

  registerInterceptorTypeForNamedType("cairo", "Surface", Surface);
  registerInterceptorTypeForNamedType("cairo", "Matrix", Matrix);
  registerInterceptorTypeForNamedType("cairo", "Pattern", CairoPattern);
  registerInterceptorTypeForNamedType("cairo", "Region", Region);
  registerInterceptorTypeForNamedType("cairo", "Content", Content);
  registerInterceptorTypeForNamedType("cairo", "FontOptions", FontOptions);
  registerInterceptorTypeForNamedType("cairo", "FontType", FontType);
  registerInterceptorTypeForNamedType("cairo", "FontFace", FontFace);
  registerInterceptorTypeForNamedType("cairo", "ScaledFont", ScaledFont);
  registerInterceptorTypeForNamedType("cairo", "Path", Path);
  registerInterceptorTypeForNamedType("cairo", "RectangleInt", RectangleInt);
}
