FROM archlinux:multilib-devel

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm \
    git \
    gcc \
    make \
    lib32-libx11 \
    lib32-freetype2 \
    lib32-wayland \
    lib32-libxcursor \
    lib32-libxi \
    lib32-mesa \
    lib32-libxrandr \
    lib32-libxfixes \
    lib32-libxinerama \
    lib32-libxcomposite \
    lib32-libxxf86vm \
    lib32-opencl-mesa \
    lib32-ocl-icd \
    lib32-libpcap \
    lib32-pcsclite \
    lib32-dbus \
    lib32-gnutls \
    lib32-libusb \
    lib32-libv4l \
    lib32-libpulse \
    lib32-gstreamer \
    lib32-alsa-lib \
    lib32-systemd \
    lib32-sdl2 \
    lib32-libcups \
    lib32-fontconfig \
    lib32-krb5 \
    lib32-libxrender \
    lib32-vulkan-radeon \
    wayland-protocols \
    samba

# Honestly, I'm not sure WHICH library is needed to have vulkan support in Wine
# So we just bring "lib32-vulkan-radeon" which does the job

# Missing dependencies:
# lib32-libsane
# lib32-gphoto2
# lib32-ffmpeg
# lib32-libcapi20

# Set dummy values
RUN git config --global user.email "you@example.com" && git config --global user.name "Your Name"

RUN useradd -m builduser && echo "builduser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER builduser
WORKDIR /home/builduser

RUN git clone https://aur.archlinux.org/yay-bin.git && \
    cd yay-bin && \
    makepkg -si --noconfirm && \
    cd .. && \
    rm -rf yay-bin

RUN yay -S lib32-egl-wayland --noconfirm

USER root
WORKDIR /root

ADD patches /root/patches/
COPY update.sh scribble_vars.sh rebuild_patches.sh /root/

# Command to run
CMD ["bash"]
