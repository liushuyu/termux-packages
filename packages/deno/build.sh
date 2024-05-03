TERMUX_PKG_HOMEPAGE=https://deno.land/
TERMUX_PKG_DESCRIPTION="A modern runtime for JavaScript and TypeScript"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.43.1
#TERMUX_PKG_REVISION=
TERMUX_PKG_SRCURL="https://github.com/denoland/deno/releases/download/v${TERMUX_PKG_VERSION}/deno_src.tar.gz"
TERMUX_PKG_SHA256=bc5083a6ee27b98c37698367ea5df7de1edf71732304f15bbb295b869881fb26
TERMUX_PKG_DEPENDS="libffi, libc++"
TERMUX_PKG_BUILD_DEPENDS="gn, ninja"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_get_source() {
	cargo update simd-json value-trait
	rm -vf rust-toolchain.toml
}

termux_step_pre_configure() {
	termux_setup_rust

	if [ "$TERMUX_DEBUG_BUILD" = "true" ]; then
		BUILD_TYPE=debug
	else
		BUILD_TYPE=release
	fi
}

termux_step_make() {
	local libdir=target/$CARGO_TARGET_NAME/$BUILD_TYPE/deps
	mkdir -p $libdir
	local cmd="cargo build --jobs $TERMUX_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME --no-default-features \
		--features __vendored_zlib_ng -p cli"
	if [ "$TERMUX_DEBUG_BUILD" = "false" ]; then
		cmd+=" --release"
	fi
	V8_FROM_SOURCE=1 GN=gn PYTHON=python AR=llvm-ar NM=llvm-nm \
	GN_ARGS="is_clang=true use_lld=true no_inline_line_tables=false \
	custom_toolchain=\"//build/toolchain/linux/unbundle:default\" \
	host_toolchain=\"//build/toolchain/linux/unbundle:default\"" \
	$cmd
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/$BUILD_TYPE/deno
}
