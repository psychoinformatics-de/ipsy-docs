Git/Github
**********
:order: 620

What is Git?
------------

Git is a distributed version control system that can significantly improve the
way you work and collaborate on projects. It allows you to track changes that
happen in a file or set of files over time. Git can also backup this history
through remote hosting services like GitHub.

What is GitHub?
---------------

GitHub is a code hosting platform for version control and collaboration. It lets
you and others work together on projects from anywhere.

Why use GitHub?
    - Online backup for version history.
    - Makes collaborating on projects with multiple people simple.
    - Easy to fork and contribute to existing projects.

GitHub offers free accounts for users and organizations working on public and
open source projects. It also offers a discount for educators and researchers
that you can apply for to get unlimited free private repositories. To learn more
or to apply, check out the `GitHub help page
<https://help.github.com/categories/teaching-and-learning-with-github-education>`_.

Getting Started
---------------

Getting set-up on GitHub is easy. Just go to `GitHub <https://github.com/>`_
to create a profile. From there, follow the prompts to create your personal
account.

Set up Git
----------

Git is responsible for everything GitHub-related that happens locally on your
computer. It uses the command line, but also has a desktop app to use with
Windows and Mac.

To use Git on the command line, you'll need to download, install, and configure
Git on your computer.

- `Download <https://git-scm.com/downloads>`_ and install the latest version of Git
- Set your `username <https://help.github.com/articles/setting-your-username-in-git/>`_
- Set your commit `email address <https://help.github.com/articles/setting-your-commit-email-address-in-git/>`_

If you want to work with Git locally, but don't want to use the command line,
you can instead download and install the `GitHub Desktop
<https://help.github.com/desktop/guides/getting-started-with-github-desktop/>`_ client.

Starting a New Project
----------------------

What is a Git repository?

They're easiest to imagine as a project's folder. A repository contains all of
the project files (including documentation), and stores each file's revision
history. Repositories can have multiple collaborators and can be either public
or private.

You typically obtain a Git repository in one of two ways:

1. You can take a local directory that is currently not under version control,
   and turn it into a Git repository.

   `How to create a repository
   <https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository>`_

2. You can fork/clone an existing Git repository from elsewhere.

   `How to fork a repository <https://help.github.com/articles/fork-a-repo/>`_

Introduction Videos
-------------------

If you're new to Git and GitHub, here are a couple videos to walk you through
the basics of using Git/GitHub and how to get started.

- `Intro to Git and GitHub <https://youtu.be/PFwUHTE6mFc>`_
- `The Basics of Git and GitHub <https://youtu.be/u6G3fbmpWr8>`_

Try it out
----------
Here's an `interactive terminal simulator
<https://try.github.io/levels/1/challenges/1>`_ to practice using git.

Basic Commands
--------------

``git init``
  Tells git this is a folder you want it to pay attention to and start tracking
  all the changes that happen in this folder.
``git status``
  To determine which files are in which state.
``git add``
  To begin tracking a new file or to add a set of changes to a file. Your file
  will now be tracked and staged to committed.
``git commit``
  Commits all the changes that you just made and then added to the staging area
  with git add. It's like an "are you sure you want to make these changes"
  dialog box. You leave a descriptive message each time (commit message) that
  explains the changes that you've made.
``git push``
  Takes the changes from your local machine and pushes them up to the repository
  on GitHub.
``git pull``
  Pulls changes from the GitHub repository onto your local machine.
``git clone``
  Makes a full copy of a whole git repository -- all files, folders, changes,
  history, etc.

Useful Help Pages and Video Guides
----------------------------------

`Git Cheat Sheet
<https://services.github.com/on-demand/downloads/github-git-cheat-sheet.pdf>`_

`Video Guides <https://www.youtube.com/githubguides>`_

`GitHub Help <https://help.github.com/>`_

`Git Docs <https://git-scm.com/docs>`_

`Pro Git Book <https://git-scm.com/book/en/v2>`_
