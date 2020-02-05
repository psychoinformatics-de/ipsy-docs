SSH
###
:order: 575

SSH is used to securely login to a machine over the network. It is most commonly
used to start an interactive shell on the remote server, but many commands (such
as ``rsync`` and ``scp``) are capable of using the SSH protocol to securely
transfer bulk data.

SSH comes installed by default on all modern machines (Linux, macOS, and Windows
10).

Using SSH
*********
Logging into a remote machine is quite simple with SSH:

.. code::

    ssh username@medusa.ovgu.de

If it is the first time that you have connected to this server with SSH, you
will receive a prompt similar to the following:

.. code::

    The authenticity of host 'medusa.ovgu.de (141.44.17.54)' can't be established.
    ECDSA key fingerprint is SHA256:fgvO3iB0fUsVjbrXLhg8h8ZPZdXa55rnwR+9P72O7oU.
    Are you sure you want to continue connecting (yes/no/[fingerprint])?

Type "yes" to confirm the fingerprint (please see the `explanation of fingerprints <#fingerprints>`_
below).

Authenticate, and you now have an interactive session on the remote machine.

Keys
****
SSH also supports key-based authentication, which is much more secure than
password authentication.

It is a common misconception that using keys means that you don't need a
password. Though a key instead of a password is used to authenticate to the
server, a password is used to protect the key itself on your system (it is
possible to create keys that are not password protected, but it is considered
poor practice).

Protecting your key with a password is important. Otherwise, if someone accesses
your computer, they will gain access to every system that uses that key. That's
**bad** (technical term).

If you don't yet have an SSH key, generate one by running the following, and
follow the prompts:

.. code::

  ssh-keygen -t rsa -b 4096

Once you have a key, it can be copied to a server using ``ssh-copy-id``. For
example:

.. code::

  ssh-copy-id username@medusa.ovgu.de

X Forwarding
************
Graphical programs run on the remote server can be displayed on your local
machine using a feature called X Forwarding. To enable this, use the ``-X``
flag. For example:

.. code::

    ssh -X username@medusa.ovgu.de

However, X Forwarding comes with one major caveat: it is *very* sensitive to
latency, so it is only practical to use when on the same wired network as the
server (i.e. on campus).

X Forwarding also requires that your local machine has X installed. This is the
default on Linux systems, but macOS systems need to install `XQuartz`_ [#XquartzVersion]_
while Windows 10 systems need VcXsrv installed via WSL.

.. _XQuartz: https://www.xquartz.org/releases/XQuartz-2.7.7.html

Jump Hosts
**********
If you want to connect to a server that is on a private network, you will want
to use a Jump Host.

To explain, let's say we're robbing a bank (sometimes called "self financing" in
academia). The server ``vault`` isn't publicly available, but ``lobby`` is, so
we're going to connect to it first and use it as a jump host.

For example:

.. code::

    ssh -J username@lobby username@vault

This will first connect to ``lobby``, and then connect to ``vault``.

This is more convenient than manually SSHing (``ssh lobby`` followed
with ``ssh vault``), but **more importantantly**, it allows for the SSH keys
from the original computer to be used to authenticate to both servers.
Otherwise, you would need to store a copy of your keys on ``lobby``, which is
unsafe. They're called keys for a reason: keep them secret; keep them safe.

Agents
******
An agent (e.g. ``ssh-agent``) can be used to remember the password to unlock
your key, usually with a timeout. This can be quite convenient when connecting
frequently to servers.

.. class:: todo

   **TODO:** Discuss agents. ``ssh-agent`` is most often suggested, but its
   behavior is non-obvious, especially when compared to gpg-agent (which is an
   option when using RSA keys). On macOS, Apple keychain can be used.

Fingerprints
************
Each server has a unique *fingerprint* that identifies it.

In theory, when first connecting to a server, users should take great care to
verify that the fingerprint offered is authentic by confirming it against a
trusted copy via a different (preferably analog) communication channel (e.g.
phone). This allows you to be certain that you are indeed connecting to the
server that you think you are, and that no one is attempting a
`Man-in-the-Middle attack`_.

In reality (and unsurprisingly), the majority of users do not perform such
steps. However, fingerprints still have value, because SSH will notify you if
the server's fingerprint changes. This helps protect against future MITM
attacks. [#mitm]_

Your SSH client maintains a list of server fingerprints in the
``~/.ssh/known_hosts`` file.

.. _Man-in-the-Middle attack: https://en.wikipedia.org/wiki/Man-in-the-middle_attack

Config
******
SSH has many powerful options. If you want to use different keys for different
hosts, use jump hosts automatically when connecting to certain hosts, etc, then
you should read ``man ssh_config``. These options are all set in the
``~/.ssh/config`` file.

----

.. [#XquartzVersion] There have been some problems with recent XQuartz releases,
   but users have reported that version 2.7.7 works best for them. It is
   recommended to use that version until 2.7.12 is released.

.. [#mitm] As always, there are many details and nuances that make this
   technically untrue.  But it is a reasonable approximation for what a user's
   understanding of the situation should be.
