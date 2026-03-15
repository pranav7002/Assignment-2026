# Git Exercises

## 1. master

```bash
git start master
git start next
```

---

## 2. commit-one-file

Here we simply add A.txt to the staging area and then commit it. 

```bash
git add A.txt
git commit -m "commit A"
```

---

## 3. commit-one-file-staged

In this case we commit only A.txt directly by putting the file in the commit.

```bash
git commit A.txt -m "commit A"
```

---

## 4. ignore-them

We create a .gitignore file first. Inside it we add these entries so git ignores those files:

/libraries  
*.exe  
*.o  
*.jar  

```bash
touch .gitignore
nano .gitignore
git add .gitignore
git commit -m "add gitignore rules"
```

---

## 5. chase-branch

We can solve this using a hard reset.

```bash
git reset --hard escaped
```

---

## 6. merge-conflict

Two branches had conflicting changes in the file equation.txt.

One branch contained:

2 + ? = 5

The other branch contained:

? + 3 = 5

To resolve the conflict we edit the file so that the correct equation becomes:

2+3=5

```bash
nano equation.txt
git add equation.txt
git commit -m "resolve merge conflict"
```

---

## 7. saving-your-work

This step uses git stash.

First we stash the changes. Then we fix a bug in bug.txt. commit it and then go back to the stashed work using git stash pop. 

```bash
git stash
nano bug.txt
git add bug.txt
git commit -m "fix bug"
git stash pop
nano bug.txt
git add bug.txt
git commit -m "restore changes"
```

---

## 8. change-branch-history

We need to move the commit from the branch change-branch-history into the branch hot-bugfix. This is done using git rebase.

```bash
git rebase hot-bugfix
```

---

## 9. remove-ignored

Here we remove ignored.txt and stage and commit the change.

```bash
rm ignored.txt
git add .
git commit -m "remove ignored file"
```

---

## 10. case-sensitive-filename

Rename File.txt to file.txt.

```bash
mv File.txt file.txt
git add .
git commit -m "rename file"
```

---

## 11. fix-typo

First we edit the file and fix the typo. Then we check the previous commit message using git log. rather than creating a new commit we change the previous commit using amend.

```bash
nano file.txt
git add file.txt
git log
git commit --amend -m "Add Hello world"
```

---

## 12. forge-date

Here we over ride the previous commit and manually set the commit date.This is done using the date flag with git commit amend.

```bash
git commit --amend --date "1987-01-01 00:00:00"
```

---

## 13. fix-old-typo

This step involves an interactive rebase. We start the rebase and edit the second newest commit. We change pick to edit.

After that we fix the typo in the file, stage the change, and continue the rebase. During the process git expects to correct the commit message, we fix that also. 

Once everything is resolved we continue the rebase.

```bash
git rebase -i HEAD~2
nano file.txt
git add file.txt
git rebase --continue
nano file.txt
git add file.txt
git rebase --continue
```
