# Putting the invitation online — step by step

**One route only.** GitHub + GitHub Pages. It is free forever, has no expiry, no
trial, no card, and no monthly limit you can hit. Your files are version-
controlled, so nothing can be lost, and every future edit goes live with one
command.

**Time:** about 20 minutes the first time. Under a minute for every change after.

**Do this now, not the week of the wedding.** Set it up early, sit with the link
for a few days, then send it out.

Work through the steps in order. Don't skip ahead.

---

## Step 1 — Put the four files in one folder

Make a folder on your Desktop called `prasanthi-weds-kiran` and put these inside:

```
prasanthi-weds-kiran/
├── index.html      ← the website
├── README.md
├── DEPLOY.md       ← this file
└── deploy.sh
```

Nothing goes in a subfolder. All four sit directly in `prasanthi-weds-kiran`.

**Check:** double-click `index.html`. The invitation should open in your browser.
If it does, the file is fine and everything after this is just publishing.

---

## Step 2 — Install Git

Skip this if you already have it.

Go to **[git-scm.com/downloads](https://git-scm.com/downloads)**, download for
your system, and install with all the default options. Click Next through
everything.

**Check:** open Terminal (Mac) or Git Bash (Windows) and type:

```bash
git --version
```

You should see something like `git version 2.43.0`. If you get "command not
found", restart your computer and try again.

---

## Step 3 — Create a GitHub account

Go to **[github.com/signup](https://github.com/signup)**. Free. Use an email you
will still have access to next year.

Write down the username you choose — you'll need it in Step 8.

---

## Step 4 — Create the repository

A repository is just a folder that GitHub stores for you.

1. Go to **[github.com/new](https://github.com/new)**
2. **Repository name:** `prasanthi-weds-kiran`
3. **Public** — leave this selected. It must be public for free hosting.
4. **Do NOT tick** "Add a README file" — you already have one
5. Click **Create repository**

The next page shows a URL near the top like:

```
https://github.com/YOUR-USERNAME/prasanthi-weds-kiran.git
```

**Copy that URL.** You need it in Step 6. Leave this browser tab open.

---

## Step 5 — Open the folder in VS Code

1. Open VS Code
2. **File → Open Folder**
3. Choose your `prasanthi-weds-kiran` folder
4. Open the terminal: **Terminal → New Terminal**
   (or <kbd>Ctrl</kbd>+<kbd>`</kbd> / <kbd>Cmd</kbd>+<kbd>`</kbd>)

A panel opens at the bottom. That's where you type commands.

**Check:** type `ls` (Mac) or `dir` (Windows) and press Enter. You should see
your four files listed. If you don't, you opened the wrong folder — go back to
step 2 of this list.

---

## Step 6 — Push the files to GitHub

In that terminal, type this — but paste **your** URL from Step 4 in place of the
one shown:

```bash
bash deploy.sh https://github.com/YOUR-USERNAME/prasanthi-weds-kiran.git
```

Press Enter.

**What happens:** a browser window may pop up asking you to sign in to GitHub.
Sign in and allow it. That's normal — it's how your computer proves the
repository is yours.

*If instead the terminal asks you to type a password,* your account password
will not work. You need a token:

> 1. Go to
>    **[github.com/settings/tokens](https://github.com/settings/tokens)**
> 2. **Generate new token → Generate new token (classic)**
> 3. Note: `wedding site`. Expiration: **No expiration**
> 4. Tick the box marked **repo**
> 5. **Generate token**, then copy the long string it shows you
> 6. Paste that as the password in the terminal
>
> Copy the token somewhere safe now — GitHub will never show it again.
> On most systems your computer remembers it, so you only do this once.

**Check:** the terminal finishes with a box that says `✓ Pushed to GitHub` and
prints two links. Refresh your GitHub tab — your four files should be listed
there.

---

## Step 7 — Turn on GitHub Pages

The files are stored, but not yet a website. One switch turns them into one.

1. Go to your repository on GitHub
2. Click **Settings** (top of the page)
3. Click **Pages** in the left sidebar
4. Under **Source**, choose **Deploy from a branch**
5. Under **Branch**, choose **main**, leave the folder as **/ (root)**
6. Click **Save**

**Check:** wait one minute, then refresh that page. A green box appears at the
top with your live link.

---

## Step 8 — Open your link

Your invitation is now live at:

```
https://YOUR-USERNAME.github.io/prasanthi-weds-kiran/
```

Replace `YOUR-USERNAME` with the username from Step 3.

If you see a 404, wait two more minutes and refresh. First deployments can take
a moment.

---

## Step 9 — Test it on a real phone

**This step matters more than the rest.** The design is built for phones — most
of it does not exist on a laptop. Message the link to yourself and open it on
your phone.

- [ ] Tap **Tap to Open** — a golden circle expands from your fingertip
- [ ] Tap the screen a few times — pastel flowers gust across it
- [ ] Speaker icon, top right — the ambient music and temple bell
- [ ] Tap **RSVP**, fill it in, tap Send —
      **confirm WhatsApp opens to 9440972344 with the message ready**
- [ ] Tap **Directions → Open in Maps** — confirm it lands on Dhanavarsha
- [ ] Read every name, date and time against the printed card
- [ ] Confirm **Sri Borusu Chandrasekhara Rao** and
      **Srimati Borusu Surya Vathi** are spelled the way the family wants
- [ ] Paste the link into a WhatsApp chat with yourself and check the preview

Fix anything wrong before anyone else sees it. Step 10 shows how.

---

## Step 10 — Making changes later

Edit `index.html` in VS Code, save, then in the terminal:

```bash
bash deploy.sh
```

No URL needed this time. Your change is live in under a minute.

If you don't see it, hold <kbd>Shift</kbd> and click refresh — your browser is
showing you the old copy.

---

## Step 11 — QR code for the printed card

Once you're happy with the link:

1. Go to **[qrcode-monkey.com](https://www.qrcode-monkey.com)**
2. Paste your live URL
3. Download the **SVG** — it stays sharp at any print size

---

## If something goes wrong

| What you see | What to do |
|---|---|
| `deploy.sh: command not found` | Type `bash deploy.sh`, not `./deploy.sh` |
| `✗ No index.html in this folder` | VS Code has the wrong folder open. File → Open Folder, pick the one with the four files. |
| GitHub Pages shows 404 | Wait 3 minutes. Then check the file is named `index.html`, all lowercase, and sits at the top of the repository, not inside a folder. |
| `Updates were rejected` | Run `git pull --rebase origin main`, then `bash deploy.sh` again |
| Fonts look plain | The page loads fonts from the internet. Reload on a better connection. |
| Music doesn't start on its own | Correct — phones block that. It starts when you tap to open. |
| No flowers | They only appear after the invitation opens, and stay off if the phone has *Reduce Motion* switched on. |

---

## Why this route and not a faster one

Drag-and-drop hosts get you a link in thirty seconds, but the link is temporary
unless you claim it, and there's no copy of your file anywhere but your laptop.
This route takes twenty minutes once and then holds: free with no expiry, a
backup of every version you've ever pushed, and one command to update.

Guests will be opening this link for months. It's worth the twenty minutes.

---

*Editing the invitation itself — names, colours, the photo, the ceremony list —
is covered in `README.md`.*
