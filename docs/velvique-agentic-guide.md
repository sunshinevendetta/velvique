# Velvique — Agentic Guide

Oct 3, 2026 · @sunshine vendetta

This is the spec every agent reads (see `AGENTS.md`). Section 10 records decisions taken while converting the prototype to the Next.js codebase; where it conflicts with an earlier section, section 10 wins.

## 1. Brand intel

Velvique is an early-stage, invitation-only añejo cristalino whose one ownable asset is the LED-lit bottle. The site has to turn that bottle into the whole world.

| Signal | What we know | Source |
| --- | --- | --- |
| Product | Tequila añejo cristalino, oak-aged, then charcoal-filtered clear. Bio line: full-bodied, crystal-smooth, slightly dangerous. | Instagram bio (client) |
| Pronunciation | vel-VEE-KEH | Instagram bio |
| Sales model | Venta solo por invitación (private sale) | Instagram bio |
| Audience size | 81 posts, 1,574 followers, 70 following | Instagram (as provided) |
| Existing site | velviquetequila.com is live; premium cristalino, smooth dolce notes, rule-breaker tagline; blocks crawlers | velviquetequila.com |
| Origin story | Founded by a collective of tequila connoisseurs; the site already calls out the glowing LED bottle as a table centerpiece | velviquetequila.com |
| Bottle | Tall black faceted bottle, black cap, blue LED label with a V monogram and wordmark; a QR code on the label | Client images 1 to 3 |
| Language | Spanish-first captions in a meme setup and punchline format | Client images 1 and 2 |

**Positioning:** the only cristalino that is also a light source. Every page, photo and interaction treats the LED as the one light in the room.

### Competitive intel

Closest rival is Volcán X.A (tall faceted bottle, built-in LED, bottle-service-first launch). On the liquid, Velvique is priced against Don Julio 70 and Dobel Diamante. Onchain, every big tequila brand so far rented a third-party NFT marketplace instead of owning its rails.

**Direct threats: light and nightlife**

| Brand | What they do | Price seen | Lesson for Velvique |
| --- | --- | --- | --- |
| Volcán de Mi Tierra X.A | Slim faceted gold-ombre bottle, factory LED in the base; bars and clubs before retail | US $154.99; EU €251.95 | Their light glows from the base (solid / pulsing); Velvique lights the logo itself. Claim the label as the light. Reviews complain about cheap packaging and cap: unboxing is a gap to win. |
| Oculto (AB InBev) | Tequila-flavored beer with LED smart labels; scan opened a night-themed web app | Mass market | Lit label + night web app has been done at mass scale. Velvique must read as luxury and invitation-only, not a gimmick. |
| Club bottle service norm | LED bottle glorifiers are standard POS kit | n/a | Blue light alone reads as club furniture. Restraint (one light, candle-like) separates Velvique. |

**Cristalino benchmarks (liquid)**

| Brand | Position | US price | Mexico price |
| --- | --- | --- | --- |
| Maestro Dobel Diamante | First cristalino (2008) | ~$42 to $80 | ~$800 MXN |
| Don Julio 70 | First añejo cristalino (2012), category reference | ~$55 to $100 | ~$1,200 MXN |
| Herradura Ultra | Aged up to 49 months, filtered | ~$43 to $60 | ~$900 MXN |
| 1800 Cristalino Añejo | Mass premium | ~$57 | ~$800 MXN |
| Volcán Cristalino | Same house as X.A | ~$73 | ~$1,900 MXN |
| Contraluz Cristalino | Maluma-backed, entry price | $42.99 SRP | not found |

Table neighbors in clubs: Clase Azul Reposado ~$253, Don Julio 1942 ~$238.

**Onchain precedents:** Patrón on BlockBar (150 bottles at 1.5 ETH), 1800 Colección auction ($25,000), Avión Lucky Liquid (100 NFTs at $495, vaulted), Clase Azul on BAXUS (secondary), ETHQUILA (label as members card).

**What agents take from this**

- Language: the label is the light. Never describe the LED as a lamp, base glow or party feature.
- Onchain angle: Velvique owns its rails, uses them for everyday bottles, frames it as membership and provenance, never as an NFT drop.
- Price corridor to confirm with the client: above Don Julio 70, below Clase Azul and 1942, unless a limited edition.
- Show the box and the opening ritual (Volcán's weak spot).

## 2. Brand DNA and creative direction

**The Morning After**: like The Hangover, the site reconstructs a night that already happened from the evidence left behind, shot with Cobrasnake-style direct flash; the bottle's LED is the only light that guides you through it.

**Core codes**

- Light: darkness is the canvas. Two light sources only: the blue LED and the camera flash.
- Time: every section is a timestamp (11:48 PM arrival, 2:10 AM the after, 5:30 AM the evidence).
- Evidence: flash photos, guest list, wristband, receipt, voice note. Found objects, not product marketing.
- Voice: Spanish-first, bilingual, deadpan. Two-beat caption meme (Nosotras: algo tranqui / Velvique: nos vemos en el after) as a repeatable system.
- Luxury restraint: lacquer black, bone white, one electric blue. Wide-tracked serif wordmark (Bodoni Moda) + condensed grotesk (Barlow Condensed) for captions and timestamps.

**Guardrails**

- The LED reads as candlelight, not neon. No grids, scanlines, glitch, HUD overlays, chrome text or synth-city backdrops.
- Blue is reserved for the bottle and one active state per screen.
- Faces are guests, never models looking at camera.

**Photo direction shift**

|  | From (image 3, current ad) | To (images 1 and 2) |
| --- | --- | --- |
| Light | Warm amber practicals, even fill | Direct on-camera flash, hard falloff, LED as practical |
| Pose | Over-the-shoulder look to camera | Candid, mid-laugh, hair in motion |
| Framing | Wide, centered, catalog | Cropped, tilted, partial faces, hands and glassware |
| Texture | Clean, retouched | Grain, motion blur, slight overexposure on skin |
| Bottle | On bar like a product shot | Held, passed, on a low table, glowing |
| Copy | Serif tagline block | Caption-meme overlays, timestamps |

**Shot list:** bottle passed hand to hand in flash; LED as the only light on a table at 4 AM; dance floor with the bottle raised; empty table at dawn with the bottle still lit; guest list and wristband flat lay; clear liquid poured over one large ice cube. (Slots in `content/media.json` map 1:1 to this list, plus the unboxing.)

## 3. Site map and experience architecture

| Route | Access | Purpose | Data source |
| --- | --- | --- | --- |
| age gate overlay | Public | Region-aware legal age, in memory only | None |
| `/` La Noche | Public | Scroll narrative, 3D bottle hero, flash transitions | Static + Grove media |
| `/diario`, `/diario/[slug]` | Public; some entries members | Journal; members bodies sealed | Grove manifest + article docs |
| `/eventos`, `/eventos/[slug]` | Public; members details | Upcoming and past nights; exact address sealed for members | Grove manifest + event docs |
| `/miembros` | Wallet + membership | Members journal, private nights, redeem code | Grove registry |
| `/admin` | Admin wallets | Publish articles, events, archive, media; manage members | Grove (admin-signed edits) |
| `/la-botella` | Public | Liquid, process, notes, the LED, rituals, unboxing | Grove JSON |
| `/el-after` | Public | Flash archive, caption memes, events | Grove manifest |
| `/acceso` | Public | Redeem invitation (link, QR or code), mint pass | EIP-712 voucher + Access |
| `/tienda` | Pass holders | SKUs, checkout (USDC, any token, card) | Catalog |
| `/pedido/[id]` | Order owner | Status timeline, receipt token | Orders + encrypted Grove blob |
| `/verificar/[serial]` | Public | Bottle QR: authenticity + digital twin claim | Provenance |
| `/mayoreo` | Public info, pass for pricing | Wholesale story, formats, MOQ, regions, inquiry | Grove JSON + encrypted Grove inquiry |
| `/ar` | Public | Place the glowing bottle, flash photo | GLB / USDZ |

**Flows**

1. Invitation: signed link or event QR, connect or create a wallet, mint a non-transferable pass. No email, no account table.
2. Purchase: pass holder picks SKU, pays USDC or card, receives an order receipt token; the address leaves the browser only as an encrypted blob.
3. Wholesale: public brief, inquiry, Mayoreo pass after approval, tier pricing in the same store.
4. Bottle in hand: label QR verifies the bottle and lets the buyer claim its digital twin.

Language: Spanish default, English toggle, all copy in Grove JSON per locale.

## 4. Technical stack

Next.js App Router, strict TypeScript, Vercel, Base, Grove as the only storage, no database, no auth vendor.

| Layer | Choice |
| --- | --- |
| Framework | Next.js 16 (App Router), TypeScript strict |
| React | 19.3 (decided, see section 10) |
| 3D | three.js via @react-three/fiber 9, drei 10, @react-three/postprocessing 3 (selective bloom for the LED) |
| Motion | GSAP 3.15 full plugin set (ScrollTrigger, SplitText, Flip, DrawSVG, CustomEase, Observer) + Lenis; motion 12 for React Bits text |
| UI motion kit | React Bits, vendored from reactbits.dev (TS-CSS); brand wrappers in `components/bits` |
| Wallet | wagmi 3 + viem, Reown AppKit, Base Account (passkey), injected. No Privy |
| Chain | Base (8453), Base Sepolia (84532) for staging |
| Contracts | Solidity, Hardhat 3 (viem toolbox, Ignition), OpenZeppelin 5; Safe as owner and treasury. Not wired to the web yet |
| Storage | Grove via @lens-chain/storage-client |
| Messaging | Encrypted Grove inquiry + onchain event (XMTP deferred, see section 10) |
| Onramp | Coinbase Headless (US); rail D provider TBD for MX/LATAM |
| Swap | 0x Swap API v2 |
| AR | model-viewer: WebXR on Android, Quick Look on iOS |

**React Bits shortlist:** Split Text, Blur Text (timestamps, ledes); Shiny Text (wordmark under the LED only); Masonry (el-after); Flowing Menu; Magnet (primary CTA only); Noise (grain); Scroll Velocity (caption-meme ticker). Excluded on purpose: Glitch Text, Decrypted Text, Letter Glitch, Faulty Terminal, Hyperspeed, anything with scanlines or matrix rain.

**Hard rules for every agent**

- No SQL, NoSQL, KV, ORM or hosted database. No localStorage, sessionStorage or IndexedDB for data. No server-side files.
- Source of truth = contract state and events. Blobs = Grove only. Reads = viem against RPC.
- No Privy, no email or password auth. Identity = wallet address.
- No emojis in UI copy.

## 5. Onchain data architecture

Contracts hold every fact that must be verifiable; Grove holds every blob, encrypted when private; the chain stores only the lens:// URI and a content hash.

| Contract | Standard | Holds | Key functions and events |
| --- | --- | --- | --- |
| VelviqueAccess | ERC-1155 soulbound | Tiers Invitado, Socio, Mayoreo | `redeem(voucher, sig)`, `grant`, `requestAccess`; `PassMinted`, `AccessRequested` |
| VelviqueCatalog | Custom | SKU price (USDC 6dp), cap, per-wallet limit, tier, region mask, metadata URI | `listSkus`, `getSku`, `setSku`; `SkuUpdated` |
| VelviqueOrders | ERC-721 soulbound receipt | sku, qty, amount, status, encrypted shipping URI + hash | `purchase`, `purchaseWithPermit`, `purchaseFor`, `advance`, `refund`, `sweep`, `ordersOf`; `OrderPlaced`, `OrderStatus` |
| VelviqueProvenance | Registry | serial hash to order and owner | `register`, `claim(serial)`, `verify(serialHash)`; `BottleClaimed` |
| Treasury | Safe | Proceeds, ownership, roles | SIGNER, FULFILLER, ADMIN |

Status machine: Placed, Paid, Packing, Shipped, Delivered, Claimed, or Refunded (only before Shipped). Every transition emits an event.

**Reading without a database:** contract views paginate (`ordersOf`, `listSkus`, `passOf`); history = `getLogs` bounded by the order's creation block; server caches are short and disposable.

**Grove layout**

| Content | ACL |
| --- | --- |
| Brand media, copy JSON, SKU metadata | Wallet-only, treasury Safe signer |
| Bottle GLB, USDZ, posters | Immutable |
| Shipping blob per order | Generic ACL on `VelviqueOrders.isFulfiller(address)`; fallback wallet-only fulfiller. Deleted after Delivered |
| Wholesale inquiry blob | Wallet-only, fulfillment wallet |

Verify `genericAcl(...)` resolves calls against Base before relying on it (`NEXT_PUBLIC_GROVE_GENERIC_ACL=1` only after that test passes).

**Encryption envelope** (`packages/vault/src/envelope.ts`): `{ v, alg, recipient, ct, sha256 }`. Browser seals with the fulfillment public key, uploads to Grove, calls purchase with the lens:// URI and `sha256`. Plain personal data never touches a server, disk or calldata. The proprietary encryptor plugs in via `configureVault()`.

## 6. Payments and onramp rails

Every path ends as USDC on Base in VelviqueOrders, swept to the Safe after delivery.

| Rail | Pays with | Coverage | Status |
| --- | --- | --- | --- |
| A. Direct USDC | USDC permit + purchase | Global | Built |
| B. Any token | ETH / Base tokens via 0x v2, then rail A | Global | Built (flag `NEXT_PUBLIC_RAIL_SWAP`) |
| C. Card, US | Coinbase Headless, USDC to Base Account, batched approve + purchase, paymaster | US | Built behind `NEXT_PUBLIC_RAIL_CARD_US`; needs phone OTP (section 9) |
| D. Card, MX/LATAM | Provider TBD | MX/LATAM | Interface only |

**Guarantees in code:** price read from the catalog at signing; contract rejects stale quotes; fulfillment watches `OrderPlaced` only (never webhooks); refunds go to the paying address in USDC.

## 7. 3D bottle, LED shader and AR

- Client bottle GLB (`apps/web/public/models/bottle.glb`, ~40 KB): one mesh, one baked texture that is both print and LED mask. Optimized with `gltfjsx --transform` (Draco geometry, 1024 WebP), baked in meters (0.33 m, base at y = 0, label facing +Z). Served from Grove: `BOTTLE_GLB` in `apps/web/scene/bottle.ts` (https://api.grove.storage/4f9098d4c0b312c9be3759133030b27947090e732f1d5b8ef5ceb04f9b70625c). Rendered by `apps/web/scene/BottleModel.tsx`. AR (`/ar`) loads a plain copy instead, `BOTTLE_AR_GLB` (no meshopt, no quantization, PNG texture, ~370 KB): Android Scene Viewer cannot decode meshopt or WebP and iOS Quick Look builds its USDZ from it. Rebake it whenever the main GLB changes.
- Glass: black, low roughness, low metalness on the GLB material; no transmission (the GLB is a single opaque shell).
- LED: emissive map of the V monogram and wordmark, `toneMapped: false`, selective bloom at threshold 1, cosine breathing over 5 s (4 to 6 allowed), never a flicker.
- Spill: blue point light at the label (rect area light optional once the GLB lands).
- Environment: near-black with one warm practical far behind.
- Interactions: flash cut at section boundaries (GSAP), lights out (scrubbed dim of `[data-dim]`), pass the bottle on `/el-after`.
- AR: model-viewer on the same GLB at real size. Flash photo composes caption meme + timestamp in memory.
- Performance: three tiers (full, no transmission, video/still fallback), 3D loads after the shell, render loop stops off screen.

## 8. Agent roster and operating rules

See `AGENTS.md`.

## 9. Risks and open questions

| Risk | Mitigation |
| --- | --- |
| Coinbase card rail is US-only | Rail D provider shortlist (thirdweb Payments, Transak, MoonPay, Bitso Business) |
| Coinbase Headless needs verified email + phone | Forward-only (never stored); needs an OTP step before `NEXT_PUBLIC_RAIL_CARD_US=1`. Conflicts with "no email" spirit; client decision |
| Alcohol shipping rules | Region mask per SKU, enforced in contract and UI; client confirms licensed regions |
| Age threshold (18 MX, 21 US) | Region-aware gate |
| Encrypted data permanence | Only URI + hash onchain; shipping blobs deletable, deleted after Delivered |
| Heavy RPC reads | Enumerable views, batching, short disposable caching, paid Base RPC |
| Grove generic ACL against Base | Storage agent tests first; wallet-only fallback is the default |
| LED drifting to cyber look | Section 2 guardrails as review checklist; `npm run check:copy` bans terms |

## 10. Decisions log

| Date | Decision | Why |
| --- | --- | --- |
| 2026-10-03 | React 19.3 + Next 16 + R3F 9 | Current line; React 18 would pin Next 14 and R3F 8 |
| 2026-10-03 | Monorepo: `apps/web`, `packages/{contracts,vault,pay}`, `content/` | Mirrors agent ownership lanes |
| 2026-10-03 | Wholesale inquiries via encrypted Grove + `AccessRequested` event; XMTP deferred | XMTP browser SDK keeps a local OPFS/IndexedDB database, which breaks the no-browser-persistence rule |
| 2026-10-03 | wagmi `noopStorage` | No app state persisted in the browser; wallet SDKs keep their own session keys (wallet storage, not app data) |
| 2026-10-03 | Typed invitation codes are stateless (HMAC), one-time via onchain nonce | No code list anywhere |
| 2026-10-03 | Escrow in VelviqueOrders until Delivered, then `sweep()` to Safe | Refunds possible before shipping without touching the Safe |
| 2026-10-03 | Receipts and passes soulbound | `ordersOf` without an indexer; provenance tied to the buyer |
| 2026-10-03 | model-viewer for both AR platforms | Its `webxr` mode is three.js immersive-ar with hit-test; one code path |
| 2026-10-03 | HTML prototype retired | Its layout, copy and interactions live in `apps/web` now |
| 2026-10-03 | Hardhat 3 replaces Foundry | Team standard; Solidity tests kept (Hardhat runs `.t.sol` with forge-std from npm) |
| 2026-10-03 | Contract addresses out of the web for now | Content, events and members first; commerce waits for the client's go |
| 2026-10-03 | Grove CMS: one mutable site manifest + one JSON per article/event, admin wallet ACL | Admin publishes without redeploys; the manifest URI never changes |
| 2026-10-03 | Membership = soulbound ERC-1155 on VelviqueAccess, minted by a MINTER_ROLE relayer on session start | The brand controls access onchain (grant, upgrade, revoke); members pay and sign nothing |
| 2026-10-03 | Identity via Coinbase CDP embedded wallets: socials (Google, Apple, X) create a smart wallet; own wallets enter via WalletConnect + SIWE and link socials | User request; Coinbase, not Privy. CDP token verified server-side with `validateAccessToken` |
| 2026-10-03 | One membership per identity: salted CDP user id stored as `memberOfIdentity` onchain | Sybil control without a database |
| 2026-10-03 | wagmi pinned to 2.x | `@coinbase/cdp-wagmi` 0.0.126 peers on wagmi ^2.16 |
| 2026-10-03 | Known exception: CDP SDK keeps its auth session in localStorage | Identity-provider session (like wallet SDK pairings), not app data |
| 2026-10-03 | React Bits vendored verbatim with 3 marked patches | Re-pullable; brand lives in wrappers + `reactbits-theme.css` |
