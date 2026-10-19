# Chiefs raffle promotion

The homepage features the raffle immediately below its hero. The KCPC page
features it after event details, connecting the November 21 conference with
the November 22, 2026 Chiefs game. Conference admission and raffle entries
are separate purchases.

`src/components/ChiefsRaffle.astro` holds the shared copy. The artwork comes
from the public RallyUp campaign. Entry purchases, personal referral links,
and full rules are at https://go.rallyup.com/6bb49b.

Remove the promotion when entries close on November 19, 2026. Remove the
component from both pages and the homepage hero link to `#chiefs-raffle`.
The static promotion does not automatically expire.
