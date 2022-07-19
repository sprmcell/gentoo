#!/bin/bash

# Define boot & root partitions.
boot_partition='sda1'
root_partition='sda3'

# Script content.
mount /dev/root/$root_partition /mnt/gentoo
cd /mnt/gentoo
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run
chroot /mnt/gentoo /bin/bash
mount /dev/$boot_partition /boot/EFI
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -R /mnt
reboot
