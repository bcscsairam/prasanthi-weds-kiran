# Your invitation is online

**This is the link you send to guests:**

```
https://prasanthi-weds-kiran.netlify.app/
```

Open it. That is exactly what everyone else sees.

> ⚠️ **Do not send the `app.netlify.com/projects/...` address.** That one is your
> private control panel. A guest who opens it gets a login screen, not an
> invitation. The only link that goes on the card, in WhatsApp, or into a QR code
> is the `prasanthi-weds-kiran.netlify.app` one above.

The hosting is free, has no expiry and no card attached. Every change you make
later goes live with one command.

---

## Do this first — test it on a real phone

**This matters more than anything else in this file.** The design is built for
phones; a good part of it does not exist on a laptop. Message the link to
yourself and open it on your phone.

- [ ] Tap **Tap to Open** — a golden circle expands from your fingertip
- [ ] Tap the screen a few times — pastel flowers gust across it
- [ ] **RSVP** and **Directions** glow gently — rose and powder blue
- [ ] *Shatamanam Bhavati* fades in a moment after the invitation opens
- [ ] Speaker icon, top right — tap it to mute, tap again to bring it back
- [ ] Leave it playing past **2:40** — it should slip back to the start, not
      fall silent
- [ ] Tap **RSVP**, fill it in, tap Send —
      **confirm WhatsApp opens to 9440972344 with the message ready**
- [ ] Tap **Directions → Open in Maps** — confirm it lands on Dhanavarsha
- [ ] Read every name, date and time against the printed card
- [ ] Confirm **Sri Borusu Chandrasekhara Rao** and
      **Srimati Borusu Surya Vathi** are spelled the way the family wants
- [ ] Paste the link into a WhatsApp chat with yourself and check the preview

Do this on an Android phone *and* an iPhone if you can borrow one. Fix anything
wrong before the link goes out — "Making a change" below shows how.

---

## How your setup works

Three pieces, already connected. None of this needs setting up again.

```
  your folder              GitHub                      Netlify
  index.html   ──push──▶   bcscsairam/        ──▶      prasanthi-weds-kiran
                           prasanthi-weds-kiran        .netlify.app
```

1. You edit `index.html` on your computer.
2. `bash deploy.sh` pushes it to GitHub.
3. Netlify is watching that repository. It sees the push and puts the new
   version online by itself.

You only ever do steps 1 and 2. Step 3 happens without you.

**GitHub is also your backup.** Every version you have ever pushed is kept
there. Nothing you do to the file on your laptop can lose the work.

> **GitHub Pages is deliberately switched off.** Netlify serves the site now.
> Turning Pages on as well would give you a second live copy at a different
> address that quietly falls out of date. Leave it off.

---

## Making a change

1. Open `index.html` in VS Code
2. Edit it, and save
3. Open the terminal (**Terminal → New Terminal**, or
   <kbd>Ctrl</kbd>+<kbd>`</kbd>) and run:

```bash
bash deploy.sh
```

That's all. No URL, no second step. Wait about a minute, then reload the live
link.

**If the page still looks old,** hold <kbd>Shift</kbd> and click refresh — your
browser is showing you the copy it saved earlier. On a phone, close the tab
completely and open the link again.

**To watch the update happen,** open your
[deploys page](https://app.netlify.com/projects/prasanthi-weds-kiran/deploys).
A new row appears at the top and turns green when the change is live.

*What to edit — names, colours, the photo, the ceremony list — is covered in
`README.md`.*

---

## Undoing a change

If you publish something and immediately wish you hadn't, you do not need to
edit anything to get back.

1. Open your [deploys page](https://app.netlify.com/projects/prasanthi-weds-kiran/deploys)
2. Click the deploy from before the mistake
3. Choose **Publish deploy**

The older version goes live again within seconds. Then fix the file properly on
your laptop and push as normal.

A failed deploy cannot take the site down either — if a push somehow doesn't
build, Netlify keeps serving the last version that worked.

---

## QR code for the printed card

Once you are happy with the link:

1. Go to **[qrcode-monkey.com](https://www.qrcode-monkey.com)**
2. Paste `https://prasanthi-weds-kiran.netlify.app/`
3. Download the **SVG** — it stays sharp at any print size

**Scan the printed proof with your own phone before the cards go to press.**

---

## If something goes wrong

| What you see | What to do |
|---|---|
| `deploy.sh: command not found` | Type `bash deploy.sh`, not `./deploy.sh` |
| `✗ No index.html in this folder` | VS Code has the wrong folder open. **File → Open Folder**, pick the one holding the four files. |
| Pushed, but the live page hasn't changed | Give it a full minute, then hard-refresh (<kbd>Shift</kbd> + reload). If it is still old, check the deploys page for a red **Failed** row. |
| `Updates were rejected` | Run `git pull --rebase origin main`, then `bash deploy.sh` again |
| The terminal asks for a password | Your GitHub account password will not work here. See the box below. |
| Fonts look plain | The page loads its fonts from the internet. Reload on a better connection. |
| No music, everything else fine | `shatamanam-bhavati.mp3` did not get copied across. It must sit beside `index.html` under exactly that name. |
| Music won't start on an iPhone | Check the physical **silent switch** on the side of the phone — it mutes web audio on iOS. |
| Music takes a few seconds to arrive | Normal on a slow connection. The song is 3.8 MB and streams while the page is already readable. |
| No flowers | They only appear after the invitation opens, and stay off if the phone has *Reduce Motion* switched on. |

**If it asks for a password,** you need a token instead:

> 1. Go to **[github.com/settings/tokens](https://github.com/settings/tokens)**
> 2. **Generate new token → Generate new token (classic)**
> 3. Note: `wedding site`. Expiration: **No expiration**
> 4. Tick the box marked **repo**
> 5. **Generate token**, then copy the long string it shows you
> 6. Paste that as the password in the terminal
>
> Copy the token somewhere safe now — GitHub will never show it again. Your
> computer normally remembers it, so you do this once.

---

## Will it stay up?

Yes. Netlify's free plan currently allows 100 GB of traffic a month. This page
is about 200 KB, so that allowance is somewhere near half a million opens. A
wedding guest list will not come close.

There is no trial, nothing expires, and no card is attached to the account.

---

## Optional — a shorter address

`prasanthi-weds-kiran.netlify.app` is perfectly good to send and to print. Two
things you *can* change if you want to:

- **Rename the site** — in Netlify, under **Site configuration → Site details**,
  changing the site name changes the `.netlify.app` address.
- **Use your own domain** — buy something like `prasanthiwedskiran.com` and add
  it under **Domain management**. It costs money each year and needs about an
  hour to set up.

⚠️ **Either change breaks the old link.** Anyone who already has it, and any QR
code already printed, stops working. Only do this *before* the invitations go
out — not after.

---

## Appendix — starting over from scratch

You should never need this. It is here in case the laptop dies and you are
setting the whole thing up again on a new machine.

1. Install Git from **[git-scm.com/downloads](https://git-scm.com/downloads)**
2. Clone your repository:
   ```bash
   git clone https://github.com/bcscsairam/prasanthi-weds-kiran.git
   ```
3. Open that folder in VS Code and carry on as normal — `bash deploy.sh` will
   work straight away, and Netlify is still watching the same repository.

The live site never goes down while you do this. It is served from Netlify, not
from your laptop.

---

*Borusu & Yalla Families · Bandhumitrula Abhinandanalatho*
