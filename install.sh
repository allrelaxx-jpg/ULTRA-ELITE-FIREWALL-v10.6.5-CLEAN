#!/usr/bin/env bash
set -e

echo "ULTRA ELITE FIREWALL INSTALLER v10.6.5 CLEAN"

INSTALL_DIR="/opt/ultra-firewall"

mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

echo "[1] Download core"

curl -fsSL "https://raw.githubusercontent.com/allrelaxx-jpg/ULTRA-ELITE-FIREWALL-v10.6.5-CLEAN/main/firewall.sh?nocache=$(date +%s)" -o firewall.sh
curl -fsSL "https://raw.githubusercontent.com/allrelaxx-jpg/ULTRA-ELITE-FIREWALL-v10.6.5-CLEAN/main/geo-update.sh?nocache=$(date +%s)" -o geo-update.sh

chmod +x *.sh

echo "[2] Enable IP forwarding"
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-ultra-firewall.conf
sysctl --system >/dev/null 2>&1

echo "[3] Backup config"
[ -f /etc/nftables.conf ] && cp /etc/nftables.conf /etc/nftables.conf.bak.$(date +%s)

echo "[4] Apply firewall"
bash firewall.sh

echo "[5] Setup GeoIP auto-update"
(crontab -l 2>/dev/null | grep -v geo-update.sh; echo "0 3 * * * bash $INSTALL_DIR/geo-update.sh") | crontab -

echo "INSTALL COMPLETE"
