# Packaging and Distribution of Flapjack

Flapjack follows the version numbering conventions as set out in the [Semantic Versioning 2.0](http://semver.org/spec/v2.0.0.html) specification. Specifically:

> Given a version number MAJOR.MINOR.PATCH, increment the:
>
> * MAJOR version when you make incompatible API changes,
> * MINOR version when you add functionality in a backwards-compatible manner, and
> * PATCH version when you make backwards-compatible bug fixes.
>
> Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

For Flapjack 0.9.x, we provide a Precise package at:

```
deb http://packages.flapjack.io/deb/ precise main
```

For the Flapjack 1.x series, we provide [Ubuntu packages](http://packages.flapjack.io/deb/) for Precise and Trusty.  These are split into the following categories:

## Precise

```
deb http://packages.flapjack.io/deb/1.0 precise main
```

## Trusty

```
deb http://packages.flapjack.io/deb/1.0 trusty main
```

In future, packages from the Flapjack 2.x series will be available at:

```
deb http://packages.flapjack.io/deb/2.0 trusty main
```

An experimental component is used for pre-release builds.  This is for testing purposes, and we would not recommend running packages from experimental in production.

```
deb http://packages.flapjack.io/deb/flapjack_version distro_release experimental
```
