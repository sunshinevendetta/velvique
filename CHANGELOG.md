# Changelog

## 0.6.2 · 2026-10-14

- Brand icons replace the host defaults: `favicon.ico` (16/32/48), `icon.png` (512) and `apple-icon.png` (180), the client's V monogram in the label blue on black, plus `manifest.webmanifest`.
- Share card for every page (`opengraph-image.png`, `twitter-image.png`, 1200x630): the V lit blue over a soft glow, the wordmark, "La etiqueta es la luz.", tequila añejo cristalino · 100% agave · 700 ml. Metadata adds site name, alternate locale and `summary_large_image`. Built from `LOGO VELVIQUE.jpg.jpeg` (ink to alpha, no redraw).

## 0.6.1 · 2026-10-14

- The bottle story is the brand's source of truth. La botella, Historia now carries the client's text verbatim (EN) and a straight translation (ES), one paragraph per chapter, eight chapters plus intro and close; earlier edits to it are reverted.
- Bottle is 700 ml (was 750 ml in the store order and wholesale copy, ES/EN).
- Journal seed `nacida-del-oficio` claimed Velvique was born in Jalisco from generational tradition, contradicting the story; rewritten from the story as `tres-amigos-y-cap`. If the journal was already published to Grove from /admin, republish it there.

## 0.6.0 · 2026-10-13

- AR fixed on phones. Three causes: React 19 set `ar=""` as a falsy property, so AR was off and every phone got "open on your phone"; the GLB requires `EXT_meshopt_compression` and `EXT_texture_webp`, which Android Scene Viewer can't decode (and iOS Quick Look builds its USDZ from it); and the mode order put WebXR first, so a refused session showed "unsupported" on the first tap. `/ar` now loads `BOTTLE_AR_GLB` (plain copy: decoded, dequantized, PNG texture, 374 KB, same 0.33 m bounds), tries Scene Viewer before WebXR, and reads `canActivateAR` at tap time. The meshopt decoder vendor file is gone (only AR used it).
- La botella, Historia: the client's story in seven chapters (Croacia, the idea, Cap, the craft, the name, the table, the ambassador) plus intro and close, ES/EN. Five client videos (no audio track, no controls; loops that play only on screen, poster still under reduced motion) and two photos, all new to the site, uploaded to Grove immutable and verified by hash. Videos are the originals remuxed (audio removed for good, faststart), never re-cut or cropped.
- Media slots `vq-story-*`; a `poster` on a slot marks it as video, and `/admin` media skips those.

## 0.5.0 · 2026-10-08

- Palette from `PANTONE.jpeg`: blue `#4EA9D5` (was `#3D7BFF`) everywhere, LED shader included. Ground back to the blue-black `#08080A` / `#0D0D11` (Pantone K95 `#313030` kept as `TOKENS.pantoneBlack` for print; it reads grey on a display). Every text colour is solid: labels gold `#C9AB55`, tertiary text a pale Pantone-blue tint `#8FB0C4`, hairlines the blue at low alpha. Alpha gold over black had turned olive and unreadable.
- Every photo is a React Bits card: `Evidence` renders TiltedCard + GlareHover by default (`flat` only for the hero iris and the Stack prints); journal covers and thumbnails, store bottles and event posters go through the same `Poster`; markdown photos get GlareHover. Found objects on home get the flash pass. Spec grids (home, verify, order, event, pass) and the botella process, verify list and journal rows sit in SpotlightCard; wholesale terms are BorderGlow cards.
- Cards are React Bits now. New vendored: BorderGlow (`Edge`), SpotlightCard (`Slab`, blue beam), TiltedCard (`Poster`), CardSwap (`Swap`, patched class name), Lanyard (`PassLanyard`, pass art drawn on canvas in brand colours), Stack (`Prints`), GlareHover (`Flash`), CircularText (`Seal`), CountUp (`Count`). Magnet (`Pull`) and ShinyText (`Shiny`) wired back in, Magnet only where the blue action stands alone. Map in `components/reactbits/README.md`.
- Home after strip: a pile of flash prints you drag through, frame number and time following the top print. Events: lit flyer slabs with poster-size dates, tilted posters, past nights as one lit list. Members: pass on a lanyard, wide and narrow doors, perks under one light, seal. Store: shelf with first bottle featured, flash photo, tier seal, count. La botella: certification seals, tasting notes under the light, stepped rituals. Mayoreo: the four pillars as a dealing deck. Journal: tilted lead cover, subscribe card. Acceso: the received pass drops in on its strap.
- New `.flyer` type (Barlow Condensed at poster size) for dates, prices, volumes, counts. Copy: `noche.a_pile`, `noche.a_hint`.

## 0.4.0 · 2026-10-08

- Logo: `public/logo.png` (trimmed to the ink) replaces the text wordmark in header, menu, age gate, footer, hero and the paper card, via `components/chrome/Logo.tsx` (CSS mask, takes `currentColor`; hero keeps the sheen). `ShinyText` wrapper removed.
- Hero dive: the iris opens onto `vq-flash-01`, zooming from 1.6x to fill as the circle reaches the edges; the meme fades in after. Evidencia's static block shows only for reduced motion. Magnet removed from the CTA (it slid over the scan button).
- Copy aligned with `Velvique_PitchDeck_ES.pdf`: 100% agave azul, Kosher · Orgánico · NOM, rich and creamy, lightly chilled, cocktails. New: bottle story and certifications, wholesale proposal (four pillars), footer tagline.
- Gold from the deck (`#C4A448`, `TOKENS.gold`) as hairlines and small numerals only.
- Diario reads like a publication: lead post, subscribe line (membership is the subscription), kind filter, rows with thumbnails, byline and reading time, share bar (copy, X, WhatsApp), keep reading. Markdown photo grids. Articles gain optional `kind`, `author`, `minutes`.
- Ten starter articles ES/EN in `content/diario.json`, shown while the Grove manifest has no articles; `/admin` publishes them to Grove in one pass. Seven event photos uploaded to Grove (immutable, verified by hash), one use each.
- `/miembros`: the pass as a tilting card with sheen, "No se compra. Se recibe.", six perks; before contracts are live an "Abre pronto · Generación 01" block replaces the not-configured line.
- Membership and access copy speaks to non-crypto people: no ERC-1155, Base, gas, wallet or "en cadena" in the pitch; accounts are Google, Apple, X (wallet stays as a quiet second door). Pass card redesigned (bottle ribs, gold inner frame, holder shown by account name); fixed the logo flying out of the card (`vq-breathe` carries a centering transform; new opacity-only `vq-glow-breathe`).
- `/verificar` is about the bottle: what the serial is, how the registry works, why it matters, what you'll see, FAQ (blockchain explained once, plainly), drawn serial card. Result page in plain language, no addresses.
- `/mayoreo` request needs no wallet: posts to `/api/mayoreo`, which emails the brand through Brevo (`BREVO_API_KEY`, `BREVO_SENDER`, `MAYOREO_TO`); unset = placeholder that accepts the request. Name, email, optional phone, honeypot.
- AR fixed: `<model-viewer>` now gets `meshoptDecoderLocation` (`public/vendor/meshopt_decoder.js`, from meshoptimizer) before the first load; the meshopt GLB failed with "setMeshoptDecoder must be called". Renamed for everyone: "La botella en tu mesa", camera-first copy, three steps, drag hint; "AR" gone from the copy. Control bar above the viewer (Abrir cámara, flash photo, 8 s video recorded from the viewer canvas while the bottle turns); on desktop the camera button explains to open the page on a phone. Brighter neutral lighting. Checked headless against the dev server: model loads, photo and video produce files.
- Verified: `check:copy`, `check:persistence`, web typecheck clean. Not run: build, dev, lint, any visual check.

## 0.3.1 · 2026-10-04

- The client bottle replaces the procedural one. `bottle.glb` (1.24 MB) optimized with gltfjsx `--transform` to 40 KB (Draco + 1024 WebP), baked to meters, shipped as `apps/web/public/models/bottle.glb`.
- `scene/BottleModel.tsx` renders it; the baked texture drives the emissive label; breathing and selective bloom unchanged; spill light moved to the GLB's label height.
- AR uses the same GLB at real size. Removed: `buildBottle.ts`, `labelTexture.ts`, `exportBottle.ts` (constants now in `scene/bottle.ts`).
- `/la-botella` bottle: OrbitControls replace drag-to-turn. Full 360 orbit, up and over, zoom 1.1 to 9 units, no pan; above the table only.
- Bottle canvases go full bleed (100vw) on `/` and `/la-botella`; the table fades out radially instead of ending in a hard rim.
- Not run: build, dev, visual check of material tuning and framing.

## 0.3.0 · 2026-10-03

- Membership is onchain: VelviqueAccess gains `mintMembership` (MINTER_ROLE relayer), one membership per identity (`memberOfIdentity`), optional invite nonce, `releaseIdentity`, `memberCount`. Ignition `Membership.ts` deploys only this.
- Identity through Coinbase CDP embedded wallets: Google / Apple / X create a Coinbase smart wallet; own wallets come in through WalletConnect and SIWE, then link socials.
- Starting a session claims the membership: `/api/members/me`, `/api/members/mint` (server validates the CDP token, socials and wallet ownership; relayer mints), `/api/members/open` gated by `passOf`.
- Admin members tab reads holders from chain events; grant and revoke from the admin wallet (ADMIN_ROLE).
- Removed: Grove members registry, `/api/members/session`, `/api/members/join`, `/api/admin/members`.
- wagmi moved to 2.x for the CDP connector.
- Verified: 25 Solidity tests pass on Hardhat 3 (8 new membership tests; the earlier 17 ran for the first time), typed ABIs match the compiler. Not run: install, typecheck, build, dev, live CDP sign-in.

## 0.2.0 · 2026-10-03

- Contracts toolchain: Hardhat 3 (viem toolbox, Ignition). Foundry config and scripts removed; Solidity tests kept. Addresses not wired to the web.
- React Bits: SplitText, BlurText, ShinyText, Noise, ScrollVelocity, Magnet, FlowingMenu, Masonry, ScrollReveal vendored from reactbits.dev; brand wrappers replace the earlier rewrites.
- GSAP: full plugin set with brand eases; pinned hero master timeline, DrawSVG section rules, Flip journal filter and archive lightbox.
- Grove CMS: site manifest + article/event docs; admin console at /admin (journal, events, flash archive, media slots, members).
- New routes: /diario, /diario/[slug], /eventos, /eventos/[slug], /miembros, /admin. /acceso joins members while contracts are off.
- Members access without contracts: Grove registry, invitation codes (`invite.mjs qr`), sealed members content opened server-side, wallet-signature sessions in memory.
- Verified: members encryption round trip (tamper and wrong key rejected), CMS manifest transforms, script codes accepted by the server verifier, copy and persistence checks. Not run: install, typecheck, build, dev.

## 0.1.0 · 2026-10-03

- Retired the HTML prototype (`Velvique v2.dc.html`); its six-section night, age gate, acceso flow, menu, copy and tokens now live in `apps/web` (Next.js 16, React 19.3, TS strict).
- Contracts: VelviqueAccess, VelviqueCatalog, VelviqueOrders, VelviqueProvenance, deploy + seed scripts, Foundry tests (unit + fuzz). Compiled clean with solc 0.8.28; Foundry tests not yet run.
- Vault: envelope, WebCrypto staging vault, Grove client and ACL builders.
- Pay: quotes, USDC permit, rails A (USDC), B (0x), C (Coinbase Headless, flagged off), D (interface).
- Web: all ten routes from guide section 3, AppKit + Base Account wallets, sponsored calls via paymaster proxy, procedural LED bottle with selective bloom and device tiers, AR with live GLB export, React Bits set restyled.
- Guardrails: eslint persistence/database/Privy bans, `check:persistence`, `check:copy`.
