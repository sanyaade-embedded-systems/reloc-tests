This script was written by Chris Larson, and is under Mentor Graphics
Corporation's copyright.  It is used to check for relocation issues in
prebuilt binaries (originally packaged-staging, now sstate).  Of course, it
only exercises the things which are exercised in a typical build, so if recipe
A provides a script that recipe B doesn't run, clearly we won't catch any
issues in that script, but it's helpful nonetheless.

Instructions
------------

1. ``git clone --recursive https://github.com/kergoth/reloc-tests``
2. ``cd reloc-tests``
3. ``. ./setup.sh``
4. ``./tools/reloc-tests`` # defaults to testing up to poky-image-minimal


Known Issues
------------

- As it operates against a linear list of recipes, it can never be full proof.
  Our builds operate at a task level, and it's not as simple as this recipe,
  then that, then the next.  We can simply operate against the rough order in
  which the sstate packages are emitted.  Most of the time this works pretty
  well, but during the initial bootstrap recipes, things are so tightly
  interdependent that we can't really test them.
