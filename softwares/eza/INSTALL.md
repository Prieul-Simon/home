# Installation

eza is available for Windows, macOS and Linux.

### Cargo (crates.io)

If you already have a Rust environment set up, you can use the `cargo install` command:

    cargo install eza

Cargo will build the `eza` binary and place it in your `CARGO_INSTALL_ROOT`.
For more details on installation location see [the cargo
book](https://doc.rust-lang.org/cargo/commands/cargo-install.html#description).

### Cargo (git)

If you already have a Rust environment set up, you can use the `cargo install` command in your local clone of the repo:

    git clone https://github.com/eza-community/eza.git
    cd eza
    cargo install --path .

Cargo will build the `eza` binary and place it in `$HOME/.cargo`.

### Manual (Linux)

Example is for x86_64 GNU, replaces the file names if downloading for a different arch.

```shell
wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
sudo chmod +x eza
sudo chown root:root eza
sudo mv eza /usr/local/bin/eza
```
