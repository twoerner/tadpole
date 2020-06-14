LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a68ee0b567540fce5e3b64e7e2d4ba1d"

SRCREV = "7357e3d625c0ec5d6f070bed4e4f45cca9193433"
SRC_URI += "git://github.com/twoerner/tadpole.git;protocol=https"

S = "${WORKDIR}/git"

do_install() {
    install -Dm755 ${S}/tadpole_blink.sh ${D}${bindir}/tadpole_blink.sh
}

# It doesn't really need bash, but has /bin/bash shebang
RDEPENDS_${PN} = "bash"
