# myKali
myKali

## clamscan
```
apt install clamscan
clamscan -r --bell -i ./myKali
find . -size +2000k|grep -v "git"|sed -E 's/.*\.//g'|sort -u|xargs -I % git lfs track "*.%"

git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch oracle_client_12_2_exp_imp/lib/libclntsh.so.12.1'
```

## build
```
git clone https://github.com/hktalent/myKali && cd myKali

docker build -t mykali20190526 --no-cache .
```
