# learn-salt

Deploy easily an environment where you can test and learn [Salt](https://saltstack.com). Check [Salt in 10 minutes](https://docs.saltstack.com/en/latest/topics/tutorials/walkthrough.html) for more information.

The environment is composed of one master and several minions.

* **salt-master**
  * *OS*: Ubuntu Xenial
  * *IP*: 192.168.43.10
  * *Boot by default*: Yes

* **salt-minion1**
  * *OS*: Ubuntu Xenial
  * *IP*: 192.168.43.11
  * *Boot by default*: Yes

* **salt-minion2**
  * *OS*: CentOS 7
  * *IP*: 192.168.43.12
  * *Boot by default*: No

* **salt-minion3**
  * *OS*: Debian Jessie
  * *IP*: 192.168.43.13
  * *Boot by default*: No

## Requirements

* [Virtualbox](https://www.virtualbox.org/) ≥ 5.1.x
* [Vagrant](https://www.vagrantup.com/) ≥ 1.8.6

## Usage

1) Clone the repository

```
$ git clone https://github.com/jfusterm/learn-salt.git
$ cd learn-salt
```

2) Launch the VMs

```
$ vagrant up
```

This will launch just the master and minion1. If you want to start minion2 or minion3 to test Salt's integration with different operating systems you can do it using:

```
$ vagrant up salt-minion2
```

If you want to start the master and all the minions at once:

```
$ vagrant up "/salt-*/"
```

3) Connect to the VMs using the VM name

```
$ vagrant ssh salt-master
```

4) Check that the master has access to the minions

By default, all the minions will be connected to the master automatically. You can check that the master can reach the minions.

```
$ vagrant status
Current machine states:

salt-master               running (virtualbox)
salt-minion1              running (virtualbox)
salt-minion2              running (virtualbox)
salt-minion3              running (virtualbox)

$ docker ssh salt-master

ubuntu@salt-master:~$ sudo salt-key -L
Accepted Keys:
salt-minion1
salt-minion2
salt-minion3
Denied Keys:
Unaccepted Keys:
Rejected Keys:

ubuntu@salt-master:~$ sudo salt '*' test.ping
salt-minion3:
    True
salt-minion1:
    True
salt-minion2:
    True
```

## Vagrant configuration

You can adjust your Salt environment changing the options included in the configuration file `config.rb`

* **`$vm_gui`**. If you want to start the VM with GUI, set this to `true`.
* **`$vm_memory`**. Amount of memory assigned to the VM.
* **`$vm_cpus`**. Number of CPUs assigned to the VM.
* **`$install_type`**. Which release of Salt will be used.

	* `stable`
	* `git`
	* `daily`
  * `testing`

* **`$install_syndic`**. If true, [Salt Syndic](https://docs.saltstack.com/en/latest/topics/topology/syndic.html) will be installed on the master. 
* **`$verbose`**. If true, Salt's installation will be verbose.
* **`$colorize`**. If true, Salt's installation output will be colorized.

## Salt configuration

If you want to test thoroughly Salt's configuration you can edit either `/etc/salt/master` or `/etc/salt/minion` followed by a service restart.

On the master.

```
systemctl restart salt-master
```

On the minion.

```
systemctl restart salt-minion
```
