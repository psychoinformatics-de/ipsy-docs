The Command Line
****************
:order: 610

The shell (sometimes also called a terminal, console, or CLI) is an interactive,
text based interface. If you have used Matlab or IPython, then you are already
familiar with the basics of a command line interface.

While the initial learning curve is steeper for the command line, the rewards
are well worth it. Command line programs tend to be faster, more flexible, and
more scalable than their GUI counterparts.

Syntax
------
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
--------------
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

.. _Section on Permissions: #permissions

Redirection
-----------
Now that you know some of the basic shell commands, it's time to introduce some
core shell concepts.

The output that commands print to the screen can also be redirected into a file
or used as the input to an another program.

``>``
  ``>`` writes the output of a command to a file. If the file already exists, it
  will overwrite the contents. For example:

  .. code::

    echo "What did the llama say when asked to go on a picnic?" > lame_joke.txt

  Or, more practically, the output of a long running search.

  .. code::

    find /home/data/psyinf -t f -name "\*.fsf" -print > ffs_these_fsf.txt

``>>``
  ``>>`` appends the output to a file. If the file doesn't exist, it will
  create it.

  .. code::

    echo "Great! Alpaca lunch!" >> lame_joke.txt

``|``
  ``|`` (pipe) redirects the output of a command and uses it as the input for
  the next command. For example, the following will send the output of ``echo``
  to ``sed``, which replaces "fellow" with "good looking".

  .. code::

    echo "hello there, fellow" | sed "s/fellow/good looking/"

  More practically, the following command calculates the size of each file and
  folder in ``/tmp``. The output is then sorted by size.

  .. code::

    du -sh /tmp/* | sort -h

The Prompt
----------
When you first login on the command line, you are greeted with "the prompt", and
it will likely look similar to this::

  aqw@medusa:~$

This says I am the user ``aqw`` on the machine ``medusa`` and I am in the folder
``~``, which is shorthand for the current user's home folder (in this case
``/home/aqw/``).

The ``$`` sign indicates that the prompt is interactive and awaiting user input.
[#prompt]_ In documentation, ``$`` is commonly used as a shorthand for the
prompt, and allows the reader to quickly differentiate between lines containing
commands vs the output of those commands. For example:

.. code::

  $ ls -la wombats.txt
  -rw-rw---- 1 aqw psyinf 6 Nov 29 10:00 wombats.txt

Paths
-----
Let's say I want to create a new folder in my home folder, I can run the
following command::

  mkdir /home/aqw/awesome_project

And that works. ``/home/aqw/awesome_project`` is what is called an absolute
path. It defines the folder name with no ambiguity.

However, much like in language, using someone's full proper name every time
`would be exhausting <https://www.youtube.com/watch?v=koZFca8AkT0>`_, and so
pronouns are used.

This shorthand is called relative paths, because they are defined (wait for
it...) relative to your current location on the file system.

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
``/home/aqw/`` I have added a folder for my current project,
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

Now let's say I want to change from my home directory ``/home/aqw/`` into the
``code/`` folder of the project. I could use absolute paths::

   cd /home/aqw/awesome_project/aligned/code

But that is a bit wordy. It is much easier with a relative path::

   cd awesome_project/aligned/code

**Relative** to my starting location (``/home/aqw/``), I navigated into the
subfolders; note how the relative path does not start with a ``/``.

I can change back to my home directory also with a relative path::

   cd ../../../

The first ``../`` takes me from ``code/`` to its parent ``aligned/``, the second
``../`` to ``awesome_project/``, and the last ``../`` back to my home directory
``aqw/``.

However, since I want to go back to my home folder, it's always fastest to run::

  cd ~

Globbing
--------
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

  mv -v *.txt such_text/

Globbing also can nest through directories. For example, assuming a typical
folder structure for subject data, you can list every subject's functional
``.nii.gz`` files for run 1::

  ls sub-*/func/*_run-1_*.nii.gz

You can read about more about Pattern Matching in `Bash's Docs
<https://www.gnu.org/software/bash/manual/bashref.html#Pattern-Matching>`_.

Permissions
-----------
Every file and folder has permissions which determine which users are allowed to
read, write, and execute it.

.. code::

  $ ls -la test.txt
  -rw-rw---- 1 aqw psyinf 6 Nov 29 10:00 wombats.txt

The ``-rw-rw----`` provides all the information about this file's permissions.
The left-most ``-`` indicates whether it's a file, a folder (``d``), a symlink
(``l``), etc. The rest are three tuplets of ``---``. The first tuplet is for the
user, the second tuplet is for the group, the last tuplet is for all other others.

The above example shows that both the user (``aqw``) and the group (``psyinf``)
have read and write permissions (``rw-``) to ``wombats.txt``. All other users on
the system have no permissions (``---``).

Let's say I don't want others in the ``psyinf`` group to have write permissions
anymore.

.. code::

  $ chmod g-w wombats.txt
  $ ls -lah wombats.txt
  -rw-r----- 1 aqw psyinf 6 Nov 29 10:00 wombats.txt

.. class:: todo

  **TODO:** explain chmod 640 vs chmod g-w

  **TODO:** discuss (and show how to set UMASK)

  **TODO:** discuss user-private groups, sticky bit

  **TODO:** point to a more exaustive explanation and/or man page

Useful Commands
---------------
``man <command_name>``
  show the manual (documentation) for a command
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

  **TODO:** ``tmux`` (different section/page?)

Piping Fun
----------
``du -sh ./* | sort -h``
  calculate the size of each of the files and folders that are children of the
  current folder, and then sort by size
``find ./ -mmin -60 | wc -l``
  find all files under the current directory that have been modified in the last
  60 minutes, and then count how many are found
``ls -lah ~/ | less``
  list all files in your home folder and display them one page at a time

Text Editors
------------
Text editors are a crucial tool for any Linux user. You will often find the need
for one, whether it is to quickly edit a file or write a collection of analysis
scripts.

Religious wars have been fought over which is "the best" editor. From the
smoldering ashes, this is the breakdown:

``nano``
  Easy to use; medium features. If you don't know which to use, start with this.
``vim``
  Powerful and light; lots of features and many plugins; steep learning curve.
``emacs``
  Powerful; tons of features; huge ecosystem (email client, browser, etc);
  advanced learning curve.

.. class:: todo

  **TODO:** link to vim plugins

Shells
------
.. class:: todo

  **TODO:** bash

  **TODO:** zsh

  **TODO:** tab completion (gifs?)

  **TODO:** history (up and searching)

  **TODO:** perhaps link to prezto, etc

Footnotes
---------

.. [#human] By default, file sizes are printed in Bytes. The ``-h`` flag changes
   this to units sane for human consumption. For example: 137216 would instead
   be listed as 134K. And for those brains rioting right now, remember,
   computers are binary, so 1K is 1024 bytes (2\ :sup:`10`), not 1000 (10\
   :sup:`3`).
.. [#prompt] The ``#`` symbol is commonly used to indicate a prompt with
   elevated permissions (such as the ``root`` user).
