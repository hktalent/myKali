FROM kalilinux/kali-linux-docker

LABEL maintainer="51pwn.com<s1pwned@gmail.com>"

# https://github.com/dbeaver/dbeaver
# https://github.com/jindrapetrik/jpexs-decompiler

COPY oracle_client_12_2_exp_imp /usr/share/
COPY sqlcl /usr/share/
COPY sqldeveloper /usr/share/
COPY expMysql /usr/local/bin/
COPY oracle /usr/lib/
COPY bashrc /root/.bashrc
COPY DependencyCheck /usr/share
COPY dbeaver-ce-6.0.5-linux.gtk.x86_64.tar.gz /usr/share/

ARG CURIP
ENV http_proxy=http://$CURIP:3128 \
    https_proxy=http://$CURIP:3128 \
    ftp_proxy=http://$CURIP:3128

RUN set +e \
    && echo "CURIP = " $CURIP \
    && apt -y update --fix-missing && apt -y upgrade --fix-missing && apt -yy dist-upgrade && apt autoremove -yy \
    && apt -y install kali-linux  chkrootkit rkhunter clamav clamtk clamav-daemon lynis --fix-missing \
    && apt -y  install xvfb --fix-missing  \
    && apt -y  install net-tools --fix-missing  \
    && apt -y  install masscan --fix-missing  \
    && apt -y  install proxychains --fix-missing  \
    && apt -y  install netcat --fix-missing  \
    && apt -y  install maven  --fix-missing  \
    && apt -y  install python3-pip --fix-missing  \
    && apt -y  install python --fix-missing  \
    && apt -y  install nodejs --fix-missing  \
    && apt -y  install -y devscripts git-buildpackage debhelper debootstrap python-all --fix-missing  \
    && apt -y  install build-essential ipython python-setuptools --fix-missing \
    && apt -y  install python-pip python-dev libssl-dev libffi-dev --fix-missing   \
    && apt -y  install pkg-config libssl-dev libffi-dev libxml2-dev --fix-missing  \ 
    && apt -y  install libxslt1-dev libfreetype6-dev libpng-dev --fix-missing  \
    && apt -y  install openvas wfuzz --fix-missing  \
    && apt -y  install tcpdump --fix-missing  \
    && apt -y  install ettercap-text-only --fix-missing  \
    && apt -y  install bettercap jsql arachni hurl reaver gobuster golismero t50 sqlmap --fix-missing  \
    && apt -y  install redis-server jboss-autopwn dotdotpwn fimap  --fix-missing  \
    && apt -y  install zaproxy  apache-users sslsplit sqlninja inspy  powerfuzzer --fix-missing \
    && apt -y  install sysfsutils  --fix-missing  \
    && apt -y install kali-linux-top10 kali-linux-pwtools software-properties-common xrdp python-scapy wmi-client winrmcp winexe wig colordiff colortail unzip vim tmux xterm zsh curl strace tmate ant shellter samdump2 rdesktop --fix-missing \
    && apt -y install cl-sql-oracle set --fix-missing \
    && apt -y install oscanner tnscmd10g --fix-missing \
    && cd /usr/share/ && tar xzf dbeaver-ce-6.0.5-linux.gtk.x86_64.tar.gz && rm -rf dbeaver-ce-6.0.5-linux.gtk.x86_64.tar.gz \
    && rkhunter --update \
    && freshclam --verbose \
    && pip install cx_Oracle \
    # && cd /usr/share/ && git clone https://github.com/jindrapetrik/jpexs-decompiler  && cd jpexs-decompiler && ant build \
    && chmod +x /usr/local/bin/expMysql \
    && ln -s /usr/share/set/setoolkit /usr/local/bin/SET \
    && source /root/.bashrc \
    && dependency-check --updateonly \
    && apt update -y --fix-missing &&  apt upgrade  -y --fix-missing  && apt autoclean  -y --fix-missing
    # libmono-oracle4.0-cil oracle-instantclient18.3-basic oracle-instantclient18.3-devel oracle-instantclient18.3-sqlplus
# entrypoint: /code/entrypoint.sh