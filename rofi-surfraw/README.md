# rofi-surfraw
#### a little frontend for surfraw, utilizing rofi

this script shows a list of all "elvis" and let's the user choose one.
It then asks for a search term and opens a browser with the results.

In addition to elvis it's possible to add your own.
For this `$HOME/.config/rofi-surfraw/searchengines` is parsed, which looks
like this:

```
Google Images - surfraw - duckduckgo !gi
Bing Images - surfraw - duckduckgo !bi
Rebuy - custom - https://www.rebuy.de/kaufen/suchen?q=
```

There are 2 kind of searchengines: surfraw and custom.
surfraw simply uses one of the elvi and adds parameters to it.
The examples show to image searches using duckduckgo's [!banks](https://duckduckgo.com/bang).

custom simply uses the actual query URL used by the searchengine and opens it directly in browser.
