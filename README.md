
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

This fork contains 2 main changes:

1. Fixes for [SDL Bugzilla](https://bugzilla.libsdl.org/) issues
   [2570](https://bugzilla.libsdl.org/show_bug.cgi?id=2570) and
   [3145](https://bugzilla.libsdl.org/show_bug.cgi?id=3145).
2. A script to create pre-built SDL libraries for Android, as described in
   [SDL Bugzilla](https://bugzilla.libsdl.org/) issue [2839](https://bugzilla.libsdl.org/show_bug.cgi?id=2839)
   
These fixes are needed by the [KTX project](https://github.com/KhronosGroup/KTX);
this fork provides the source it uses.

Pulling From Mercurial
----------------------

If you want to pull libSDL 2.0.4 from the upstream Mercurial repo,
first of all install [Mercurial](http://mercurial.selenic.com/)
and then `git-remote-hg`.

The example below copies `git-remote-hg` to `/usr/local/bin`. Note
this URL is a fork with fixes for compability with Mercurial 3.2+.
Applying `s/fingolfin/felipec/` on the URL gives the upstream origin.

```bash
sudo curl -o /usr/local/bin/git-remote-hg https://raw.githubusercontent.com/fingolfin/git-remote-hg/master/git-remote-hg
sudo chmod +x /usr/local/bin/git-remote-hg
```

If on OS X you need to ensure you have a link to `python2` in your
`$PATH`. Some distributions of Python 2 create this link, some do
not. As a last resort you can edit `git-remote-hg` and change the
first line
```
- #!/usr/bin/env python2
+ #!/usr/bin/env python
```

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

:warning: It may take some time.
