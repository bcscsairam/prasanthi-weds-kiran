# Prasanthi weds Kiran — Wedding Invitation Website

A single-file wedding invitation site. Modern pastel stationery with Telugu
temple detailing: a fine-line gopuram crown, mango-leaf toran, monoline kalasham
and deepam pair, kumkum accents and an ultra-faint kolam ground. The couple's
names blink with gold light, and a tap anywhere blows a gust of pastel flowers
across the screen.

**Live:** [prasanthi-weds-kiran.netlify.app](https://prasanthi-weds-kiran.netlify.app/)
**Wedding:** Thursday, 27th August 2026 · Muhurtham at 11:41 PM
**Venue:** Dhanavarsha Function Hall, Ganti Road, P. Gannavaram,
Dr. B.R. Ambedkar Konaseema District, Andhra Pradesh

---

## What's in this folder

| File | What it is |
|---|---|
| `index.html` | **The entire website.** Markup, styles, scripts and the couple's portrait are all inside this one file. |
| `deploy.sh` | One command to push updates live. |
| `DEPLOY.md` | The live link, how updates reach it, and the phone test. |
| `README.md` | This document — how to edit it. |

There is **no build step, no `npm install`, no dependencies.** The portrait is
embedded as base64, so there are no image paths that can break when you move the
file. The only thing loaded from the internet is the Google Fonts stylesheet.

> **Keep the filename `index.html`.** Every hosting platform serves that name
> automatically at the root URL. Rename it and guests will have to type the
> filename in the address bar.

**Already published.** Edits go live by saving, then running `bash deploy.sh` —
see `DEPLOY.md`. The rest of this document is about what to edit.

---

## Working on it in VS Code

```bash
code .
```

### Preview while you edit

**Option A — just open it.** Right-click `index.html` in the sidebar →
*Reveal in File Explorer / Finder* → double-click. Press
<kbd>Ctrl</kbd>/<kbd>Cmd</kbd>+<kbd>R</kbd> after each save.

**Option B — Live Server (recommended).** Auto-reloads on save.

1. Extensions (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>X</kbd>)
2. Search **Live Server** by Ritwick Dey → Install
3. Right-click `index.html` → **Open with Live Server**

**Test on your phone.** With Live Server running, note the address it shows
(e.g. `http://192.168.1.5:5500`) and open that on your phone on the same Wi-Fi.
The whole design is mobile-first — the tap-to-open reveal, the flowers and the
WhatsApp RSVP all behave differently on a phone than on a laptop.

---

## Editing the invitation

Everything is in `index.html`. Use <kbd>Ctrl</kbd>+<kbd>F</kbd> to find these.

| To change | Search for | Notes |
|---|---|---|
| The portrait photo | `<img src="data:image/jpeg;base64,` | Replace the whole `src="..."` value. Convert at [base64-image.de](https://www.base64-image.de), or use `src="photo.jpg"` and put `photo.jpg` beside `index.html`. **Crop to 3:4 portrait first** and keep it around 560×747 — the frame is only 220px wide, so anything larger just makes the page heavier. Faces should sit in the upper-middle third; the frame is arched, so the top corners are cut away. |
| WhatsApp RSVP number | `wa.me/919440972344` | Keep the `91` country code, no `+` or spaces |
| Ceremony list | `const EVENTS` | Four entries: `["Title", "Date · Time", "Description"]`. Leave the middle string empty to hide the time. |
| The bride's parents | `class="hosts"` | Two inline `.host` spans joined by a `.host-amp` ampersand. Deliberately set at body size in plain ink so the names blend into the sentence the `.lead` paragraph finishes — raise `font-size` or `font-weight` on `.host` if you want them to stand out more. |
| Venue / map pin | `Dhanavarsha` | Appears in the panel, the directions card and the Maps link |
| Muhurtham block | `muhurtham-panel` | Date, time, panchangam, venue, vindu line |
| Vindu (dinner) time | `7:00 PM` | ⚠️ Written in **two** places — the muhurtham panel and the `EVENTS` list. Change both, or the card contradicts itself. |
| Names & degrees | `class="couple reveal"` | Also `cover-names` for the opening screen |
| Page title / browser tab | `<title>` | |

---

## Colours

Near the top, in the `:root` block — change these and every element updates:

```css
--white:#FFFDFD;      /* panels and cards */
--ivory:#FBF5F5;      /* page base — pastel warm white */
--champagne:#F5EAEC;  /* soft blush panel tint */
--gold:#C9A96A;       /* all ornament linework */
--gold-text:#7A5E24;  /* gold used for text */
--rosegold:#965769;   /* "weds", Subham Bhavatu, ceremony times */
--powder:#47617B;     /* panchangam, directions */
--kumkum:#9B4A55;     /* rose-maroon accents — lamps, bindus, panel edge */

--tint-blush:#F8E6E9; /* pastel washes — ceremony cards, panels, map card */
--tint-sky:#E4EEF6;
--tint-sage:#E6EFE6;
--tint-lilac:#EFE8F4;
--tint-butter:#FCF2DE;
```

The page ground is four pools of pastel light — blush top-left, sky top-right,
sage bottom-left, lilac bottom-right — layered under `body { background }`.

The five `--tint-*` values wash the ceremony cards via
`.event:nth-child(1..4)`, each fading out to the right so text always sits on
near-white.

⚠️ The ornament SVGs carry `#C9A96A` and `#9B4A55` as literal `stroke`
attributes, not tokens. If you change `--gold` or `--kumkum`, find-and-replace
those hex values too, or the gopuram, toran, kalasham and deepams will keep the
old colour.

Every text colour clears WCAG AA (4.5:1) against every panel it sits on. If you
darken a background or lighten a text colour, re-check with
[webaim.org/resources/contrastchecker](https://webaim.org/resources/contrastchecker/).

---

## Fonts

Three faces, all from the Google Fonts `<link>` in `<head>`:

- **Kalam** — *Prasanthi* and *Kiran*. A casual brush-pen face from Indian Type
  Foundry: upright, unjoined, warm and informal.
- **Cormorant Garamond** — the word *weds*, plus dates, venue, ceremony titles
  and all body text. Seven cuts loaded (300–700 plus italics), so the hierarchy
  comes from weight, size and letter-spacing rather than from stacking up faces.
- **Jost** — the wide-tracked small-caps labels and buttons.

To try a different face for the names, change `font-family` on
`.cover-names span` **and** `.couple .name` (keep the two in sync) and add the
family to the `<link>`.

- More **casual**: **Caveat**, **Dancing Script**, **Handlee**, **Comfortaa**
- More **formal script**: **Great Vibes**, **Pinyon Script**, **Parisienne**,
  **Alex Brush**, **Allura**

⚠️ **Letter-spacing depends on the face.** Kalam is unjoined, so the names carry
a safe `1px`. A *joined* script like Great Vibes must be set to
`letter-spacing:0` or the joins tear open. The entrance animation is `scriptIn`
(rise and fade) rather than the old `trackIn`, which animated letter-spacing and
would break a joined script mid-reveal.

Sizes vary a lot between faces. Formal scripts have small x-heights and need
20–25% more point size; casual faces like Kalam have large x-heights and need
much less. Expect to retune four `font-size` values — two base rules, two in the
media queries — whenever you swap.

---

## The blink

The names and dates twinkle: two quick flashes, then a long calm, on a shared
3.4-second clock so everything blinks together rather than flickering
independently.

| Search for | What it controls |
|---|---|
| `nameBlink` | the halo around **Prasanthi** and **Kiran** |
| `dateBlink` | the halo on both **Thursday, 27th August 2026** lines |
| `auraBlink` | the pool of light spreading behind the names onto the paper |

**Speed:** change `3.4s` in all six `animation:` lines together — they must
match or the twinkle falls out of sync.
**Intensity:** raise or lower the alpha on the bright keyframes (`7%`, `21%`).
**Calmer:** delete the `14%` and `21%` keyframes for a single flash per cycle.

Two things worth leaving alone:

- **The letters never go dark** — only the halo flashes. A true on/off blink
  would make the couple's names unreadable half the time. If you truly want
  that, add `opacity:0` to the `14%` keyframe, but check it on a phone first.
- **The flash rate is deliberate.** Two flashes per 3.4s is about 0.6 Hz, well
  under the 3 Hz threshold that can affect photosensitive visitors. Don't take
  the duration below about `1.5s`.

The steady, non-blinking version sits on the `filter:` and `text-shadow:`
declarations on `.cover-names span`, `.couple .name`, `.cover-date` and
`.detail-block .big` — that is what visitors with *Reduce Motion* switched on
see, so keep it lit if you edit.

---

## The glowing buttons

**RSVP** and **Directions** are the only two things a guest is asked to do, so
both carry a halo that breathes on the same 3.4-second clock as the names — the
whole page pulses as one rather than in pieces.

| Search for | What it controls |
|---|---|
| `orbGlow` | the halo breathing in and out |
| `orbPing` | the soft ring that travels outward once per cycle |
| `--glow` | each button's colour, as an `r,g,b` triplet |

Each button sets its own `--glow` next to its `color` — rose `150,87,105` for
RSVP, powder `71,97,123` for Directions — and the halo is composed from that one
value at several alphas. **Change the colour in both places** or the ring and the
icon will disagree.

**Calmer:** lower the alphas in the `orbGlow` keyframes (`.20` and `.48`).
**Off entirely:** delete the `animation:` line on `.orb-btn` and the
`.orb-btn::after` rule. The buttons keep the resting halo and stay perfectly
usable.

Two things worth leaving alone:

- **The resting glow is declared on `.orb-btn` itself,** not only inside the
  keyframes. That is deliberate — it is what *Reduce Motion* visitors see, and
  without it their buttons would go flat.
- **The hover rule sets `animation:none`.** A running animation outranks every
  normal CSS rule, so without that line the hover state would silently do
  nothing on a laptop.

---

## The music

**Switched off.** The synthesised drone came out harsh on phone speakers, so it
is disabled and the speaker button is hidden with it.

Search `MUSIC_ENABLED` in the JavaScript:

```js
const MUSIC_ENABLED=false;   // ← true brings the music and its button back
```

That one word is the whole switch. Nothing else needs touching — the button
reappears, and the drone fades in with the reveal as before.

If you do turn it back on, listen on a **phone speaker**, not headphones. That
is where it was a problem.

---

## Temple ornament

Search these class names to find each SVG:

- `gopuram-crown` — the tiered temple tower over the portrait
- `toran-line` — the mango-leaf garland at the top of the invitation
- `kalasham-line` — the sacred pot: coconut with coir tuft, three eyes and husk
  fibre, cradled in the rim, mango leaves fanning behind it
- `deepam-row` — the pair of oil lamps above the muhurtham panel
- `--kolam` — the faint four-petal muggu lattice in the background

---

## The flowers

Search `BLOOM_KINDS` in the JavaScript. Six pastel blossoms — blush rose, cream
jasmine, butter marigold, powder sky, soft sage and lilac. Each entry is
`{p: petal count, c: petal colour, k: centre colour, e: edge colour, w: how
often it appears}`. Raise `w` to see more of one flower, delete a line to remove
it. `MAX_BLOOMS` caps how many can be on screen at once, and `gust` (in the
`pointerdown` handler) is how hard a tap blows them.

---

## Good to know

- **Accessibility:** honours *Reduce Motion* (animations stop, everything stays
  visible and legible), form inputs are 16px so iOS doesn't zoom on focus, all
  tap targets are at least 44px, and text contrast meets WCAG AA throughout.
- **Safe areas:** respects notches and home indicators via
  `env(safe-area-inset-*)`.
- **Privacy:** no analytics, no trackers, no cookies. RSVPs go straight from the
  guest's phone to WhatsApp — nothing is stored anywhere.
- **Offline-capable:** if you ever need it to work with no internet at all,
  delete the Google Fonts `<link>` — the design falls back to system serifs and
  everything else still works, since the image, styles and scripts are all
  inline.

---

*Borusu & Yalla Families · Bandhumitrula Abhinandanalatho*
