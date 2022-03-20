aclocal -I m4
autoconf
libtoolize --automake --copy --force
automake --add-missing --copy --force-missing
