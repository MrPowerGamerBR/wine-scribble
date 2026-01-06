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
  * If you already have a install on `/opt/wine-scribble`, don't forget to `sudo rm -rf /opt/wine-scribble`! Sometimes Wine may crash if you attempt to overwrite an already existing installation.
5. The installed Wine will be in `/opt/wine-scribble`

## Features

By default, all environment variables are set to behave like "vanilla" Wine.

The reason why all environment variables start with `SCRIBBLE` instead of `WINE` is because I hate when someone recommends a environment variable that starts with `WINE` when, in reality, it isn't present on the mainline Wine project. >:(

### Disable User Callback Error Handling

When enabled, removes the `try .. except` handler from the `dispatch_user_callback`.

**Environment Variable:** `SCRIBBLE_DISABLE_USER_CALLBACK_ERROR_HANDLING=1`

**When to use:** If an application is behaving erratically after the SEH logs that it ignored a exception. Keep in mind that if the game does not handle the exception, it will crash!

### WineD3D FPS Limiter

Some games tie physics/logic to the FPS. While other DX wrappers (DXVK, D7VK, dxwrapper, etc) have their own FPS limiter, WineD3D doesn't, and that's sad when you have a game that runs well enough on WineD3D but doesn't work on other translation layers.

You can use it with `WINE_D3D_CONFIG="FPSLimit=30"`, or you can set the registry key `HKEY_CURRENT_USER -> Software -> Wine -> Direct3D -> FPSLimit`

## Patched Games

### Microsoft Flight Simulator 98

* `SCRIBBLE_DISABLE_USER_CALLBACK_ERROR_HANDLING=1`: Fixes the 3D renderer crashing when switching views or when clicking on the 3D world

### Monster Truck Madness 2

`wine-scribble` did have some specific patches to fix Monster Truck Madness 2, but they were all fixed in upstream Wine (yayy!).

* `WINE_D3D_CONFIG="FPSLimit=30"`: If you don't limit the FPS, the game AI and physics get all wonky (see: http://www.mtm2.com/~mtmg/dxtory.html)
  * Another alternative is to use nGlide + DXVK (nGlide for 3dfx acceleration, DXVK to limit the FPS)