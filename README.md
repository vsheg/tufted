# `tufted`

A static website template built using Typst's experimental HTML export. Requires no external dependencies other than basic `make`.

![Tufted website](assets/devices.webp)

## Installation

Initialize the template from the Typst package registry:

```shell
typst init @preview/tufted:0.0.1
```

## Usage

To build the website, run:

```shell
make html
```

Explore the `content/` folder for examples. A live demo with more information is available at [tufted.vsheg.com](https://tufted.vsheg.com).

### Nushell

As an alternative to the Makefile, there is also a [Nushell](https://www.nushell.sh/) script that you can run with:

```
nu serve.nu
```

This will write the website to the `_site` directory, and also with the combination of a live server such as [`live-server`](https://github.com/lomirus/live-server) you can enjoy instant hot-reloading when editing the `.typ` files

## License

The source code is available on [GitHub](https://github.com/vsheg/tufted) under the [MIT License](LICENSE). The template in the `template/` directory uses the more permissive [MIT-0](https://opensource.org/licenses/MIT-0) license.
