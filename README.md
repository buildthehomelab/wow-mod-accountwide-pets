# Account-wide Pets

An [AzerothCore](https://www.azerothcore.org/) (WotLK 3.3.5a) module that shares companion
(non-combat) pets between the characters on an account. Learn a pet on one character, and your
other characters know it the next time they log in.

It only shares companion pets. It's the pet part of
[warblups/mod-accountwide](https://github.com/warblups/mod-accountwide), split out so you can
have it without that module's achievement, reputation, currency and PvP sharing. Those clash
with [mod-individual-progression](https://github.com/Grimfeather/mod-individual-progression):
a shared raid-boss achievement moves an alt's progression up to your main's. Mounts are in a
separate module, [mod-accountwide-mounts](https://github.com/buildthehomelab/wow-mod-accountwide-mounts).

## What gets shared

- Every pet on the client's Pets tab.
- Not faction-only pets on the wrong faction, as long as
  `AccountWidePets.RespectItemRestrictions` is on (the default). A pet only goes to characters
  that could use the item it's learned from.
- Not hunter pets or warlock demons. Those aren't companions.

Pets are never taken away. A character that already knows a pet keeps it whatever the settings
say.

Bots from mod-playerbots are skipped both ways: they don't add pets to their account and don't
get taught any.

## Install

Clone it into your AzerothCore `modules` folder **as `mod-accountwide-pets`**, without the repo's
`wow-` prefix. AzerothCore finds the module's entry point from the folder name.

```bash
cd <azerothcore>/modules
git clone https://github.com/buildthehomelab/wow-mod-accountwide-pets.git mod-accountwide-pets
```

Rebuild the worldserver, then copy `conf/mod_accountwide_pets.conf.dist` to your config folder as
`mod_accountwide_pets.conf`. The table is created in the characters database on the next start,
as long as `Updates.EnableDatabases` still includes the characters database (it does by default).

## Coming from mod-accountwide

This module uses mod-accountwide's `accountwide_pets` table, so every pet it already recorded is
kept. Either remove mod-accountwide, or keep it for the other features and set
`AccountWide.Pets = 0` so the two don't both do the work.

mod-accountwide picked out pets by spell category, which doesn't match what the client counts as
a companion, so it may have recorded few or none. Each character adds its own pets the next time
it logs in, so the list fills up as you play your characters.

## Settings

| Setting | Default | What it does |
|---------|---------|--------------|
| `AccountWidePets.Enable` | `1` | Master switch. |
| `AccountWidePets.RespectItemRestrictions` | `1` | Only teach a pet to characters that could use the item it's learned from. `0` shares every pet with every character. |

## How it works

- **Login:** the character's own pets are added to the account first. Then it's taught every
  account pet it doesn't know yet and is allowed to have.
- **Learning a pet:** it's added to the account right away, so a character that logs in
  meanwhile gets it too.
- **Logout:** saves once more.
- **Deleting the account's last character:** the account's pet list is cleared.

## License

GNU AGPL v3, the same as mod-accountwide, which this is based on. See `LICENSE`.
