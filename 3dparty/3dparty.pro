TEMPLATE = subdirs
SUBDIRS += libs/QGumboParser/QGumboParser

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/libs/QGumboParser/QGumboParser/release/ -lQGumboParser
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/libs/QGumboParser/QGumboParser/debug/ -lQGumboParser
else:unix: LIBS += -L$$OUT_PWD/libs/QGumboParser/QGumboParser/ -lQGumboParser

INCLUDEPATH += $$PWD/libs/QGumboParser/QGumboParser
DEPENDPATH += $$PWD/libs/QGumboParser/QGumboParser

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/libs/QGumboParser/QGumboParser/release/libQGumboParser.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/libs/QGumboParser/QGumboParser/debug/libQGumboParser.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/libs/QGumboParser/QGumboParser/release/QGumboParser.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/libs/QGumboParser/QGumboParser/debug/QGumboParser.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/libs/QGumboParser/QGumboParser/libQGumboParser.a
