# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/RadeonOpenCompute/ROCm-Device-Libs/"
	# 27.08.2019
#	EGIT_COMMIT="ecdba121acc092df600cd7053dbbdf822ceb4939"
	# 13.08.2019
#	EGIT_COMMIT="ac6a51547af45d31d116502e835ad6c762d139d5"
	inherit git-r3
	S="${WORKDIR}/${P}"
else
	SRC_URI="https://github.com/RadeonOpenCompute/ROCm-Device-Libs/archive/roc-ocl-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/ROCm-Device-Libs-roc-ocl-${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Radeon Open Compute Device Libraries"
HOMEPAGE="https://github.com/RadeonOpenCompute/ROCm-Device-Libs"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"

RDEPEND="dev-libs/rocr-runtime
	sys-devel/llvm-roc:="
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DLLVM_DIR="${EPREFIX}/usr/lib/llvm/roc/"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/"
	)
	cmake-utils_src_configure
}
