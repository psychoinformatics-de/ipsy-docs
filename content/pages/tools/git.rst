Git
###
:order: 540

Git enables you to track the changes made to files over time — specifically:
what changed, by whom, when, and why. It also gives you the capability to revert
files back to a previous state. Over time, as your project evolves, you can edit
your files with confidence knowing that at any point you can look back and
recover a previous version.

Install
*******
**Debian/Ubuntu**
  .. code::

    sudo apt install git

**macOS**
  Download the installer at: `<https://git-scm.com/download/mac>`_

**Windows**
  Download the installer at: `<https://git-scm.com/download/win>`_

Configure
*********
Once Git is installed, configure it with your name and email address. This lets
Git know who you are so it can associate you with the commits you make.

.. code::

  git config --global user.name "Wiggly McWidgit"
  git config --global user.email wiggity-wiggity-wack@example.com

Repository Anatomy
******************
A **git repository** is just a folder that git is tracking the changes in. All
of the behind-the-scenes information and metadata that allows git to perform its
magic is stored in the ``.git/`` folder in top folder of your project.

There are two types of files for git: **tracked** and **untracked** files.
Tracked files are files that git is aware of (via ``git add``).  Only tracked
files are considered part of the repository, and thus only tracked files have
the special powers-of-git bestowed upon them: history, commit messages, and
ability to share/merge history through ``git push`` and ``git pull``. Untracked
files are just the normal file-experience: no history, no reverting, no easy
sharing, etc.

Git has three different states for tracked files:

**modified**
  The file has been modified. The changes are not (yet) part of your project's
  history.

**staged**
  Modified content which is **staged** to be **committed**, but is not yet
  committed. The staging step is so that you can review whether the changes
  should be committed and to be able to stage multiple changes/files for a
  commit. Content is staged using ``git add``/``git add -p``.

**committed**
  The content is stored in your history. Content is committed using the ``git
  commit`` command.

Basic Commands
**************
``git init``
  Creates a repository in this folder. Note, no files are tracked (``git
  add``-ed yet.

``git clone <url> | <user@server:/path/to/repo.git>``
  Makes a full copy of an existing `git repository
  <https://help.github.com/articles/github-glossary/#repository>`_ — all
  files, folders, changes, history, etc.

``git status``
  Lists which files are in which state — if there have been changes made, new
  files added or deleted, etc.

``git add <file>``
  To begin tracking a new file. Once you run ``git add``, your file will be
  tracked and **staged** to be committed.

  ``git add -p``
    Review the changes you've made to tracked files, and choose which changes
    will be **staged**.

``git commit``
  Commits all the **staged** changes (see ``git add``). It will prompt you for a
  **commit message**, which should be a terse but descriptive note about the
  changes contained in the commit. These commit messages are your project's
  history.

``git rm <file>``
  Deletes the file, and stages the deletion. Note that the file and its contents
  remain in the project history, and can be recovered.

``git mv <file-from> <file-to>``
  Moves/renames a file and stages the rename.

``git log``
  Lists your commit history. It's not as user-friendly or easy-to-navigate as
  ``tig``.

``tig``
  A text-mode interface for git that allows you to easily browse through your
  commit history. It is not part of git and needs to be installed (``apt
  install tig`` for Debian/Ubuntu; `Homebrew instructions
  <https://github.com/jonas/tig/blob/master/INSTALL.adoc#installation-using-homebrew>`_
  for macOS)

``git push``
  Push your local changes to another repository, for example on GitHub.

``git pull``
  Pull changes from another repository to your local repository.

GitHub
******
GitHub is an online platform where you can store and share your projects; it is
especially well suited for working on a project with several other people. It
acts as a central place where everyone can access/contribute to the project and
offers several useful tools (issues, wikis, project milestones, user management,
etc) that make collaboration simple and easy.

To create a profile, go to `GitHub
<https://github.com/join?source=header-home>`_, and from there, follow the
prompts to create your account.

GitLab
******
GitLab is much like GitHub, but is open source and can be hosted by anyone.

Pull Requests
*************
Platforms like GitHub and GitLab enable **pull requests** (called a **merge
request** on GitLab) to propose and collaborate on changes to a repository. A
typical pull request workflow looks like this:

#. On the platform of your choice, **fork** the repository you want to
   contribute to (commonly called "upstream"). This creates a copy of the
   upstream repository under your user account, to freely make changes without
   affecting the original project.

#. **Clone** your fork of the repository on your local machine.

#. Create a new **branch** in your local clone (``git checkout -b mybranch
   master``).

#. Make your changes locally and commit them.

#. **Push** your changes to your fork.

#. On GitHub/GitLab, go to your fork, select the new branch, and create a **pull
   request** to the upstream repository.

The above works well for your first PR. But what if you worked on other projects
for a few months, upstream development has continued, and now you want to
propose another change to the current upstream code?

#. Add the upstream repository as a **remote** on your local clone
   (``git remote add upstream <url>``). Note, this only has to be done once.

#. **Fetch** the latest changes from upstream (``git fetch upstream``).

#. Create a new **branch** in your local clone, based on upstream's master
   branch (``git checkout -b mybranch upstream/master``).

#. Then proceed as usual, making your local changes, committing, pushing to your
   fork, and then opening a PR through the web UI.

The following diagram can help visualize how the above steps work together.

.. image:: /img/git_PR.png

Resources
*********
GitHub offers an `interactive Git tutorial
<https://try.github.io/levels/1/challenges/1>`_ that is a great starting point
for beginners.

Atlassian provides a nice overview of both the `forking workflow <https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow>`_.
and `Pull Request workflow <https://www.atlassian.com/git/tutorials/making-a-pull-request>`_
that are common in our projects and the wider Open Source community.

The free `Pro Git Book <https://git-scm.com/book/en/v2>`_ covers just about
everything Git has to offer using clear and easy-to-understand language. It
starts with the basics, but builds up to some of Git's more complex features.

If you like video tutorials, the `Intro to Git and GitHub
<https://youtu.be/PFwUHTE6mFc>`_ and `The Basics of Git and GitHub
<https://youtu.be/u6G3fbmpWr8>`_ videos are worth watching to learn about the
basics of Git and GitHub and want a step-by-step explanation of how to get
started.

For any questions you might have about using GitHub, see `GitHub Help
<https://help.github.com/>`_.

The `Git Reference Manual <https://git-scm.com/docs>`_ is the official docs for
Git. It has all the information you could want to know about Git, but is pretty
dense and better suited for intermediate and advanced users.
