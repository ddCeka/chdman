TERMUX_PKG_HOMEPAGE=https://github.com/ddCeka/chdman
TERMUX_PKG_DESCRIPTION="chdman standalone"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@ddCeka"
TERMUX_PKG_VERSION="0.288"
TERMUX_PKG_SRCURL="https://github.com/ddCeka/chdman/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=7e966220480c6680e4ee86f564822f73756999de7fdc0bfa85859d963f237c53
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	cmake -B build -G Ninja
	cmake --build build
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin build/${TERMUX_PKG_NAME}
	install -Dm644 -t $TERMUX_PREFIX/share/man/man1 man/${TERMUX_PKG_NAME}.1
}
