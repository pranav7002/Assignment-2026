# Bandit Wargames

## 1. Level 0

Opening SSH server in PowerShell :
```bash
ssh username@hostname -p port
```

eg:
```bash
ssh myuser@example.com -p 22
```

## 2. Level 0 → 1

Commands:

- `cd` – enters into sub folder
- `ls` – lists items in the folder
- `cat` – shows the expected content of the file that the operation is used on
- `file` – gives the type of file it is
- `du` – gives the disk usage of the file
- `find` – finds the file by name

password level 1 → `ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`

## 3. Level 1 → 2

for file name `-` the normal cat function wont work as the terminal understands it as dev/stdin or dev/stdout so if we want to run the cat command on a file named `-` we must do so in the following way:
```bash
cat ./-
```

As a precaution we should set a standard to always write the file name in the following syntax:
```bash
cat ./'filename'
```
```bash
cat ./"Filename"
```

password level 2 → `263JGJPfgU6LtdEvgfWU1XP5yac29mFx`

## 4. Level 2 → 3

If a file name consists of spaces then writing cat ./filename with spaces wont give the desired output so instead we have to use ("") or ('') and enter the filename in those braces for the command to execute in a desired manner.

Password level 3 → `MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`

## 5. Level 3 → 4

The hidden file wont be shown in the ls command list. We have to use the `find` command to discover the file which was hiding from us.

Password level 4 → `2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`

## 6. Level 4 → 5

7 files are given out of which in 6 of them human unreadable code is given and only one of the files has the readable code. Somehow if we run the find command it automatically pushes the human readable list to the top and thus we can just cat the readable file and obtain our password.

Password 5 → `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

## 7. Level 5 → 6

We are required to find a file with a particular find size of 1033 bytes. To do so we use the extension of the find function in our powershell (`c` stands for bytes):
```bash
find . -size 1033c
```

Password 6 → `HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`

## 8. Level 6 → 7

This was the first of proper multistep level. We are given specification for the file that contains the password for the next level:

- Owned by user - bandit7
- Owned by group - bandit6
- File size – 33c

To do this we have to run a find command with various filters. To do so we have to use the following syntax:
```bash
find / -filter1 filter1condition -filter2 filter2condition -filter3 filter3condition ……
```

For example the code we have to use in this particular level is:
```bash
find / -type f -user bandit7 -group bandit6 -size 33c
```

But this will show all the files with error messages who denied permission at this stage so to remove the files with such error message we use the following extended command:
```bash
find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null
```

This will only give the desired files. Then just cat the location of the file given and obtain the password.

Password 7 → `morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`

## 9. Level 7 → 8

The txt file is very long and has 2 words in each line. It is almost impossible to manually find "millionth" word so we use a search function called grep. We can also find the line number of the given file using `-n` extension to the existing command grep. The syntax is as follows:
```bash
grep "wordthatyouwanttofind" filename
```

For example:
```bash
grep "millionth" data.txt
```

Password 8 → `dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`

## 10. Level 8 → 9

The `uniq` command only removes adjacent duplicate lines. To remove all duplicate lines from a file, regardless of their position, you must first sort the file to bring identical lines together. This is achieved by piping the output of the `sort` command into the `uniq` command.

Now the required line can be obtained in two ways:

1. Sort data.txt | uniq -c — This will give the count of each line repeated, just look manually for the line which has count 1:
```bash
sort data.txt | uniq -c
```

2. Sort data.txt | uniq -u — This will give the only line which has only been repeated once directly, avoiding the hassle to read the count of each string manually (preferable method):
```bash
sort data.txt | uniq -u
```

Password 9 → `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`

## 11. Level 9 → 10

Just use the strings command, it pretty much shows the password as is.

Password 10 → `FGUlW5ilLVJrxX9kMYMmlN4MgbpfMiqey`

## 12. Level 10 → 11

The data.txt file contains a base64 file so now we have to decode it. Just run the `base64 --help` command which will show the command for decoding a base64 file (it is –decode ;))
```bash
base64 --decode data.txt
```

It will give the password.

Password 11 → `dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`

## 13. Level 11 → 12

This is a bit peculiar.
```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

First enter the things that you want to change in the given manner then break the transformation because writing directly "N-An-A" will raise an error saying it is in reverse order so break it into parts where it looks like it is in normal so as to give rise to the following string `N-ZA-Mn-za-m`.

Password 12 → `7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

## 14. Level 12 → 13

https://david-varghese.medium.com/overthewire-bandit-level-12-level-13-2ec761a88907

Need to know commands:
```bash
mktemp -d          # makes temp folder
mv                 # rename or relocate
cp                 # copies file/folder
xxd -r hexdump     # converts hexdump to binary
tar -xf filename   # unarchives files
rm                 # deletes files
gunzip             # decompress (file should have .gz extension)
bunzip2            # decompress
```

This article gives the most perfect way to solve this particular level. The given file is in hexdump form so we convert this to binary using xxd. Then we have to decompress the file multiple times and finally we get a file with the required ascii text which contains the password.

Password 13 → `FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn`

## 15. Level 13 → 14

We have been given a private ssh key and asked to log into next level. To connect using a private ssh key the following syntax is used:
```bash
ssh -i '/path/to/keyfile' username@server
```

In this the username is bandit14, server is localhost, and port is 2220. Therefore the required syntax would be:
```bash
ssh -i /home/bandit13/sshkey.private bandit14@localhost -p 2220
```

Password 14 → (no password)

## 16. Level 14 → 15

Get the password from the given location. The name of the file containing the file is bandit14 so use cat. We have to login to localhost port 30000. To do so we use telnet command with the following syntax:
```bash
telnet --login localhost 30000
```

Then enter the password.

Password 15.1 → `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`

## 17. Level 15 → 16

To connect to a port with ssl/tls encryption use the following syntax:
```bash
openssl s_client -connect <hostname or ip>:<port>
```

Password 15.2 → `8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

Password 16 → `kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`

## 18. Level 16 → 17

We have been given a range of 1000 ports (31000-32000). We have to find the port which has a server listening to it and also has ssl encryption. To do such search we use nmap command:
```bash
nmap -sV -p 31000-32000 localhost
```

We login to bandit16 using ssh and then procure the file password with the following command:
```bash
cat /etc/bandit_pass/bandit16
```

Copy the password and follow the next steps. This gives the list of all the ports which are having a server listening to them then further it shows the ports which have ssl encryption. The port 31518 has echo which cant be trusted so we use the port 31790 port and connect to it with ssl encryption using the following command:
```bash
openssl s_client --connect localhost:31790 -ign_eof
```

This gives us the private ssh key. Now create a new directory in which you can store the ssh key:
```bash
mkdir /tmp/random_sshkey
cd /tmp/random_sshkey
touch private.key
vim private.key
```

Press `i`, paste the sshkey, then press `Esc` and type `:wq`. By doing so you have now created your private.key file. Now connect to the port using private key:
```bash
chmod 400 private.key
ssh -i /tmp/random_sshkey/private.key bandit17@localhost -p 2220
```

You will then enter level 17 

## 19. Level 17 → 18

Only one line has been changed between two files so to find this line we use the diff command:
```bash
diff filename1 filename2
```

The output is something like:
<asdlfahdsfghadsjkgadsf> aksdjfhkjadshfadsjk 

The first part is corresponding to the different line in file 1 and 2nd part corresponds to the different part in the second file.

Password (diff bw the two files) → `x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`

But when we try to login level 18 using this password we get byebye, to resolve this we have to go to next level.

## 20. Level 18 → 19

We are told that we can't use ssh normally because someone has messed with bashrc. So now we have to login using another shell. We can find the list of shells by:
```bash
cat /etc/shells
```

We use the first shell available by the following command:
```bash
ssh bandit18@bandit.labs.overthewire.org -p 2220 -t "/bin/sh"
```

Then do:
```bash
ls
cat readme
```

Get the password for level 19.

Level 19 → `cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8`

## 21. Level 19 → 20

We have a setuid binary file. `ls -l` tells us about the properties of the file. We can see that the bandit20 file is owned by bandit20. When we do `./bandit20-do` it tells us that we can now run files as another user called bandit20. Then do the normal:
```bash
./bandit20-do cat /etc/bandit_pass/bandit20
```

To get the password.

Password 20 → `0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO`