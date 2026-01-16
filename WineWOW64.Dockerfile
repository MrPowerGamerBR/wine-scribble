FROM archlinux:multilib-devel

RUN pacman -Syu --noconfirm

# https://gitlab.winehq.org/wine/wine/-/wikis/Building-Wine
RUN pacman -S --noconfirm \
    git \
    gcc \
    make \
    mingw-w64-gcc \
    ccache \
    lib32-glibc \
    alsa-lib \
    bluez \
    libpulse \
    dbus \
    fontconfig \
    freetype2 \
    gnutls \
    mesa \
    libunwind \
    libx11 \
    libxcomposite \
    libxcursor \
    libxfixes \
    libxi \
    libxrandr \
    libxrender \
    libxext \
    wayland \
    libglvnd \
    libxkbcommon \
    gstreamer \
    gst-plugins-base-libs \
    sdl2 \
    vulkan-icd-loader \
    vulkan-headers \
    ocl-icd \
    opencl-headers \
    ffmpeg

# Set dummy values
RUN git config --global user.email "you@example.com" && git config --global user.name "Your Name"

USER root
WORKDIR /root

ADD patches /root/patches/
COPY update.sh scribble_vars.sh rebuild_patches.sh build-wine.sh build-wine32.sh build-wine-wow64.sh /root/

CMD ["bash"]
