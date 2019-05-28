# myKali
myKali

## clamscan
```
apt install clamscan
clamscan -r --bell -i ./myKali
find . -size +20000k|grep -v "git"|sed -E 's/.*\.//g'|sort -u|xargs -I % git lfs track "*.%"

find . -size +20000k|grep -v ".git"
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch sqldeveloper/sqldeveloper/extensions/oracle.datamodeler.jar'
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch sqldeveloper/ords/ords.war'
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch oracle/18.3/client64/lib/libclntsh.so.18.1'
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch oracle/18.3/client64/lib/libociei.so'
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch oracle_client_12_2_exp_imp/lib/libclntsh.so.12.1'
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch oracle_client_12_2_exp_imp/lib/libociei.so'

git push -u origin master

git filter-branch --tree-filter 'rm sqldeveloper/sqldeveloper/extensions/oracle.datamodeler.jar' HEAD
git filter-branch --tree-filter 'rm sqldeveloper/ords/ords.war' HEAD
git filter-branch --tree-filter 'rm oracle/18.3/client64/lib/libclntsh.so.18.1' HEAD
git filter-branch --tree-filter 'rm oracle/18.3/client64/lib/libociei.so' HEAD
git filter-branch --tree-filter 'rm oracle_client_12_2_exp_imp/lib/libclntsh.so.12.1' HEAD
git filter-branch --tree-filter 'rm oracle_client_12_2_exp_imp/lib/libociei.so' HEAD
git push 
git pull --rebase .
git push -f origin master --force
git commit -m "fix" .
git pull --allow-unrelated-histories origin master


```

## build
```
git clone https://github.com/hktalent/myKali && cd myKali

# ls /Users/0x101/safe/cache |grep -v "squid-simple.conf"|xargs rm -rf 
docker stop squid
docker rm -v squid

docker run --name squid -d \
  --publish 3128:3128 \
  --restart=always \
  -v /Users/0x101/safe/cache/squid-simple.conf:/etc/squid/squid.conf \
  -v /Users/0x101/safe/cache:/var/spool/squid \
  sameersbn/squid
docker start squid
docker exec -it squid /bin/bash
docker exec -it squid tail -f /var/log/squid/access.log


CURIP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
echo "CURIP = " ${CURIP}
docker build -t mykali_mtx --no-cache --build-arg http_proxy=http://${CURIP}:3128 \
    --build-arg https_proxy=http://${CURIP}:3128 \
    --build-arg ftp_proxy=http://${CURIP}:3128 .
```

## tools
### oracle database tools
#### /usr/share/oracle_client_12_2_exp_imp/
- exp
- expdp
- imp
- impdp
- sqlldr
- wrc
- lib/adrci
- lib/genezi
- lib/uidrvci

#### /usr/share/sqlcl/bin/
- adrci
- genezi
- sqlplus

#### /usr/share/sqldeveloper
- sqldeveloper.sh

### MSSQL Server database tools
#### /usr/share/sqlcl
- bin/sql

### jpexs-decompiler,swf file decompiler
- ffdec

### lynis audit system
```
lynis --check-all -Q
lynis audit system remote 192.168.10.216
```

### clamav,clamav-daemon
```
freshclam
clamscan -r --bell -i ~/
clamscan -r --remove /

```

### chkrootkit,rkhunter
```
rkhunter -c
chkrootkit|grep not
```
