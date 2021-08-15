mkdir /root/.ssh && \
chmod 600 /root/.ssh && \
touch /root/.ssh/authorized_keys && \
chmod 600 /root/.ssh/authorized_keys

cat /home/vagrant/.ssh/authorized_keys | sed 's/vagrant/root/g' > /root/.ssh/authorized_keys
