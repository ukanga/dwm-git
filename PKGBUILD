pkgname=dwm-git
_pkgname=dwm
pkgver=6.4.r4.g348f655
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
        dwm-xrdb-6.2.diff
        dwm-alpha.diff
        dwm-autostart-20161205-bb3bd6f.diff
        dwm-emptyview-6.2.diff
        dwm-combo-6.1.diff
        dwm-cyclelayouts-20180524-6.2-1.diff
        dwm-pertag-6.2-1.diff
        dwm-hide_vacant_tags-6.2.diff
        dwm-activetagindicatorbar-6.2-1.diff
        dwm-cfacts-vanitygaps-6.4_combo.diff
        dwm-statuscolors-20220121-84f9a96.diff
        dwm-swallow-6.4.diff
        dwm-myconfig-6.4.diff
        )
md5sums=(939f403a71b6e85261d09fc3412269ee
         'SKIP'
         100f7463edcc80dcf6472ed30c76af22
         fd30653e7798999b701459ca2e8ff429
         b50863cbb92ea2fbf60cf4474e30cb36
         3c5c1d304c948d692082cf657e0b3b7c
         b0a3ea638271f42d410bf9393ccce49d
         'SKIP'
         e8501d039a68e9a106233b1d096ac017
         c446b71a8b8cce25db86a47805500dfa
         61d820c506cf764f69b25d2e421a7705
         'SKIP'
         fa11e3b1f73d65ddcc97dec296a616b4
         'SKIP'
         'SKIP'
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
