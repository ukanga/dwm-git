pkgname=dwm-git
_pkgname=dwm
pkgver=6.2.r2.ga8e9513
pkgrel=1
pkgdesc="A dynamic window manager for X"
url="http://dwm.suckless.org"
arch=('i686' 'x86_64')
license=('MIT')
options=(zipman)
depends=('libx11' 'libxinerama' 'libxft')
makedepends=('git')
install=dwm.install
provides=('dwm')
conflicts=('dwm')
source=(dwm.desktop
        "$_pkgname::git+http://git.suckless.org/dwm"
        #config.h
        dwm-xrdb-6.2.diff
        dwm-alpha.diff
        dwm-vanitygaps-20190508-6.2.diff
        dwm-autostart-20161205-bb3bd6f.diff
        dwm-emptyview-6.2.diff
        dwm-combo-6.1.diff
        dwm-statuscolors-6.2.diff
        dwm-centeredmaster-20160719-56a31dc.diff
        dwm-gridmode-20170909-ceac8c9-1.diff
        dwm-cyclelayouts-20180524-6.2-1.diff
        dwm-pertag-6.2-1.diff
        dwm-hide_vacant_tags-6.2.diff
        dwm-activetagindicatorbar-6.2-1.diff
        dwm-myconfig.diff
        )
md5sums=('939f403a71b6e85261d09fc3412269ee'
         'SKIP'
         '1fc4042932a74be58d58b50c3e5681a2'
         'fd30653e7798999b701459ca2e8ff429'
         '3ee6971e9c9bd495916083e49c597bb5'
         'b50863cbb92ea2fbf60cf4474e30cb36'
         '3c5c1d304c948d692082cf657e0b3b7c'
         'b0a3ea638271f42d410bf9393ccce49d'
         'a56ddfad8c3f882dd8b60ab8b2ec84ba'
         '0051114992d940bc2ce1ed9ddcdcd8f8'
         '8f3351056a226997e67c6ff58af32a72'
         'de4197bcfba7af9d0517932c13f88fcf'
         'e8501d039a68e9a106233b1d096ac017'
         'c446b71a8b8cce25db86a47805500dfa'
         '61d820c506cf764f69b25d2e421a7705'
         'c88ff2c7c314d134d9737505e1f7a3d2'
         ) # so you can customize config.h

pkgver(){
  cd $_pkgname
  git describe --long --tags | sed -E 's/([^-]*-g)/r\1/;s/-/./g'
}

prepare() {
  cd $_pkgname
	for file in "${source[@]}"; do
		if [[ "$file" == "config.h" ]]; then
			# add config.h if present in source array
			# Note: this supersedes the above sed to config.def.h
			cp "$srcdir/$file" .
		elif [[ "$file" == *.diff || "$file" == *.patch ]]; then
			# add all patches present in source array
			patch -Np1 <"$srcdir/$(basename ${file})"
		fi
	done
}

build() {
  cd $_pkgname
  make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11
}

package() {
  cd $_pkgname
  make PREFIX=/usr DESTDIR="$pkgdir" install
  install -m644 -D LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  install -m644 -D README "$pkgdir/usr/share/doc/$pkgname/README"
  install -m644 -D ../dwm.desktop "$pkgdir/usr/share/xsessions/dwm.desktop"
}

# vim:set ts=2 sw=2 et:
