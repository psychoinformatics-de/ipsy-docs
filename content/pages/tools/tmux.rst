tmux
####
:order: 580

``tmux`` is a tool to manage terminal sessions.  For those familiar with
``screen``, tmux is a more featureful and better maintained alternative.

The primary functionality discussed here is tmux's ability to detach and
re-attach sessions, without affecting the programs running within the session.
When using unstable network connections (such as bad wifi), this can save you
significant frustration. If the VPN or SSH connection drops, you can just
reconnect and reattach the tmux session without losing any of your work.

tmux has many other useful features, including displaying multiple terminals at
once by splitting the window into panes. In addition to the man page (``man
tmux``), the `The Tao of Tmux`_ (especially chapters 7 and 11) is a popular
reference. The Linux Academy also offers a convenient `tmux cheat sheet`_, to
help with frequently used tmux commands and keybindings.

.. _The Tao of tmux: https://leanpub.com/the-tao-of-tmux/read
.. _tmux cheat sheet: https://2rwky424s9rd179jmbzqsca1-wpengine.netdna-ssl.com/wp-content/uploads/2016/08/tmux-3-1.png

Example
*******
As a practical example, let's run tmux on ``medusa``::

  aqw@medusa:~$ tmux

And to celebrate creating our first tmux session, let's run ``cmatrix``::

  cmatrix

That's one Keanu "whoa". Our terminal is now state-of-the-art 1999.

Sessions in tmux can be detached and reattached, without interrupting the
program running inside. To detach, type ``ctrl`` + ``b``, and then type ``d``.
Your session is detached, and you're back at the prompt. When we reattach,
``cmatrix`` will still be running, right where we left it::

  tmux attach

Let's detach again from our current session (``ctrl`` + ``b`` then ``d``), and
create another session. This one we'll name, for convenience (and style)::

  tmux new -s inigo_montoya

And we're in a *new* tmux session, this one named "inigo_montoya". Let's detach
(you should be getting good at this now). At the prompt, list the running tmux
sessions:

.. code::

  aqw@medusa:~$ tmux list-sessions
  0: 1 windows (created Sun Apr 28 13:09:06 2019) [119x39]
  inigo_montoya: 1 windows (created Sun Apr 28 14:00:29 2019) [119x39]

Session ``0`` is the first tmux session we created (with ``cmatrix`` running in
it). ``inigo_montoya`` is the session we just created. To attach a specific
session, run::

  tmux attach -t inigo_montoya

Sessions can be quit either by typing ``exit`` from within the session, or with
``kill-session``::

  tmux kill-session -t 0
  tmux kill-session -t inigo_montoya
