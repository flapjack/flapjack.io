#Flapjack Packages

Packages for the 0.9.x and 1.0.x series are currently available for Ubuntu.

## Add Repository

### 0.9
#### Precise
Add the [deb repo](http://packages.flapjack.io/deb) to your apt sources:

```
echo "deb http://packages.flapjack.io/deb precise main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

### 1.0
For the Flapjack 1.x series, we provide [Ubuntu packages](http://packages.flapjack.io/deb/1.0) for Precise and Trusty.  These are split into the following categories:

#### Precise

```
echo "deb http://packages.flapjack.io/deb/1.0 precise main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

#### Trusty

```
echo "deb http://packages.flapjack.io/deb/1.0 trusty main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

## Installation

After adding the relevant entry to your apt sources list, run:

```
gpg --keyserver keys.gnupg.net --recv-keys 803709B6
gpg -a --export 803709B6 | sudo apt-key add -
sudo apt-get update && sudo apt-get install flapjack
```

## Experimental releases

An experimental component is used for pre-release builds.  This is for testing purposes, and we would not recommend running packages from experimental in production.

```
echo "deb http://packages.flapjack.io/deb/1.0 distro_release experimental" | sudo tee /etc/apt/sources.list.d/flapjack.list
```
