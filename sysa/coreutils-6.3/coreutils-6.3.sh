# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default_src_prepare

    cp lib/fnmatch_.h lib/fnmatch.h
    cp lib/fcntl_.h lib/fcntl.h
    sed -i 's#@ABSOLUTE_FCNTL_H@#"/after/include/musl/fcntl.h"#' lib/fcntl.h 

    # Rebuild bison pre-generated file
    rm lib/getdate.c
    cd lib
    bison --update getdate.y
    bison getdate.y
    mv getdate.tab.c getdate.c
    cd ..

    catm config.h
    catm lib/configmake.h
}

src_compile() {
    make -f Makefile
}

src_install() {
    make -f Makefile install PREFIX="${PREFIX}"
}
