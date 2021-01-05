# VisiData Homebrew Tap

homebrew-vd is a [Homebrew](http://brew.sh) tap for convenient installation and updating of [VisiData](http://visidata.org) on MacOS/X.

If you are looking for installation instructions for VisData on OSes in the Linux family, they are available [here](https://github.com/saulpw/visidata#install).

This tap contains VisiData v2.1.1.

## Install

To install the tap:

```
brew tap saulpw/vd
```

This will enable tracking, updating and installing all formulae made available here through `brew`.

VisiData can then be installed using:

```
brew install visidata
```

and VisiData can then be updated with every subsequent release using:

```
brew update
brew upgrade visidata
```

## Uninstall

To uninstall this tap:

```
brew untap saulpw/vd
```

## Troubleshooting

If you run into `No module named setuptools` errors, then this is likely a known Homebrew conundrum.

Follow the advice [in this issue thread](https://github.com/Homebrew/homebrew-python/issues/216).

## About
VisiData was created and is being developed by [Saul Pwanson](http://saul.pw) &lt;saul@visidata.org&gt;. The homebrew package and tap is maintained by [Anja Kefala](https://github.com/anjakefala) &lt;anja@visidata.org&gt;.
