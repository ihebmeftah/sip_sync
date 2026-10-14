# Sip Sync user guide

How to use Sip Sync: what each app offers, who it is for, and what you can do on every screen.

## Table of contents

- [Introduction](#introduction)
- [The three apps](#the-three-apps)
- [Languages and appearance](#languages-and-appearance)
- [Customer app](#customer-app)
  - [Create an account and sign in](#create-an-account-and-sign-in)
  - [Onboarding](#onboarding)
  - [Find a venue](#find-a-venue)
  - [The venue visit](#the-venue-visit)
  - [Menu and ordering](#menu-and-ordering)
  - [Scan a table](#scan-a-table)
  - [Your orders](#your-orders)
  - [Reservations](#reservations)
  - [Notifications](#notifications)
  - [Profile](#profile)
- [Management app](#management-app)
  - [Sign in as an owner or an employee](#sign-in-as-an-owner-or-an-employee)
  - [Buildings](#buildings)
  - [Configuration](#configuration)
  - [Dashboard](#dashboard)
  - [Employees](#employees)
  - [Access profiles](#access-profiles)
  - [Menu and inventory](#menu-and-inventory)
  - [Floor tables](#floor-tables)
  - [Table QR for staff](#table-qr-for-staff)
  - [Orders](#orders)
  - [Cash register](#cash-register)
  - [Reservations on the floor](#reservations-on-the-floor)
  - [Alerts](#alerts)
  - [Profile and password](#profile-and-password)
  - [Plans and upgrades](#plans-and-upgrades)
- [Backoffice](#backoffice)
  - [Sign in](#sign-in)
  - [Stats](#stats)
  - [Users](#users)
  - [Customers and owners](#customers-and-owners)
  - [Venues](#venues)
  - [Countries and maps](#countries-and-maps)
  - [Packs](#packs)
- [What each plan includes](#what-each-plan-includes)
- [A first walkthrough](#a-first-walkthrough)

## Introduction

Sip Sync is a platform for cafés, restaurants, lounges, and bars. One venue can take orders from guests and from the floor, keep a menu and stock, seat people at tables, take reservations, and close the day on a cash register. A platform admin watches the network of venues and the commercial plans they sit on.

Three apps share one backend:

- **Customer** — find a place, read the menu, scan the table, send an order, and ask for a reservation.
- **Management** — owners and staff run the venue: buildings, menu, stock, tables, orders, cash, reservations, and who on the team may do what.
- **Backoffice** — the platform admin lists venues, owners, customers, and plans.

A guest and the venue see the same order. When the kitchen moves a dish, the guest’s receipt updates. When a guest passes an order from the menu, it appears on the floor board. Stock drops from each dish’s recipe and comes back if that line is cancelled before it is paid.

English, Arabic, and French are available. Arabic lays the screen out right to left.

## The three apps

| App | Who | Live demo |
| --- | --- | --- |
| Customer | Guests | https://sipsync.serverpod.space/ |
| Management | Owners and staff | https://sipsync.serverpod.space/managment/ |
| Backoffice | Platform admin | https://sipsync.serverpod.space/backoffice/ |

Locally, after `serverpod start`, the same apps are on ports 8090, 8091, and 8092.

Accounts are separate. The same email can be an owner and a customer; those are two sign-ins. Employees do not use email. The owner creates them, and they sign in with a username. The platform admin is a third kind of account and cannot open the other two apps.

## Languages and appearance

Each app can switch language among English, Arabic, and French. In management, the language control sits at the bottom of the sidebar (or the drawer on a phone), next to the dark-mode switch. Management uses the same olive palette in light and dark. The customer app and backoffice stay on their light schemes.

## Customer app

The customer app is for guests. After sign-in you pick a place, browse venues, open one, and order or reserve from there.

### Create an account and sign in

You can register yourself. The form asks for email, password, phone, and your name. The phone starts on Tunisia (`+216`); pick another country if you need a different dial code, then type the national number. The app checks the fields before it sends them.

Sign in with that email and password. A disabled account cannot sign in.

Email is the sign-in address and stays fixed. Name, phone, and password can be changed later from **Profile** inside a venue visit.

### Onboarding

The first time you open the app while signed out, a short introduction plays once. **Skip** and **Get started** both finish it and open sign-in. If you already have a session, onboarding is skipped.

### Find a venue

Home asks where you are.

1. Type an address. Suggestions appear after a short pause.
2. Or tap the location icon at the end of the field to use the device’s coordinates.

The label you chose stays in the place bar. Venues sort nearest first. The default filter is **15 km**; you can switch it to show every venue. The first page is 20 cards. Scroll to load the next page.

Each card shows the venue type, name, address, hours, distance in kilometres, and an approximate walk time.

On a phone the list and an OpenStreetMap trade places. From a wide window they sit side by side. Your place and each venue are marked. Tap a marker to see that venue in a card along the bottom. Tap a list card, or that map card, to open the venue.

### The venue visit

Opening a venue starts a visit. A bar along the bottom has **Overview**, **Menu**, a raised **Scan** control, **Orders**, and **Profile**. A bell at the top shows how many alerts are unread.

**Overview** shows the public card (name, type, address, hours, phone) and a green band of free tables, listed by number and seats. **Reserve now** sits under that band. Up to five categories and five dishes follow, ranked by what people actually order. A venue with no orders yet shows the first five in catalog order. **See all** on a row opens the menu.

### Menu and ordering

The menu has a category rail. Dishes load 20 at a time; scrolling loads more, and tapping a category loads forward until that category is on screen. A dish with a recipe lists ingredient names, such as `Mint · Lemon`.

**+** and **−** build a selection. A bar at the bottom shows the count and a preview total.

**Pass order** opens the review: dishes, prices, and the table you scanned. If this venue has no table yet, the review asks you to scan a QR and then returns here. **Pass order** again sends the cart. The receipt shows the ticket number, the table, and the prices the venue charged.

While the order is still open you can add more dishes. **Add to order** appends them to the same ticket. The venue can turn that off; the button stays disabled when it does.

A dish the kitchen cannot cover is not addable while the venue refuses out-of-stock orders. If the venue allows those orders, stock stops at zero and the dish can still be sent.

If the venue turns customer ordering off, **+** and **Pass order** stay on screen and are disabled. If the venue’s plan does not include customer ordering, the page explains that the plan does not include it.

While you have an order in progress that is not paid:

- The venue list and the map stay closed.
- Back stays on this venue.
- **Scan** is unavailable until the order is paid or cancelled.
- A short note on the visit shows the total. **Details** opens the receipt, with each dish and its status.

After the order is paid or cancelled, the scanned table is cleared. The next order starts with a new scan, and the list and map open again.

### Scan a table

**Scan table** sits at the bottom of the venue list. On a visit, **Scan** in the bar opens the camera.

Point it at the sticker on the table. A valid sticker (`sipsync:table:v1:…`) is checked with the venue. A match opens that venue and marks the table as your seat, including when the table is already occupied. Scanning again changes the seat and shows a short confirmation. An inactive, unknown, or mismatched code stays on the camera with an error.

That seat lasts for the app session and is the table used when you pass an order.

### Your orders

Two places list past orders:

- The receipt icon on home.
- **Orders** on a venue visit. **This venue** keeps only orders for the place you have open.

History defaults to the past month, newest first, 20 at a time. **Today**, **Last week**, and **Last month** are the other windows. A cancelled ticket or line shows the reason the venue chose.

You cannot move a dish through the kitchen. Staff do that. The receipt updates when they pick, prepare, serve, pay, or cancel a line.

### Reservations

On a venue overview, **Reserve now** opens the reservation screen. It lists this venue’s upcoming reservations, newest first.

**Request** opens a dialog for the date and the start time. Confirm sends the request for your own account. The booking lasts two hours from that start. You do not pick a table, and you do not confirm the request. The row starts as requested, with nothing paid.

Staff accept or cancel it. You can cancel your own future request or a confirmed reservation that has not started. You are notified when it is accepted or cancelled, including when you cancel it yourself.

If the venue turns reservations off, **Reserve now** stays visible and is disabled. If the plan does not include reservations, the page says so.

### Notifications

The bell’s badge is your unread count. A new alert raises a toast for about ten seconds. You can mark that one read, mark all as read, or open the full list.

The list can stay on the current venue or switch to every venue, and it can be limited to this month or to unread rows. A tap marks the row read. An order alert opens that order. A reservation alert opens that venue’s reservation screen.

You are alerted when a line or an order you placed changes status, including a cancellation, and when a reservation is accepted or cancelled.

### Profile

**Profile** is the last item in the visit bar. You can change your name and phone, and you can change your password (current, new, confirm). Changing the password signs out your other sessions. Email stays the address you sign in with.

## Management app

Management is for the owner of a venue and for the people who work there. The owner sees every venue they created and picks one. An employee belongs to one venue and lands on it.

On a wide screen the sidebar lists the sections. On a phone the owner’s bottom bar is **Dashboard**, **Tables**, and **Orders**; everything else is in the drawer. An employee’s bottom bar is **Tables**, **Scan**, and **Orders**. **Dashboard** is added when their access profile may consult every order.

The account tile at the bottom of the sidebar opens **Profile**. A bell in the app bar opens this venue’s alerts. Its badge counts unread alerts for the venue that is open.

### Sign in as an owner or an employee

Owners register themselves with email, password, phone, and name, then sign in with email. **Forgot password?** is for owners. Ask for a reset, enter the 6-digit code, and set a new password. The code lasts 15 minutes. Until email delivery exists, a local demo shows the code on the reset screen. Employees do not reset a password here; the screen tells them to ask their manager.

Employees sign in with the username the venue assigned and the password set at creation. A disabled employee cannot sign in. After login they open straight into their venue.

### Buildings

After an owner signs in they see their venues, with no sidebar yet. The list is 20 venues per page. **Add** creates a venue: name, type (café, restaurant, lounge, bar, and the other types the form offers), address, map coordinates, opening and closing hours, currency, phone, and optional WhatsApp, Instagram, Facebook, and other links. The new venue starts on the free plan. Order rules, reservations, and stock switches are set later under **Configuration**, not on this form.

Open a row to enter that venue. The banner under the shell names the current plan.

Employees never see this list. They have one building.

### Configuration

**Configuration** sits directly under **Buildings** in the sidebar. Only the owner can open it. It is where the venue’s operating switches live:

| Switch | What it does |
| --- | --- |
| Several orders on one table | When off, a table with an open ticket cannot take a second order. When on, staff may open another. |
| Add dishes to an open order | When off, nobody can append lines to a ticket that is already open. |
| Strict item workflow | When on, each dish moves through the kitchen steps the venue leaves enabled (picked, ready, served, paid). When off, a line goes from in progress straight to paid, or it is cancelled. |
| Customer ordering | When off, guests cannot place or add to orders. The buttons stay visible and disabled. |
| Reservations | When off, nobody can create a reservation. Existing ones stay on the list. |
| Out-of-stock orders | When on, a dish can be ordered even if a recipe ingredient cannot cover it; stock stops at zero. When off, that order is refused. |
| Cash register | When on, and the plan includes it, creating an order, adding dishes, and recording a payment all require an open register. |

A switch the plan does not include stays locked, with an **Upgrade** badge. You can still turn off a switch that is already on.

### Dashboard

**Dashboard** is the venue’s today view. Owners always see it. An employee sees it only when their access profile includes consult all orders.

The welcome band says the counts are for the current local day. If a cash register is required and a shift is open, the band names that register and the order counts follow the shift. If the register is required and nothing is open, order counts stay at zero.

You can see:

- Tickets created today, split into in progress, paid, and cancelled, plus how many of those came from the customer app.
- Dishes by status: in progress, picked, ready, served, paid, cancelled.
- Reservation requests still waiting, any day.
- Confirmed reservations whose start falls today.
- Ingredients whose stock is zero.

Pull to refresh. The reservation card opens **Reservations**. The out-of-stock card opens **Ingredients** with the out-of-stock filter already on. Revenue and staff performance are not on this screen.

### Employees

**Employees** is for the owner. The list is 20 people per page.

Create a person with a password, phone, and name, and pick an access profile. You do not type a username. The server assigns one, and the detail screen shows it. Share that username and the password with the person; they use them on the management sign-in screen.

On the detail screen you can change name, phone, and access profile, and you can enable or disable the account. A disabled person cannot sign in. You cannot delete the requirement that they belong to this venue.

An employee cannot open this list. They manage only their own profile.

### Access profiles

**Access** sits with Employees. A new venue starts with three profiles:

| Profile | Can |
| --- | --- |
| Waiter | Create orders, take payment, cancel, serve |
| Gerant | Everything the waiter can, plus kitchen steps, every order, the cash register, and reservations |
| Barista | Create orders and the kitchen steps (picked and ready) |

You can change those toggles or add a profile of your own. Names are unique in the venue. A profile that is still assigned to someone cannot be deleted.

| Flag | Allows |
| --- | --- |
| Create orders | Open a ticket and add dishes |
| Take payment | Mark a line paid |
| Cancel | Cancel a line or a ticket that is not yet served or paid |
| Preparation | The only people who can mark picked or ready. They see the kitchen queue, including dishes they did not open |
| Serving | Mark a line served, including one opened by a guest or someone else |
| Consult all orders | See every ticket, open the dashboard, and record served or paid on any line. Without it, the person sees tickets they took part in |
| Cash register | Open and close the register and read its history |
| Reservations | Create, confirm, cancel, and assign tables |

An employee with no profile cannot run the floor. The server checks the profile on every action. Hiding a button in the app is only a convenience.

### Menu and inventory

**Products** in the sidebar groups the catalog.

**Categories** are the groups on the menu (coffee, food, and so on). The owner creates and edits them. The list is 20 per page.

**Articles** are the dishes you sell: a category and a price. A recipe is optional. From an article, open **Composition** and add ingredient lines with a quantity in that ingredient’s unit. The same ingredient cannot appear twice on one dish. Names of categories, articles, and ingredients are unique in the venue.

**Ingredients** are stock rows: a starting level, what is left, a low-stock threshold, and a unit. A bar shows how full the row is. A low-stock badge appears when the level is at or under the threshold. **Out of stock** limits the list to rows at zero. The Products and Ingredients entries in the shell show that count.

**Restock** adds incoming quantity. The owner and an employee can both restock. Only the owner can create or delete ingredients, or change the menu. An ingredient that is still on a recipe cannot be deleted.

When an order is created, each dish subtracts its recipe from stock. Cancelling a line or a ticket puts that stock back, unless the line was already paid. If a recipe ingredient would go below zero, the order is refused, unless the venue allows out-of-stock orders.

The free plan caps how many categories, articles, and ingredients you can add. The seeded demo venues already sit above those caps so the customer map has a full menu; further creates on the free plan are refused until the plan changes.

### Floor tables

**Tables** is the floor. Each table is drawn from its seat count: round up to four seats, oblong above that.

Filter the floor with **All**, **Available**, **Occupied**, **Reserved**, or **Inactive**. A table is occupied while it has an order in progress. From 30 minutes before a confirmed reservation that already has this table, the tile names the guest. At the start time it stays reserved and orders are still allowed.

The owner taps **Add table** and enters how many tables to create, how many seats each has (1–50), and whether they are active. Numbers continue after the highest number already on the floor.

Tap a tile (when you are not picking a table for a new order) to edit seats and active state, open the current order, or start one. The table number itself stays fixed. Employees can list and use tables; they cannot create or edit them.

### Table QR for staff

The owner exports a printable PDF from **Tables**: **Export QR PDF**. One sticker per table, with the code, the table number, and the venue name. If the plan leaves table QR off, export stays blocked.

An employee taps **Scan**, points the camera at a sticker for this venue, and:

- An available table starts a new order.
- An occupied table, when the venue allows several orders, also starts a new order.
- An occupied table, when only one order is allowed and adding dishes is on, opens the article picker for the ticket already on that table.
- An occupied table, when adding dishes is off, tells you so and closes the scanner.
- An inactive, unknown, or wrong-venue code closes the scanner with an error.

Guests use the same sticker in the customer app.

### Orders

Orders are the floor’s main job. A ticket is in progress, paid, or cancelled. Each dish on it moves on its own: in progress, picked, ready, served, paid, or cancelled.

**Start an order**

- Owner, on a phone: the **New order** button. The floor switches to pick mode. Tap a table. Tap the button again to leave pick mode.
- Employee: no new-order button. Open **Tables** and tap a table, or scan its QR.
- Inactive tables cannot be used. If the venue allows only one open order per table, an occupied table cannot take another.

Then pick dishes. Category chips and a name search narrow the list. **+** and **−** add or remove units. Each unit becomes its own line. Confirm the order. Stock is deducted, the ticket gets the next number for this venue, and you land on the ticket.

**On the ticket**

Advance or cancel one line. The next status is the venue’s next enabled step. With strict workflow off, that next step is paid. With it on, the line follows the enabled steps in order. Only someone with preparation access can mark picked or ready. Serving access marks served. Payment access marks paid.

**Add articles** appends more units when the venue allows it. The info control on a line shows who added it, who prepared it, who served it, and who took payment.

Cancel the whole ticket only while it is still in progress and no line is already served or paid. The dialog asks for a reason: ingredient out of stock, closing time is coming, a breakdown at work, or cancelled at the customer’s request. The same reasons are used for a single line. Cancelling restores stock for lines that were not paid. The guest sees the reason on their receipt.

**The board**

**Orders** opens on a board of today’s tickets. With strict workflow on, columns follow the enabled steps and paid lines leave the board. With it off, the columns are in progress and paid. Swipe a line toward the next status, or drag a table’s card onto the next column to move every line in that group. A ticket that was just opened is marked **New order**. A line added to a ticket that was already open is marked **Added**.

The board updates when a guest passes an order and when someone else on the floor moves a line. You do not need to refresh.

**The list**

A control in the title switches from the board to a paged list and back. The list opens on today. **Last 3 days**, **Last week**, and **Pick a day** choose another window, at most eight days. An employee who cannot consult every order still only sees tickets they took part in.

If the cash register is on, the board and the list follow the open shift instead of the calendar day. Day chips on the list can still pick another day. Tickets that were already open before the shift stay on the live board so they are not hidden.

### Cash register

**Cash register** is for the owner and for an employee whose profile includes it. The plan must include it, and **Configuration** must have the switch on. On the free plan the switch stays locked.

While the switch is on and no shift is open, nobody can create an order, add dishes, or record a payment — not staff, and not a guest. The order board asks you to open the register. Dashboard order counts are zero. Reservations and stock alerts stay on the calendar day.

Open the register from the dialog. Opening cash is optional. A venue has at most one shift in progress. The screen counts the time since it started. Every new ticket, from staff or from a guest, is stamped with that shift.

Close is refused while the shift still has an order in progress. Pay or cancel those tickets first. Closing cash is required when you entered an opening count, and optional when you left opening cash blank. Expected closing cash is the opening count plus every paid line on the shift. A matching drawer is correct, a larger count is tips, and a smaller count is short.

History is a grid of closed shifts. A date picker limits it to shifts that started on one day. Only the owner sees opening cash, closing cash, the paid total, and the drawer check, and only the owner can correct those amounts after they were saved. An employee with register access can open, close, and read history, and can count the drawer, but those amounts stay hidden from them.

### Reservations on the floor

**Reservations** shows how many customer requests are still waiting, on the sidebar item and on the phone’s menu button.

The list is the day you have open, newest first. A guest’s request arrives as requested. Confirm it or cancel it. Confirmation does not choose a table. After it is confirmed, assign one or more active tables. Overlap is checked against other confirmed or arrived reservations on those tables. Assigning again replaces the previous tables.

You can also create a reservation yourself. It is stored as confirmed immediately. The guest is an existing customer (search by name, phone, or email; type at least two characters) or a name and phone you type. It still needs a table. The amount paid can differ from the venue’s reservation fee. The booking lasts two hours unless you set an end.

From 30 minutes before the start, a confirmed reservation that has a table marks that table reserved and names the guest. Ordering still works. If the end passes while the reservation is still only confirmed, it becomes a no-show and the tables unlock.

The owner can always do this when the plan includes reservations. An employee needs the reservations flag. Gerant has it. Waiter and Barista do not, until you turn it on.

### Alerts

The bell is this venue only. An owner with several venues sees alerts for the venue they have open. An employee sees the venue they work in.

You are alerted when a guest requests a reservation, and when a reservation is accepted or cancelled, unless you made that change yourself. Reservation alerts reach employees only when their profile includes reservations.

The list can be limited to this month or to unread rows. **Mark all as read** covers the rows in that scope. A tap marks one row read and opens the order or the reservation list.

### Profile and password

**Profile** shows the signed-in person. An employee also sees the access profile assigned to them and which actions it allows. Both owner and employee can change name, phone, and password. The current password is required. Other sessions for that account are signed out.

### Plans and upgrades

A new venue starts on the free plan. The banner names the plan and says a change goes through the support team. **Upgrade** opens the public catalog: price, limits, and what each plan includes. There is no self-serve purchase. A platform admin assigns a paid plan from backoffice.

An action the plan turns off — or a create that would pass a cap — is disabled and carries an **Upgrade** badge. Tapping the badge opens the catalog instead of running the action.

## Backoffice

Backoffice is the platform console. Owners, employees, and guests cannot sign in here.

### Sign in

Sign in with the super-admin email and password. The seeded admin is `serverpod@gmail.com` / `serverpod`. That default account cannot be deleted or disabled. A disabled admin cannot sign in, and disabling someone revokes their sessions. You cannot disable your own account.

After sign-in you land on **Stats**. The sidebar is Stats, Users, Customers, Buildings, Countries / Maps, and Packs.

### Stats

Stats shows how many owners, customers, venues, employees, and orders exist, how many customer orders were not cancelled, and the monthly plan total. The monthly total is the sum of each venue’s current plan price, in Tunisian dinars. A private plan still counts.

**Public packs** lists every public plan, including a disabled one, with how many venues are on it and how many distinct owners those venues belong to. Private plans stay off this list.

### Users

**Users** lists backoffice accounts: name, email, phone, and whether they are enabled. The list is 20 per page, oldest first.

Create opens a dialog. Edit updates name, email, phone, an optional new password, and the enabled switch.

### Customers and owners

**Customers** has two tabs, **Owners** and **Customers**. Each card shows name, email, phone, and when the account was created. Details opens the same fields. Passwords are never shown. Each tab loads 20 people at a time, newest first.

### Venues

**Buildings** lists every venue, 20 per page by name. Search matches the venue name, the address, or the owner’s first or last name. A plan menu keeps one plan. The type and the plan sit on the card.

Open a card for four tabs:

- **Details** — contact and location.
- **Pack** — the current plan, whether a paid plan is daily, monthly, or yearly, the date it returns to free, and the history of plans this venue has been on. Assigning a plan, including a private one, is available only while the venue is on the free plan. A venue already on a paid plan cannot be moved until that term ends.
- **Gain** — the monthly price plus the customer-app fee on customer orders.
- **Stats** — category, article, table, and order counts.

You cannot create or edit a venue from here.

### Countries and maps

**Countries / Maps** lists how many venues sit in each country and places that count on an OpenStreetMap. Country is taken from the venue phone (a Tunisian number is Tunisia, and so on).

### Packs

**Packs** is the plan catalog, 20 per page: name, code, monthly price, public or private, and enabled.

Create and edit the price, the customer-app fee, whether the plan is public, whether it is enabled, the sort order, and every limit and switch. Each field has a short explanation in the form.

**Public** plans are the ones the management app may list. **Private** plans stay off that list. A disabled plan is hidden from owners. Venues already on it stay there.

`free` is a system plan at 0 TND. It cannot be deleted. Any other plan can be deleted only when no venue is still on it.

Assigning a plan other than free requires a term: **daily**, **monthly**, or **yearly**. The console previews the end date and you can move it within the rules for that term. The free plan has no end date. When the end date is reached, the venue returns to free and the previous assignment stays in history.

Prices are in Tunisian dinars, separate from a venue’s own currency. The customer-app fee is a percentage of orders placed in the customer app. Tickets entered by staff are not charged.

## What each plan includes

A fresh server inserts five plans. Later edits are left alone on restart.

| Plan | Who sees it | Month | Employees | Tables | Ordering, multi-order, strict workflow, custom profiles | Cash register | Reservations |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Free | Private | 0 TND | 2 | 8 | Off | Off | Off |
| Counter | Public | 39 TND | 3 | 12 | Off | On | 8 per day |
| Floor | Public | 89 TND | 12 | 40 | On | On | 30 per day |
| House | Public | 149 TND | 30 | 100 | On | On | No daily cap |
| Group | Private | 249 TND | 80 | 250 | On | On | No daily cap |

Free also caps categories (4), articles (20), and ingredients (15). Counter caps them at 6, 40, and 40. Floor caps them at 20, 200, and 200. House and Group leave those three uncapped. Discovery, table QR, inventory, and adding dishes to an open order are on for every plan. An empty limit means no cap.

Yearly prices are ten times the monthly price. Floor charges a 1.5% fee on customer-app orders, House 1.0%, Group 0.5%. Free and Counter charge no fee.

## A first walkthrough

1. Open management and sign in as `owner.tn.05@sipsync.dev` / `password1`. That account is Le Grand Café du Théâtre in Tunis, with a menu, stock, and tables.
2. Open the venue. On **Tables**, export the QR PDF if you want a sticker, or note a table number.
3. Open the customer app, register, search Tunis, and open the same café.
4. Scan the table, add dishes, and pass the order.
5. Back in management, open **Orders**. The ticket is on the board. Move a line forward, or pay it.
6. The customer receipt updates without a refresh.

More seeded owners use the same password, `password1`: `owner.tn.01` through `owner.tn.14`, `owner.se.01` through `owner.se.06`, and `owner.de.01` through `owner.de.10`, all at `@sipsync.dev`. Their venues are in Sousse, Tunis, Hammamet, Stockholm, Marburg, Frankfurt, and Gießen. Customers are not seeded; register on the customer app.

Backoffice uses `serverpod@gmail.com` / `serverpod`.
