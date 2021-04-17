1) per repo once :
git lfs install
2) git lfs migrate import --include="*.{file_format}"
OR
git lfs migrate import --everything
3) git add {PATH}/sample.{file_format}
4) git commit -m "{commit msg}"
5) git branch -M master {or dev}
6) git push origin master

-X-

1) git lfs install
2) git lfs track "*.{file_format}"
3) git add .gitattributes
4) git add {file_name}
5) git commit -m "{msg}"
6) git push


