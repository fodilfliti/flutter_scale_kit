# Decisions

Record *why*. Update this file when you change the trade-off.

## D1 — Hybrid cache, not “always Map”

**Choice:** Scalar path uses precomputed multipliers and integer `CacheKey`s; constraint/style objects still use typed maps with LRU.

**Why:** Map lookups on every `.w` were slower than needed. Integer context keys beat string keys. Cap at 2000 avoids leaks in long sessions / dynamic styles.

**Do not:** Go back to unbounded caches, string keys, or Expando on doubles.

## D2 — Map tracker instead of Expando

**Choice:** `SKScaledValueTracker` stores scale marks in a Map and returns a newly created clean `double`.

**Why:** Expando on boxed doubles broke Google Fonts / FFI (`ArgumentError: Invalid argument (object)`). Same path on VM and web/Wasm for consistency.

## D3 — Auto scale limits + orientation boosts

**Choice:** Defaults are device/orientation-aware; users override only for brand-tight or a11y-wide ranges. Boosts run **after** clamps. Font boost ≠ size boost.

**Why:** Raw `screen/design` on iPad/desktop explodes mobile mockups. Landscape needs extra air; portrait should stay closer to the design.

## D4 — Three classification axes

**Choice:** Responsive type, platform category, and width size-class are separate APIs (`DeviceClassificationSource`).

**Why:** A small Chrome window on Windows is not a phone. An iPad width is not iOS-vs-Android. Callers need both CSS-like width queries and OS branching.

## D5 — Drop-in SK widgets with resolve gates

**Choice:** `SKContainer` et al. accept raw doubles **or** already-scaled extension output.

**Why:** Migration is search-replace (`Container` → `SKContainer`) without forbidding `.w` inside those widgets.

## D6 — Optional FontConfig / design tokens

**Choice:** Zero-config works; `FontConfig` and `ScaleKitDesignValues` are additive.

**Why:** Gradual adoption. Do not make Google Fonts a dependency.

## D7 — Agent memory is spec + rules, not README

**Choice:** Agents read `spec/` + code (+ optional codebase-memory graph). `README.md` stays user-facing.

**Why:** README is long, promotional, and duplicates recipes. Spec is short, structured, and versioned with git so every agent/session/machine sees it.
