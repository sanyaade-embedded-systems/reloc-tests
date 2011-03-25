This script was written by Chris Larson, and is under Mentor Graphics
Corporation's copyright.  It is used to check for relocation issues in
prebuilt binaries (originally packaged-staging, now sstate).

Implementation:

1. Pre-populates all the sstate packages leading up to the recipe you request
   on the command-line.
2. Generates .dot graphs leading to that recipe.
3. Uses the .dot to produce a linearized list of recipes.
4. Set aside the populated sstate and tmp directories for later use.
4. Iterate over this list of recipes, for each, using a different tmp
   directory than was used to pre-populate:

    1. Bake the recipe
    2. Clean the recipe
    3. Copy over the pre-populated sstate package(s) for this recipe,
       overwriting any which were produced in this build.

In this way, we ensure that we test a build of each recipe, with its
dependencies prebuilt from a different tmp directory, catching any relocation
issues that may exist with the build using the files from the pre-populated
area.  It builds up the recipe testing tmpdir and sstate incrementally, and
keeps track of the completed items, so will pick up where it leaves off if you
interrupt it.

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
- This only tests the functionality which is used by the build of our recipes.
  Clearly, if recipe B depends on A, and A includes a script which B does not
  run during its build process, we won't know if any relocation issues remain
  with this particular script.
