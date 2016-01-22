## Process this file with automake to produce Makefile.in

## Created by Anjuta

AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(pkgdatadir)"\" \
	-I/usr/lib/dart \
	-fPIC \
	-DDART_SHARED_LIB \
	$(GDART_CFLAGS)

AM_CFLAGS =\
	 -Wall -O0

lib_LTLIBRARIES = libgdart.la

libgdart_la_SOURCES = \
	gdart.c\
	gdart/array.c\
	gdart/importer.c\
	gdart/common.c\
	gdart/bridge_context.c\
	gdart/marshallers_check.c\
	gdart/function.c\
	gdart/g_property.c
libgdart_la_LDFLAGS = \
	-shared -Wl,-soname,libgdart.so
libgdart_la_LIBADD = $(GDART_LIBS)


