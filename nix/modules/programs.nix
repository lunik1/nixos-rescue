{ pkgs, ... }:
{
  programs = {
    git.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    htop.enable = true;
    iftop.enable = true;
    less.enable = true;
    mtr.enable = true;
    tcpdump.enable = true;
    tmux.enable = true;
    wireshark.enable = true;

    nano = {
      enable = true;
      syntaxHighlight = true;
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };

  environment.systemPackages =
    with pkgs;
    (
      [
        # filesystem tools
        bcache-tools
        bcachefs-tools
        btrfs-progs
        cryptsetup
        dd_rescue
        ddrescue
        dislocker
        dosfstools
        e2fsprogs
        erofs-utils
        exfatprogs
        f2fs-tools
        f3
        fsarchiver
        fuse
        fuse3
        gptfdisk
        hfsprogs
        jfsutils
        lvm2
        mdadm
        mtools
        multipath-tools
        nilfs-utils
        ntfs3g
        partclone
        parted
        squashfsTools
        thin-provisioning-tools
        udftools
        xfsdump
        xfsprogs
        zerofree

        # data recovery
        afflib
        binwalk
        chntpw
        dc3dd
        dcfldd
        ext4magic
        extundelete
        foremost
        gpart
        libewf
        myrescue
        recoverjpeg
        safecopy
        scalpel
        sleuthkit
        testdisk

        # disk wiping
        nwipe

        # data backup
        kopia
        rclone

        # boot
        efibootmgr
        efivar
        grub2
        kexec-tools
        mokutil
        ms-sys
        os-prober
        refind

        # networking
        arp-scan
        arping
        bridge-utils
        cfspeedtest
        cifs-utils
        croc
        curl
        dnsutils
        dsniff
        ethtool
        fping
        hping
        iperf3
        ipcalc
        ipmitool
        iptstate
        iw
        lftp
        mosh
        net-snmp
        net-tools
        netcat-openbsd
        nethogs
        ngrep
        nfs-utils
        nmap
        openiscsi
        openvpn
        q
        rsync
        socat
        sshfs-fuse
        tcpdump
        tcpflow
        tcptraceroute
        tftp-hpa
        traceroute
        vlan
        w3m-nographics
        wakeonlan
        webwormhole
        wget2
        whois
        wireguard-tools

        # serial
        lrzsz
        minicom
        picocom
        setserial
        tio
        uucp

        # hardware
        acpi
        dmidecode
        fio
        hdparm
        inxi
        lm_sensors
        lshw
        lsscsi
        memtester
        nvme-cli
        pciutils
        sdparm
        sg3_utils
        smartmontools
        stress-ng
        usb-modeswitch
        usbutils

        # system monitoring
        btop
        file
        gdb
        iotop
        lsof
        ltrace
        ncdu
        psmisc
        strace
        sysstat
        tree

        # disk usage and cleanup
        dua
        duf
        nix-tree
        rmlint

        # encryption tools
        age
        ccrypt
        john
        lynis
        openssl
        sops
        yubikey-manager

        # ISO tools
        qemu-utils
        xorriso

        # archiving tools
        cabextract
        cpio
        libarchive
        lrzip
        lz4
        lzop
        p7zip
        pbzip2
        pigz
        pv
        unar
        unrar
        unzip
        xz
        zip
        zstd

        # text and file tools
        bat
        bat-extras.batgrep
        binutils
        dos2unix
        ed
        fd
        fzf
        hexedit
        jq
        mbuffer
        moreutils
        pwgen
        qrencode
        rename
        ripgrep
        sd
        sqlite
        xxd
        xxhash
        yq
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isx86 [
        cpuid
        flashrom # fails to build for aarch64-linux
        syslinux # BIOS boot
      ]
    );
}
