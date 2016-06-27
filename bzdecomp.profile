# Firejail profile for bz2 decompression
# bzip2.profile

include /usr/local/etc/firejail/disable-common.inc
include /usr/local/etc/firejail/disable-devel.inc

caps.drop all
shell none
netfilter
noroot
seccomp.keep getcwd,getdents,chdir,wait4,access,prctl,arch_prctl,brk,close,execve,exit_group,fchmod,fchown,fcntl,getuid,geteuid,getrlimit,fstat,lstat,mmap,mprotect,munmap,open,read,rt_sigaction,rt_sigprocmask,setresuid,set_robust_list,set_tid_address,stat,unlink,utime,write,unshare,clone,nanosleep
tracelog

