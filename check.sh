#!/usr/bin/env bash
# This scripts runs various CI-like checks in a convenient way.
set -eux

RUSTFLAGS="-D warnings"
RUSTDOCFLAGS="-D warnings" # https://github.com/emilk/egui/pull/1454

cargo build --all-features
cargo check --workspace --all-targets --all-features
cargo check -p re_viewer --all-features --lib --target wasm32-unknown-unknown
cargo fmt --all -- --check
cargo clippy --workspace --all-targets --all-features --  -D warnings -W clippy::all
cargo test --workspace --all-targets --all-features
cargo test --workspace --doc --all-features

cargo doc --lib --no-deps --all-features
cargo doc --document-private-items --no-deps --all-features

(cd crates/re_comms && cargo check --no-default-features)
(cd crates/re_log_types && cargo check --no-default-features)
(cd crates/re_viewer && cargo check --no-default-features --lib)
(cd crates/re_web_server && cargo check --no-default-features)
(cd examples/nyud && cargo check --no-default-features)
(cd examples/objectron && cargo check --no-default-features)

(cd crates/re_comms && cargo check --all-features)
(cd crates/re_log_types && cargo check --all-features)
(cd crates/re_viewer && cargo check --all-features)
(cd crates/re_web_server && cargo check --all-features)
(cd examples/nyud && cargo check --all-features)
(cd examples/objectron && cargo check --all-features)

./crates/re_viewer/wasm_bindgen_check.sh

cargo deny check

echo "All checks passed!"
