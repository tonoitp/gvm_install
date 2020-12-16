# Create GVM Scanner
# Build and Install OSPd and OSPd-OpenVAS
su gvm -c "touch /opt/gvm/ospd.sh"
su gvm -c "chmod u+x /opt/gvm/ospd.sh"

sudo -Hiu gvm echo "export PKG_CONFIG_PATH=/opt/gvm/lib/pkgconfig:$PKG_CONFIG_PATH" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh

# another difference here between Ubuntu and Debian
# Debian needs the below to be 'python3.7' while Ubuntu 'python3.8'

# going to just get the python3 version number and use it here. That should be better than trying
# to account for the differences with the release ID

PY3VER=`python3 --version | grep -o [0-9]\.[0-9]`
sudo -Hiu gvm echo "mkdir -p /opt/gvm/lib/python$PY3VER/site-packages/" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
sudo -Hiu gvm echo "export PYTHONPATH=/opt/gvm/lib/python$PY3VER/site-packages" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh


#ID=`grep ^ID= /etc/os-release | sed 's/ID=//g'`
#if [ $ID = "debian" ]; then
#    sudo -Hiu gvm echo "mkdir -p /opt/gvm/lib/python3.7/site-packages/" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
#    sudo -Hiu gvm echo "export PYTHONPATH=/opt/gvm/lib/python3.7/site-packages" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
#elif [ $ID = "kali" ]; then
#    sudo -Hiu gvm echo "mkdir -p /opt/gvm/lib/python3.9/site-packages/" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
#    sudo -Hiu gvm echo "export PYTHONPATH=/opt/gvm/lib/python3.9/site-packages" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
#else
#    sudo -Hiu gvm echo "mkdir -p /opt/gvm/lib/python3.8/site-packages/" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
#    sudo -Hiu gvm echo "export PYTHONPATH=/opt/gvm/lib/python3.8/site-packages" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
#fi
sudo -Hiu gvm echo "cd /tmp/gvm-source/ospd" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
sudo -Hiu gvm echo "python3 setup.py install --prefix=/opt/gvm" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
sudo -Hiu gvm echo "cd ../ospd-openvas" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh
sudo -Hiu gvm echo "python3 setup.py install --prefix=/opt/gvm" | sudo -Hiu gvm tee -a /opt/gvm/ospd.sh

#su gvm -c "/opt/gvm/ospd.sh"
#su gvm -c "rm /opt/gvm/ospd.sh"