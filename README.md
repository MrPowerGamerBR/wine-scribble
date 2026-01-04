# wine-scribble

A Wine fork with some *very* hacky workarounds to patch and fix specific games.

This fork was made just for fun™, I wanted to learn a bit more how Wine works under the hood and, of course, because I find it very cool running games on Linux without relying on emulators (such as DOSBox-X, VirtualBox, etc).

Of course, just because I find it cool, doesn't mean that the code is good. I'm not a C developer, so I'm pretty sure that I'm commiting a bunch of C crimes in every patch that I make.

You should NOT use `wine-scribble` as your main Wine install, you should only use it if you need it for a specific game that isn't working on mainline Wine! If you need patches for modern games, you will have more luck with Proton, [wine-tkg](https://github.com/Frogging-Family/wine-tkg-git), [proton-ge](https://github.com/GloriousEggroll/proton-ge-custom), and other forks. :)

## Building

1. Run the `update.sh` script, this will clone Wine and apply all of the patches
2. Create a folder named `build32`
3. Inside the `build32` folder, run `../wine/configure --prefix=/opt/wine-scribble --with-x --without-mingw CFLAGS="-m32" LDFLAGS="-m32"`
4. Use `make -j$(nproc) && sudo make install`
5. The installed Wine will be in `/opt/wine-scribble`

## Features

By default, all environment variables are set to behave like "vanilla" Wine.

The reason why all environment variables start with `SCRIBBLE` instead of `WINE` is because I hate when someone recommends a environment variable that starts with `WINE` when, in reality, it isn't present on the mainline Wine project. >:(

### Disable User Callback Error Handling

When enabled, removes the `try .. except` handler from the `dispatch_user_callback`.

**Environment Variable:** `SCRIBBLE_DISABLE_USER_CALLBACK_ERROR_HANDLING=1`

**When to use:** If an application is behaving erratically after the SEH logs that it ignored a exception. Keep in mind that if the game does not handle the exception, it will crash!

### Gracefully handle zero-sized palette resizes

If an application tries to resize a palette to zero, Wine calls `realloc` and, because calling `realloc` with zero is undefined behavior, the behavior seems that it acts like it is a call to `free`.

If the application then tries to delete the previously resized to zero palette, the application crashes with `double free detected`.

**When to use:** If a game is crashing with "double free detected" when deleting palettes.

### Disable `GetModuleHandle16` handles

When enabled, Wine will return `0` to all `GetModuleHandle16` calls.

**When to use:** If an application is taking too long to process/load something and you notice that, when running the game with `+module`, there is some `GetModuleHandle16` calls.

## Patched Games

### Microsoft Flight Simulator 98

* `SCRIBBLE_DISABLE_USER_CALLBACK_ERROR_HANDLING=1`: Fixes the 3D renderer crashing when switching views or when clicking on the 3D world

### Monster Truck Madness 2

Vanilla Wine has a bug that causes Monster Truck Madness 2 to crash with a "double free detected" due to the game trying to resize a palette to zero entries and then delete it.

* `SCRIBBLE_DISABLE_WIN16_MODULE_HANDLES=1`: Fixes the game taking a long time to load and end races