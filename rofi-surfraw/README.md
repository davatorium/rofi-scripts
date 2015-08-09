# rofi-surfraw
#### a little frontend for surfraw, utilizing rofi

this script shows a list of all "elvis" and let's the user choose one.
It then asks for a search term and opens a browser with the results.

In addition to elvis it's possible to add your own.
For this `$HOME/.config/rofi-surfraw/searchengines` is parsed, which looks
like this:

```
!gi - surfraw - duckduckgo !gi
!sp - custom - http://www.sputnikmusic.com/search_results.php?genreid=0&search_in=Bands&search_text=
```

There are 2 kind of searchengines: surfraw and custom.
surfraw simply uses one of the elvi and adds parameters to it.
The examples shows an image search using duckduckgo's [!bangs](https://duckduckgo.com/bang).

custom simply uses the actual query URL used by the searchengine and opens it directly in browser.

Each custom search engine has a bang defined. (Starting with !).
These can be used to instantly search. (Just type "!gi foobar")

#### Options
`--no-list`   - do not show surfraw's inbuild search engines<br />
`--no-custom` - do not show custom search engines
