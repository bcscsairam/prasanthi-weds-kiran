# Collecting RSVPs in a Google Sheet

Every guest who taps **Send** on the RSVP form adds a row to a spreadsheet you
own — name, whether they're coming, how many, accommodation, and their blessing.
It happens silently in the background. WhatsApp still opens as it always did.

**Why this matters:** WhatsApp only tells you about guests who actually go
through with tapping send in WhatsApp. Plenty won't. The sheet catches
*everyone* who filled the form in.

**Time:** about ten minutes, once. Free, with no limit on responses.

Work through the steps in order.

---

## Step 1 — Make the spreadsheet

1. Go to **[sheets.new](https://sheets.new)** — this creates a blank sheet
2. Name it, top left: `Prasanthi weds Kiran — RSVPs`

Leave the tab at the bottom called `Sheet1`. The script makes its own tab.

Keep this browser tab open.

---

## Step 2 — Open the script editor

In that same spreadsheet:

**Extensions → Apps Script**

A new tab opens with a code editor. It has a few lines in it already:

```javascript
function myFunction() {
}
```

**Select all of that and delete it.** The editor must be completely empty.

---

## Step 3 — Paste this in

Copy everything in the box below and paste it into the empty editor.

```javascript
/**
 * Prasanthi weds Kiran — RSVP collector
 * Receives an RSVP from the invitation and appends it as a row.
 */

var SHEET_NAME = 'RSVPs';
var HEADERS = ['Received', 'Name', 'Attending', 'Guests',
               'Accommodation', 'Blessings'];

function doPost(e) {
  // one writer at a time, so two guests submitting together
  // can never land on the same row
  var lock = LockService.getScriptLock();
  lock.waitLock(30000);
  try {
    var sheet = getSheet_();
    var d = {};
    try {
      d = JSON.parse(e.postData.contents);
    } catch (parseErr) {
      d = (e && e.parameter) ? e.parameter : {};
    }
    sheet.appendRow([
      new Date(),
      d.name || '',
      d.attending || '',
      d.guests || '',
      d.accommodation || '',
      d.message || ''
    ]);
    return json_({ ok: true });
  } catch (err) {
    return json_({ ok: false, error: String(err) });
  } finally {
    lock.releaseLock();
  }
}

// visiting the URL in a browser should say something friendly,
// so you can check the deployment is alive
function doGet() {
  return json_({ ok: true, message: 'RSVP collector is running.' });
}

function getSheet_() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheetByName(SHEET_NAME);
  if (!sheet) {
    sheet = ss.insertSheet(SHEET_NAME);
  }
  if (sheet.getLastRow() === 0) {
    sheet.appendRow(HEADERS);
    sheet.getRange(1, 1, 1, HEADERS.length).setFontWeight('bold');
    sheet.setFrozenRows(1);
  }
  return sheet;
}

function json_(obj) {
  return ContentService
    .createTextOutput(JSON.stringify(obj))
    .setMimeType(ContentService.MimeType.JSON);
}
```

Click the **save** icon (💾), or <kbd>Ctrl</kbd>/<kbd>Cmd</kbd>+<kbd>S</kbd>.

---

## Step 4 — Publish it

1. Top right, click **Deploy → New deployment**
2. Click the gear icon next to *Select type*, choose **Web app**
3. Fill in:
   - **Description:** `RSVP collector`
   - **Execute as:** **Me**
   - **Who has access:** **Anyone**
4. Click **Deploy**

> ⚠️ **"Who has access" must be "Anyone", not "Anyone with Google account".**
> Guests are not signed in to Google on your invitation. Get this wrong and
> every RSVP is silently rejected.

**Google will ask you to authorise it.** This is normal — you are granting your
own script permission to write to your own sheet.

- Click **Authorize access**, pick your Google account
- You'll see **"Google hasn't verified this app"** — that's expected, because
  the app is yours and was written ten minutes ago
- Click **Advanced**, then **Go to Untitled project (unsafe)**
- Click **Allow**

You'll land on a screen showing a **Web app URL** ending in `/exec`:

```
https://script.google.com/macros/s/AKfycb...................../exec
```

**Copy that URL.** That is the whole point of these four steps.

---

## Step 5 — Check it works before wiring it up

Paste the URL into a new browser tab and press Enter. You should see:

```json
{"ok":true,"message":"RSVP collector is running."}
```

If you see that, the deployment is live. If you get an error page instead, go
back to Step 4 — "Who has access" is almost always the culprit.

---

## Step 6 — Give the URL to the invitation

Open `index.html` and find this line (<kbd>Ctrl</kbd>+<kbd>F</kbd> for
`RSVP_ENDPOINT`):

```javascript
const RSVP_ENDPOINT='';
```

Paste your URL between the quotes:

```javascript
const RSVP_ENDPOINT='https://script.google.com/macros/s/AKfycb....../exec';
```

Save, then in the terminal:

```bash
bash deploy.sh
```

---

## Step 7 — Send yourself a test RSVP

Open the live invitation **on your phone**, tap RSVP, fill it in with an
obvious test name, and tap Send.

- [ ] WhatsApp opens as before
- [ ] Within a few seconds, a new row appears in your spreadsheet
- [ ] The row has the right name, attendance, guest count and blessing

Delete the test row afterwards.

**If no row appears,** work through *If nothing arrives* below.

---

## Changing the script later

Editing the code is not enough on its own — Apps Script keeps serving the
version you deployed.

**Deploy → Manage deployments → ✏️ (edit) → Version: New version → Deploy**

This keeps the same URL. Choosing *New deployment* instead would give you a
different URL and the invitation would keep posting to the old one.

---

## If nothing arrives

| What's happening | What to check |
|---|---|
| No rows at all, ever | Is `RSVP_ENDPOINT` actually filled in, and did you run `bash deploy.sh` after? |
| The URL shows an error in a browser | **Who has access** is not set to **Anyone**. Redeploy (see above). |
| Worked once, then stopped | You edited the script and used *New deployment*, changing the URL. Either redeploy as a new *version*, or paste the new URL into `index.html`. |
| Rows arrive with empty fields | The script was pasted while the editor still had the old `myFunction()` in it. Clear the editor completely and paste again. |
| Rows are duplicated | The guest tapped Send twice. The form blocks repeats for a couple of seconds, but a determined double-tap can still get through. Delete the extra row. |

The invitation is deliberately built so that **a broken endpoint cannot break the
RSVP form.** If Google is down, or the URL is wrong, or you never set it up at
all, the guest sees no error — WhatsApp opens exactly as before. You simply
don't get the row.

---

## What guests are told

The form says *"Pressing Send opens WhatsApp with your RSVP ready to send."*
Their name, attendance, guest count, accommodation and blessing go to your
sheet. Nothing else is collected — no location, no device details, no tracking
of any kind, and the site still sets no cookies.

---

*Editing the invitation itself is covered in `README.md`. Publishing is in
`DEPLOY.md`.*
