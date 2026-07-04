#!/bin/sh

echo "If this build fails with a free disk space error, run:"
echo "  ostree --repo=repo config set core.min-free-space-percent 0"
echo "    and then try again."
echo ""
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak run org.flatpak.Builder --force-clean --sandbox --user --install-deps-from=flathub --disable-rofiles-fuse --ccache --repo=repo flatpak_build io.github.e_j_w.SpecFitter-master.yml
flatpak build-bundle repo SpecFitter.flatpak io.github.e_j_w.SpecFitter
if [ -f SpecFitter.flatpak ]; then
    flatpak install SpecFitter.flatpak
    rm SpecFitter.flatpak
else
    echo ""
    echo "ERROR: failed to build flatpak bundle!"
fi
