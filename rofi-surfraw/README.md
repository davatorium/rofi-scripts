# rofi-surfraw

#### a little frontend for surfraw, utilizing rofi

This script shows a list of all "elvis". The list can be filtered. Everything
typed after an elvis is considered a search term and a browser will open with
the appropriate search results.
If you don't know what surfraw is or what elvis means, have a look on the [surfraw homepage](https://gitlab.com/surfraw/Surfraw).

In addition to elvis it's possible to add your own.
For this `$HOME/.config/surfraw/bookmarks` is parsed, which looks
like this:

```
rb  https://www.rebuy.de/kaufen/suchen?q=%s
sp  http://www.sputnikmusic.com/search_results.php?genreid=0&search_in=Bands&search_text=%s
```

#### Options

`--no-list`   - do not show surfraw's inbuilt search engines
`--no-bookmarks` - do not show bookmarked search engines
