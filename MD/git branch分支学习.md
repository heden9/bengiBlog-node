创建并切换分支
```
git checkout -b dev
// Switched to a new branch 'dev'
```

查看分支
```
git branch [-a]

git show-branch [-a/origin master master]
```

切换分支
```
git checkout master
// 切换到master分支
```
删除远程分支
```bash
git push origin :dev
```
变基
```bash
git pull --rebase
# 可以把之前的commit记录顶到前面来，并自动applying

git rebase origin master
```

合并分支
```
git merge dev
```

删除分支

```
git branch -d dev
```

重置
```bash
git reset origin master [--hard]
```
