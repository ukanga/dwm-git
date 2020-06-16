#!/bin/bash

# Maintainer: Ukang'a Dickson <ukanga@gmail.com>

pkgname=dwm-git
_pkgname=dwm
pkgver=6.2.r5.gf09418b
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
source=("git://git.suckless.org/dwm"
        dwm.desktop
        dwm-xrdb-6.2.diff
        dwm-alpha.diff
        dwm-autostart-20161205-bb3bd6f.diff
        dwm-emptyview-6.2.diff
        dwm-combo-6.1.diff
        dwm-centeredmaster-20160719-56a31dc.diff
        dwm-gridmode-20170909-ceac8c9-1.diff
        dwm-cyclelayouts-20180524-6.2-1.diff
        dwm-pertag-6.2-1.diff
        dwm-hide_vacant_tags-6.2.diff
        dwm-activetagindicatorbar-6.2-1.diff
        dwm-vanitygaps-20200503-9fc59bf.diff
        dwm-statuscolors-20200503-25f74ad.diff
        dwm-swallow-20200609-312bb44.diff
        dwm-myconfig-20200609-9a29232.diff
        )
md5sums=('SKIP'
         939f403a71b6e85261d09fc3412269ee
         100f7463edcc80dcf6472ed30c76af22
         fd30653e7798999b701459ca2e8ff429
         b50863cbb92ea2fbf60cf4474e30cb36
         3c5c1d304c948d692082cf657e0b3b7c
         b0a3ea638271f42d410bf9393ccce49d
         0051114992d940bc2ce1ed9ddcdcd8f8
         8f3351056a226997e67c6ff58af32a72
         de4197bcfba7af9d0517932c13f88fcf
         e8501d039a68e9a106233b1d096ac017
         c446b71a8b8cce25db86a47805500dfa
         61d820c506cf764f69b25d2e421a7705
         e26502e331d8db2c669fe6a1cbd0efa5
         5835f93e81555436a4916a968478845a
         0e165cee9f40d92d15b8049e579c6d30
         773e95e1e4c354eb5a9db023239ff08c
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
  sudo make PREFIX=/usr DESTDIR="$pkgdir" install
  sudo install -m644 -D LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  sudo install -m644 -D README "$pkgdir/usr/share/doc/$pkgname/README"
  sudo install -m644 -D ../dwm.desktop "$pkgdir/usr/share/xsessions/dwm.desktop"
}

prepare_sources() {
  # pkgdir=("$(pwd)/pkg")
  srcdir=("$(pwd)/src")
  rm -rf "${srcdir}" && mkdir -p "${srcdir}" && cd "${srcdir}"
  
  for file in "${source[@]}"; do
    if [[ "$file" == *.diff || "$file" == *.patch || "$file" == *.h || "$file" == *.desktop ]]; then
      cp "$(dirname $(pwd))/$file" .
    fi
  done
  
  if [[ "$?" == 0 ]]; then
    git clone "${source}"
  else
    exit 1
  fi
}

prepare_sources
if [[ "$?" == 0 ]]; then
  prepare || exit 1
fi

if [[ "$?" == 0 ]]; then
  build || exit 1
fi

if [[ "$?" == 0 ]]; then
  package || exit 1
fi

if [[ "$?" == 0 ]]; then
  echo "Success"
else
  echo "Something went wrong!"  && exit 1
fi

# vim:set ts=2 sw=2 et:
