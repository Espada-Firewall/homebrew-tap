# Homebrew tap for Espada

[Espada](https://espadafirewall.com) is the **Agent Action Firewall** — a
self-hosted infrastructure agent that runs inside your network and gates
Claude, GPT-4, or your own agents from running `terraform plan`,
`kubectl apply`, `aws deploy` in your real cloud without a hardware-key
signature.

## Install

```bash
brew install espada-firewall/tap/espada
```

That is shorthand for:

```bash
brew tap espada-firewall/tap
brew install espada
```

## What it ships

A pre-built, fully self-contained tarball per release. Currently
`darwin/arm64` only — Linux + Intel macOS builds will follow when the
source repo goes public. The tarball ships with `node_modules/` already
vendored: `brew install` runs no `pnpm install`, no postinstall scripts,
no network installs.

## Releases

Releases are cut by the source repo's `scripts/publish-tap-release.mjs`,
which:

1. Builds `release/espada-<version>-darwin-arm64.tar.gz` + `.sha256`.
2. Creates a `v<version>` GitHub release on this repo and attaches both
   assets.
3. Rewrites `version` + `sha256` in `Formula/espada.rb` and pushes.

## Verifying a release

Every tarball has a matching `.sha256` file in the release assets. To
verify by hand:

```bash
shasum -a 256 espada-<version>-darwin-arm64.tar.gz
# compare against the .sha256 file
```

## License

The formula is MIT. Espada itself is also MIT — see the source repo's
`LICENSE`.

## Previous tap

This tap replaces [`saifaldin14/homebrew-espada`](https://github.com/saifaldin14/homebrew-espada),
which is now archived. Anyone still tapped there should:

```bash
brew untap saifaldin14/espada
brew install espada-firewall/tap/espada
```
