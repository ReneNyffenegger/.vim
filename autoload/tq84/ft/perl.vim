call TQ84_log_indent(expand('<sfile>'))

fu! tq84#ft#perl#BufNewFile() " {
  call TQ84_log_indent('tq84#ft#perl#BufNewFile ' . expand('%'))

  call append(0, ['#!/usr/bin/perl', 'use warnings;','use strict;', ''])

  if has('unix') " {
     w
     call TQ84_log(system("chmod 755 '" . expand('%') . "'"))
   " Read file again to supress W16 (»Warning: Mode of file … has changed since editing started«)
     e!
  endif " }

  normal 5G
  startinsert

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
