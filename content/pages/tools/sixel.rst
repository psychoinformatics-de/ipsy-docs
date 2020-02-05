sixel
#####
:order: 570

`Sixel <https://en.wikipedia.org/wiki/Sixel>`_ allows displaying graphics at the
command line; it's technology from the 80s that never made it — until quite
recently.

A picture is worth a thousand words:

.. image:: /img/sixel_sample.png

Utilities
*********
* ``img2sixel``
* `niicat <https://github.com/MIC-DKFZ/niicat>`_ (not yet installed on Medusa;
  users should install in a venv for now)

Setup
*****
Currently, very few terminals support sixel.

**macOS**
  Download and install `iTerm2`_. The built-in terminal does not support sixel.

**Linux**
  ``xterm`` is the recommended terminal for using sixel. None of the following
  popular terminals have in-tree support: GNOME Terminal, Konsole, urxvt, st.

  If you're using the `IPSY dotfiles </services/hosted/#dotfiles>`_ then
  everything should "just work". Otherwise, you will need to adjust your
  ``.Xresources`` settings.

.. _iTerm2: https://iterm2.com

Testing
*******
A test image is provided as part of the **IPSY dotfiles**::

  cat ~/.dotfiles/test/snake.six
