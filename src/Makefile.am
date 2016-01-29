## Process this file with automake to produce Makefile.in

## Created by Anjuta

SUBDIRS = gdart .

AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(pkgdatadir)"\" \
	-I/opt/dart-sdk \
	-fPIC \
	-DDART_SHARED_LIB \
	$(GDART_CFLAGS)

AM_CFLAGS =\
	 -Wall -Wmissing-field-initializers -O0

lib_LTLIBRARIES = libgdart.la

libgdart_la_SOURCES = \
	gdart.c

libgdart_la_LDFLAGS = \
	-shared -Wl,-soname,libgdart.so

libgdart_la_LIBADD = $(GDART_LIBS) \
                     gdart/libgdartgdart.la



