#Flapjack Packages

Packages for the 0.9.x and 1.x series are currently available for Ubuntu, Debian and Centos.

## Add Repository

Add the [deb repo](http://packages.flapjack.io/deb) or [rpm repo](http://packages.flapjack.io/rpm) to your sources:

### 1.x Series
#### Ubuntu Trusty

```
echo "deb http://packages.flapjack.io/deb/v1 trusty main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

#### Ubuntu Precise

```
echo "deb http://packages.flapjack.io/deb/v1 precise main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

#### Centos 6

```
cat >/etc/yum.repos.d/flapjack.repo << EOL
[flapjack-v1]
name=Flapjack v1
baseurl=http://packages.flapjack.io/rpm/v1/flapjack/centos/6/x86_64/
enabled=1
EOL
```

### 0.9.x Series (legacy)
#### Trusty

```
echo "deb http://packages.flapjack.io/deb/0.9 trusty main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

#### Precise

```
echo "deb http://packages.flapjack.io/deb/0.9 precise main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

## Installation

### Ubuntu

After adding the relevant entry to your apt sources list, run:

```
gpg --keyserver keys.gnupg.net --recv-keys 803709B6
gpg -a --export 803709B6 | sudo apt-key add -
sudo apt-get update && sudo apt-get install flapjack
```

### Centos

After adding the relevant entry to your yum repository list, run:

```
yum install flapjack
```

These packages are currently unsigned.  In future, they will be signed with the Flapjack Package Signing Key (803709B6).

## Experimental releases

An experimental component is used for pre-release builds.  This is for testing purposes, and we would not recommend running packages from experimental in production.

```
# Ubuntu Trusty:
echo "deb http://packages.flapjack.io/deb/v1 trusty experimental" | sudo tee /etc/apt/sources.list.d/flapjack.list

# Ubuntu Precise:
echo "deb http://packages.flapjack.io/deb/v1 precise experimental" | sudo tee /etc/apt/sources.list.d/flapjack.list

# Centos 6:
cat >/etc/yum.repos.d/flapjack.repo << EOL
[flapjack-v1]
name=Flapjack v1
baseurl=http://packages.flapjack.io/rpm/v1/flapjack-experimental/centos/6/x86_64/
enabled=1
EOL
```
