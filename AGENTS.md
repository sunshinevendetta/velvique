# Velvique agents

Spec: `docs/velvique-agentic-guide.md`. Every agent reads it before touching code, stays inside its lane, and reports to the orchestrator. This file is how agents think and hand off, not a deployment schedule.

## Hard rules (all agents, every PR)

- No SQL, NoSQL, KV, ORM or hosted database. No localStorage, sessionStorage, IndexedDB or cookies for data. No server-side file writes.
- Truth = contract state and events. Blobs = Grove only. Reads = viem against RPC.
- No Privy, no email/password auth. Identity = wallet address, via Coinbase CDP (socials -> smart wallet, or SIWE). Membership = VelviqueAccess ERC-1155.
- No emojis in UI copy. No neon, glitch, scanlines, HUD, chrome text. Blue = the bottle + one active state per screen.
- The label is the light. Never "lamp", "base glow", "party light". Never call it an NFT drop: membership and provenance.

Enforced by `npm run lint` (eslint rules), `npm run check:persistence`, `npm run check:copy`.

## Roster

| Agent | Owns | Delivers | Done when |
| --- | --- | --- | --- |
| Orchestrator | plan, merges, gates | task queue per phase, gate reports | every gate below is green |
| Creative | `content/` | ES/EN copy, meme bank, timestamps, shot list (`media.json` slots), tokens (`content/index.ts`) | `check:copy` clean; tokens consumed by web |
| Contracts | `packages/contracts` (Hardhat 3) | Access, Catalog, Orders, Provenance, Ignition module, `abi/index.ts` in sync | `npx hardhat test` green incl. fuzz, state-machine coverage, Slither clean. Addresses stay out of the web until the client says go |
| Storage | `packages/vault` | Grove wrapper (`publishJson`, `replaceJson`, `uploadMedia`, `removeResource`), ACLs, CMS schemas, envelope, `configureVault` seam | seal/open round trip; manifest edits keep their URI; registry writes from the server key; deletes work |
| Payments | `packages/pay` | rails A/B/C, rail D adapter, paymaster config, 0x | testnet purchase on each rail produces an order token |
| Frontend | `apps/web` (except `scene/`) | all routes, wallet flows, typed chain reads | no persistence outside chain and Grove (lint + grep), all routes render with contracts unset |
| 3D and motion | `apps/web/scene`, `components/motion`, `components/bits`, `components/reactbits` | bottle scene, LED shader, hero master timeline, flash cut, lights out, Flip and DrawSVG, React Bits wrappers | 60 fps mid-range phone at tier 2; GLB < 2.5 MB; vendored React Bits untouched except marked patches |
| QA and security | cross-cutting | Playwright e2e on Base Sepolia, audit checklist, Lighthouse | e2e covers invite, buy, ship, claim; no high findings open |

## Brief template

```text
ROLE: <agent>
OWNS: <folder>  (never write outside it; request changes via orchestrator)
SPEC: sections <n> of docs/velvique-agentic-guide.md
HARD RULES: see AGENTS.md
INPUTS: <ABIs from @velvique/contracts, tokens from @velvique/content, media.json slots>
OUTPUT: <files>, a CHANGELOG entry, and a gate report
DONE WHEN: <gate from the table>
```

## Seams between lanes

| From | To | Contract |
| --- | --- | --- |
| Contracts | Frontend, Payments | `packages/contracts/abi/index.ts` (typed, hand-synced with `src/*.sol`) |
| Storage | Frontend, Payments | `@velvique/vault` (`sealJson`, `uploadEnvelope`, ACL builders), `@velvique/vault/lens` (SDK-free) |
| Payments | Frontend | `@velvique/pay` (client rails), `@velvique/pay/server` (route handlers only) |
| Creative | everyone | `@velvique/content` (`COPY`, `REGIONS`, `TOKENS`, `MEDIA`); articles and events come from Grove |
| 3D | Frontend | `<BottleStage fallbackSlot table spin interactive />` |
| Storage | Frontend (admin) | `@velvique/vault/cms` schemas and transforms; `lib/admin.ts` signs Grove edits with the admin wallet |
