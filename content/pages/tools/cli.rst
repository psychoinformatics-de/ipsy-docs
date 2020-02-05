The Command Line
################
:order: 530

The shell (sometimes also called a terminal, console, or CLI) is an interactive,
text based interface. If you have used Matlab or IPython, then you are already
familiar with the basics of a command line interface.

While the initial learning curve can be steep, the rewards are well worth it.
Command line programs tend to be faster, more flexible, and more scalable than
their GUI counterparts.

Syntax
******
Commands are case sensitive and follow the syntax of:
``command [options...] <arguments...>``. The options modify the behavior of
the program, and are usually preceded by ``-`` or ``--``. For example:

.. code::

  ls -l test.txt

``ls`` is the *command*. The *option* ``-l`` tells ``ls`` to display more
information. ``test.txt`` is the *argument* — the file that ``ls`` is listing.

Every command has many options (often called "flags") that modify their
behavior. There are too many to even consider memorizing. Remember the ones you
use often, and the rest you will lookup in their documentation or via your
favorite search engine.

Basic Commands
**************
``pwd``
  print the name of the folder you're currently in
``ls -lah <folder>``
  list the contents of a folder, including hidden files (``-a``), and all their
  information (``-l``); print file sizes in human readable units
  (``-h``) [#human]_
``cd <folder>``
  change to another folder
``cp <from> <to>``
  copy a file
``cp -R <from> <to>``
  copy a folder and its contents (``-R``)
``mv <from> <to>``
  move/rename a file or folder
``rm <file>``
  delete a file
``rm -Rv <folder>``
  delete a folder and its contents (``-R``) and list each file as it's being
  deleted (``-v``)
``mkdir <folder>``
  create a folder
``rmdir <folder>``
  delete an empty folder
``chmod -R g+rwX <folder>``
  give group members (``g+``) read, write (``rw``), and execute if already
  present for others (``X``) permissions for a folder and all of its contents
  (``-R``);
  see the `Section on Permissions`_ for more info.
``chown -R <username> <folder>``
  change the owner of a folder and all of its contents (``-R``);
  see the `Section on Permissions`_ for more info.
``chgrp -R <groupname> <folder>``
  change the group of a folder and all of its contents (``-R``);
  see the `Section on Permissions`_ for more info.
``echo "text"``
  print text to the screen
``man <command_name>``
  show the manual (documentation) for a command

.. _Section on Permissions: #permissions

Redirection
***********
Now that you know some of the basic shell commands, it's time to introduce some
core shell concepts.

The output that commands print to the screen can also be redirected into a file
or used as the input to an another program.

``>``
  ``>`` writes the output of a command to a file. If the file already exists, it
  will overwrite the contents. For example:

  .. code::

    echo 'Uhh, what kind of music do you usually have here?' > blues_brothers_reference.txt

  Or, more practically, the output of a long running search.

  .. code::

    find /home/data/exppsy -type f -name "*.fsf" -print > ffs_these_fsfs.txt

``>>``
  ``>>`` appends the output to a file. If the file doesn't exist, it will
  create it.

  .. code::

    echo 'Oh, we got both kinds. We got country *and* western!' >> blues_brothers_reference.txt

``|``
  ``|`` (pipe) redirects the output of a command and uses it as the input for
  the next command. For example, the following will send the output of ``echo``
  to ``sed``, which replaces "stranger" with "good looking".

  .. code::

    echo 'Well hello there, stranger. <wink>' | sed 's/stranger/good looking/g'

  More practically, the following command calculates the size of each file and
  folder in ``/tmp``. The output is then sorted by size.

  .. code::

    du -sh /tmp/* | sort -h

.. class:: todo

  **TODO:** stdout and stderr

.. class:: todo

  **TODO:** explain clobbering and >|

The Prompt
**********
When you first login on the command line, you are greeted with "the prompt", and
it will likely look similar to this::

  aqw@medusa:~$

This says I am the user ``aqw`` on the machine ``medusa`` and I am in the folder
``~``, which is shorthand for the current user's home folder (in this case
``/home/aqw``).

The ``$`` sign indicates that the prompt is interactive and awaiting user input.
[#prompt]_ In documentation, ``$`` is commonly used as a shorthand for the
prompt, and allows the reader to quickly differentiate between lines containing
commands vs the output of those commands. For example:

.. code::

  $ ls -la wombats.txt
  -rw-rw---- 1 aqw psyinf 6 Nov 29 10:00 wombats.txt

Paths
*****
Let's say I want to create a new folder in my home folder, I can run the
following command::

  mkdir /home/aqw/awesome_project

And that works. ``/home/aqw/awesome_project`` is what is called an absolute
path. Absolute paths *always* start with a ``/``, and define the folder's
location with no ambiguity.

However, much like in spoken language, using someone's full proper name every
time `would be exhausting <https://www.youtube.com/watch?v=koZFca8AkT0>`_, and
thus pronouns are used.

This shorthand is called relative paths, because they are defined (wait for
it...) relative to your current location on the file system. Relative paths
*never* start with a ``/``.

``.``
  the *current* directory
``..``
  the *parent* directory
``~``
  the current user's home directory

So, taking the above example again: given that I am in my home folder, the
following commands all would create the new folder in the exact same place.

.. code::

  mkdir /home/aqw/awesome_project
  mkdir ~/awesome_project
  mkdir awesome_project
  mkdir ./awesome_project

To demonstrate this further, consider the following: In my home directory
``/home/aqw`` I have added a folder for my current project,
``awesome_project/``. Let's take a look at how this folder is organized:

.. code::

  └── home
      └── aqw
           └── awesome_project
              ├── aligned
                  ├── code
              └── sub-01
                  └── bold3T
              └── sub-02
                  └── bold3T
              ├── ...
              └── sub-xx
                  └── bold3T
          └── structural
              └── sub-01
                  └── anat
              └── sub-02
                  └── anat
              ├── ...
              └── sub-xx
                  └── anat

Now let's say I want to change from my home directory ``/home/aqw`` into the
``code/`` folder of the project. I could use absolute paths::

  cd /home/aqw/awesome_project/aligned/code

But that is a bit wordy. It is much easier with a relative path::

  cd awesome_project/aligned/code

**Relative** to my starting location (``/home/aqw``), I navigated into the
subfolders.

I can change back to my home directory also with a relative path::

  cd ../../../

The first ``../`` takes me from ``code/`` to its parent ``aligned/``, the second
``../`` to ``awesome_project/``, and the last ``../`` back to my home directory
``aqw/``.

However, since I want to go back to my home folder, it's much faster to run::

  cd ~

Globbing
********
Most modern shells have powerful pattern matching abilities (often called
globbing) that allows you to match the names of multiple files and/or
directories. This is especially useful when running a command on many files at
once. When globbing, the shell compares the pattern to files on the file system
and expands the term to all matching file names.

The most basic pattern is ``*``, which matches any number of any character(s).

For example, the following will list all files in the current directing ending
in ``.txt``::

  ls *.txt

Or, lets you move a bunch of ``.jpg`` files into a folder::

  mv -v *.jpg annoying_instagram_food_pics/

Globbing can also nest through directories. For example, assuming a typical
folder structure for subject data, you can list every subject's functional
``.nii.gz`` files for run 1::

  ls sub-*/func/*_run-1_*.nii.gz

You can read about more about Pattern Matching in `Bash's Docs
<https://www.gnu.org/software/bash/manual/bashref.html#Pattern-Matching>`_.

Permissions
***********
Every file and folder has permissions which determine which users are allowed to
read, write, and execute it.

.. code::

  $ ls -la wombats.txt
  -rw-rw---- 1 aqw psyinf 6 Nov 29 10:00 wombats.txt

The ``-rw-rw----`` provides all the information about this file's permissions.
The left-most ``-`` indicates whether it's a file, a folder (``d``), a symlink
(``l``), etc. The rest are three tuplets of ``---``. The first tuplet is for the
user, the second tuplet is for the group, the last tuplet is for all other users.

The above example shows that both the user (``aqw``) and the group (``psyinf``)
have read and write permissions (``rw-``) to ``wombats.txt``. All other users on
the system have no permissions (``---``).

Let's say I don't want others in the ``psyinf`` group to have permission to write
to ``wombats.txt`` anymore.

.. code::

  $ chmod g-w wombats.txt
  $ ls -lah wombats.txt
  -rw-r----- 1 aqw psyinf 6 Nov 29 10:00 wombats.txt

.. class:: todo

  **TODO:** explain chmod 640 vs chmod g-w

  **TODO:** discuss (and show how to set UMASK)

  **TODO:** discuss user-private groups, sticky bit

  **TODO:** point to a more exhaustive explanation and/or man page

Useful Commands
***************
``ssh <username>@<servername>``
  log into an interactive shell on another machine
``passwd``
  change your password
``rsync -avh --progress from_folder/ <user>@<server>:/destination/folder``
  sync/copy from a local folder to a folder on a remote server via SSH. Will
  preserve all permissions, checksum all transfers, and display its progress.
``grep -Ri <term> <folder>``
  case-insensitive search for a term for all files under a folder
``htop``
  overview of computer's CPU/RAM and running processes
``pip install --user <python_pip_package>``
  install Python packages into your home folder
``sed -i "s/oops/fixed/g" <file>``
  replace all occurrences of 'oops' with 'fixed' in a file
``wget <link>``
  download a file
``find <folder> -type d -exec chmod g+s {} \;``
  find all folders underneath a directory and apply the "sticky bit" to them;
  see the `Section on Permissions`_ for more info.
``du -sh <folder>``
  print how much disk space a folder uses
``cat <file>``
  print the contents of a file to the screen
``head -n 20 <file>``
  show the first 20 lines of a file
``tail -n 10 <file>``
  show the last 10 lines of a file
``tail -f <file>``
  print the last 10 lines of a file, and continue to print any new lines added
  to the file (useful for following log files)
``less <file>``
  print the content of a file to the screen, one screen at a time. While ``cat``
  will print the whole file, regardless of whether it fits the terminal size,
  ``less`` will print the first lines of a file and let you navigate forward
  and backward
``ln -s <target> <link_name>``
  create a symlink (a shortcut)

.. class:: todo

  **TODO:** ``sudo``

  **TODO:** ``unzip/tar/gzip``

  **TODO:** ``sshfs`` (different section/page?)

Piping Fun
**********
``du -sh ./* | sort -h``
  calculate the size of each of the files and folders that are children of the
  current folder, and then sort by size
``find ./ -mmin -60 | wc -l``
  find all files under the current directory that have been modified in the last
  60 minutes, and then count how many are found
``ls -lah ~/ | less``
  list all files in your home folder and display them one page at a time

Text Editors
************
Text editors are a crucial tool for any Linux user. You will often find the need
for one, whether it is to quickly edit a file or write a collection of analysis
scripts.

Religious wars have been fought over which is "the best" editor. From the
smoldering ashes, this is the breakdown:

``nano``
  Easy to use; medium features. If you're unsure of what to use, start with this.
``vim``
  Powerful and light; lots of features and many plugins; steep learning curve.
  Two resources to help get the most out of vim are the ``vimtutor`` program
  (already installed on on the cluster) and `vimcasts.org <http://vimcasts.org>`_.
``emacs``
  Powerful; tons of features; written in Lisp; huge ecosystem; advanced learning
  curve.

Shells
******
Whenever you use the command line on a Unix-based system, you do that in a
command-line interpreter that is referred to as a **shell**.

The shell is used to start commands and display the output of those commands. It
also comes with its own primitive (yet surprisingly powerful) scripting
language. [#shell]_

Many shells exist, though most belong to a family of shells called "Bourne
Shells" that descend from the original ``sh``. This is relevant, because they
share (mostly) a common syntax.

Common shells are:

**bash**
  The bourne-again shell (``bash``) is the default shell on many \*nix systems
  (most Linux distros, MacOS).

**zsh**
  The Z shell comes with many useful features, such as: shared history across
  running shells, substring search for history, smarter tab-completion, spelling
  correction, and better theming.

**tcsh**
  The C shell (both ``csh`` and ``tcsh``) is deprecated and should not be used.
  Some legacy systems use it, but is strongly encouraged to switch to either
  ``zsh`` or ``bash``. Comparatively, C shell has a limited feature set.  But
  most importantly, it is *not* a member of the Bourne family of shells, and
  thus uses a different syntax.

To determine what shell you're in, run the following::

  echo $SHELL

.. class:: todo

  **TODO:** history (up and searching), zsh history substring search

Tab Completion
**************
One of the best features ever invented is **tab completion**. Imagine your
spirit animal. Now imagine that animal sitting on your shoulder and shouting
"TAB!" every time you've typed the first 3 letters of a word. Listen to your
spirit animal's voice.

Tab completion autocompletes commands and paths when you press the ``Tab`` key.
If there are multiple matching options, pressing ``Tab`` twice will list them.

The greatest advantage of tab completion is not increased speed (though that is
a nice benefit) but rather the near elimination of typos — and the resulting
reduction of cognitive load. You can actually focus on the task you're working
on, rather than your typing.

For an example of tab-completion with paths, consider the following directory
structure:

.. code::

  ├── Desktop
  ├── Documents
  │   ├── my_awesome_project
  │   └── my_comics
  │      └── xkcd
  │      │   └── is_it_worth_the_time.png
  ├── Downloads

You're in your home directory, and you want to navigate to your `xkcd
<https://xkcd.com/1205/>`_ comic selection in ``Documents/my_comics/xkcd``.
Instead of typing the full path error-free, you can press ``Tab`` after the
first few letters. If it is unambiguous, such as ``cd Doc <Tab>``, it will
expand to ``cd Documents``. If there are multiple matching options, such as
``cd Do``, you will be prompted for more letters. Pressing ``Tab`` again will
list the matching options (``Documents`` and ``Downloads`` in this case).

A visual example of tab-completion in action:

.. raw:: html

  <img src="http://upload.wikimedia.org/wikipedia/commons/a/ad/Command-line-completion-example.gif"/>

There are more sophisticated completion scripts, but they are not always enabled
by default. For example, ``git add -p <TAB>`` will list only modified files.
``zsh`` can expand multiple levels at a time: ``cd d/m/x <TAB>`` will complete
to ``cd Documents/my_comics/xkcd``.

----

.. [#human] By default, file sizes are printed in Bytes. The ``-h`` flag changes
   this to units sane for human consumption. For example: 137216 would instead
   be listed as 134K. And for those brains rioting right now, remember,
   computers are binary, so 1K is 1024 bytes (2\ :sup:`10`), not 1000 (10\
   :sup:`3`).
.. [#prompt] The ``#`` symbol is commonly used to indicate a prompt with
   elevated permissions (such as the ``root`` user).
.. [#shell] As always, the man page (``man bash``) is a great reference. But if
   you're interested in acquiring a deep understanding of shell, then I *highly*
   recommend "Beginning Portable Shell Scripting" by Peter Seebach.
