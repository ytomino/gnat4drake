==================================
GNAT compatibility layer for drake
==================================

These files are thin wrappers for compiling some Ada source code depending on `The GNAT Library`_, to be linked with drake_.

Usage
-----

For gnatmake
~~~~~~~~~~~~

If gnatmake is used in the target project, pass this directory to the compiler by the switch ``-I`` or the enviromment variable ``ADA_INCLUDE_PATH``.

For gprbuild
~~~~~~~~~~~~

If gprbuild_ is used in the target project, at first, run ``./configure --RTS=${rts-drake}``. (Replace ``${rts-drake}`` to the directory drake is installed.)
Two files named *gnat.gpr* and *c.gpr* will be generated.
Next, insert ``with "gnat.gpr";`` into any one of the *.gpr* file included in the target project.
At last, pass this directory containing *gnat.gpr* to the gprbuild by the switch ``-aP`` or the enviromment variable ``GPR_PROJECT_PATH``.

*gnat.gpr* indicates this directory.
*c.gpr* indicates the translated headers (*c-\*.ads*) and is needed to make gprbuild understood that the translated headers should not be recompiled.

Third way
~~~~~~~~~

Of course you can directly copy these files into the directory of the target project.

Limitations
-----------

Many features are unimplemented and impossible to emulate perfectly.

.. _`The GNAT Library`: https://gcc.gnu.org/onlinedocs/gnat_rm/The-GNAT-Library.html
.. _drake: https://github.com/ytomino/drake
.. _gprbuild: http://docs.adacore.com/live/wave/gprbuild/html/gprbuild_ug/gprbuild_ug.html
