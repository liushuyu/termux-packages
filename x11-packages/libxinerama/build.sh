TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 Xinerama extension library"
TERMUX_PKG_VERSION=1.1.4
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXinerama-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=0008dbd7ecf717e1e507eed1856ab0d9cf946d03201b85d5dcf61489bb02d720
TERMUX_PKG_DEPENDS="libxext"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_DEVPACKAGE_DEPENDS="xorgproto"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
