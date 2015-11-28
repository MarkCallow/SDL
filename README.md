
Simple DirectMedia Layer 
========================

This is a fork of the [SDL Mercurial repository](http://hg.libsdl.org/SDL) at
http://hg.libsdl.org/SDL.

Branch `upstream_master` reflects the most recent pull from that repo.
The tip at the time was http://hg.libsdl.org/SDL/rev/84285c1d8ca4.

See [below](pulling_from_mercurial) for instructions on pulling from
the [SDL Mercurial repository](http://hg.libsdl.org/SDL)

What is Different Here
----------------------

This fork contains 2 main changes from SDL 2.0.4:

1. Fixes for [SDL Bugzilla](https://bugzilla.libsdl.org/) issues
   [2570](https://bugzilla.libsdl.org/show_bug.cgi?id=2570) and
   [3145](https://bugzilla.libsdl.org/show_bug.cgi?id=3145). These allow
   * allow applications on Windows and X11 to hint that they want to use a
   linked OpenGL ES library even if the OpenGL driver supports OpenGL ES
   context creation.
   * prevent a failure to create an OpenGL ES context when the requested
   version is greater than that supported by the OpenGL driver even though
   a suitable OpenGL ES library is available.
2. A script to create pre-built SDL libraries for Android, as described in
   [SDL Bugzilla](https://bugzilla.libsdl.org/) issue [2839](https://bugzilla.libsdl.org/show_bug.cgi?id=2839)
   
These fixes are needed by the [KTX project](https://github.com/KhronosGroup/KTX);
this fork provides the source it uses.

Pulling from Mercurial
----------------------

If you want to pull libSDL 2.0.4 from the upstream Mercurial repo,
you need to

* install [Python 2](https://www.python.org/downloads/).
* install [Mercurial](http://mercurial.selenic.com/)
* install `git-remote-hg`.

### Installing `git-remote-hg`

`git-remote-hg` can be installed from this
[GitHub project](https://github.com/fingolfin/git-remote-hg).

:o: Note: this is a fork of the original project with fixes for compability with
Mercurial 3.2+.

:bangbang: `git-remote-hg` does not work properly with Git for Windows.
A fix is awaiting merge into the project.

The example installation commands below copy `git-remote-hg` to `/usr/local/bin`.
 
```bash
sudo curl -o /usr/local/bin/git-remote-hg https://raw.githubusercontent.com/fingolfin/git-remote-hg/master/git-remote-hg
sudo chmod +x /usr/local/bin/git-remote-hg
```

You need to ensure you have `python2` in your `$PATH`. On OS X,
some distributions of Python 2 create this as a link to `python`,
some do not. The Windows installer does not create this link. One
solution is to make a copy of `%SystemDrive%\Python27\python.exe`
(the default install location), e.g.

```bash
cp $SYSTEMDRIVE/Python27/python.exe /usr/local/bin
```

As a last resort you can edit `git-remote-hg` and change the
first line

```
- #!/usr/bin/env python2
+ #!/usr/bin/env python
```

### Pulling the Source

Once Mercurial and `git-remote-hg` are installed, make sure you
have the following remote defined

```bash
git remote add upstream hg::http://hg.libsdl.org/SDL
```

and set upstream for the `upstream_master` branch

```bash
git branch --set-upstream-to upstream/master
```

Once all this is set up you can simply do

```bash
git checkout upstream_master
git pull
```

:heavy_exclamation_mark: Warning: The first pull may take some time.

{# vim: set ai ts=4 sts=4 sw=2 expandtab textwidth=75:}

