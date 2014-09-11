#Flapjack Packages

Packages for the 0.9.x and 1.x series are currently available for Ubuntu.

## Add Repository

Add the [deb repo](http://packages.flapjack.io/deb) to your apt sources:


### 1.x Series
#### Trusty

```
echo "deb http://packages.flapjack.io/deb/v1 trusty main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

#### Precise

```
echo "deb http://packages.flapjack.io/deb/v1 precise main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

### 0.9.x Series
#### Trusty

```
echo "deb http://packages.flapjack.io/deb trusty main" | sudo tee /etc/apt/sources.list.d/flapjack.list
```

#### Precise

```
echo "deb http://packages.flapjack.io/deb precise main" | sudo tee /etc/apt/sources.list.d/flapjack.list
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
# trusty:

echo "deb http://packages.flapjack.io/deb/v1 trusty experimental" | sudo tee /etc/apt/sources.list.d/flapjack.list

# precise:

echo "deb http://packages.flapjack.io/deb/v1 precise experimental" | sudo tee /etc/apt/sources.list.d/flapjack.list
```
