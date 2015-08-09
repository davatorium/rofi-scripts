# rofi-surfraw
#### a little frontend for surfraw, utilizing rofi

this script shows a list of all "elvis". The list can be filtered and
elvis completed with Ctrl+Space. Everything typed after an elvis
is considered a searchterm and a browser will open with the appropriate seach results.
If you don't know what surfraw is or what elvis means, have a look on the [surfraw homepage](https://surfraw.alioth.debian.org/)

In addition to elvis it's possible to add your own.
For this `$HOME/.config/rofi-surfraw/searchengines` is parsed, which looks
like this:

```
!gi - surfraw - duckduckgo !gi
!sp - custom - http://www.sputnikmusic.com/search_results.php?genreid=0&search_in=Bands&search_text=
```

There are 2 kind of searchengines: surfraw and custom.
* surfraw  
  simply uses one of the elvi and adds parameters to it. The examples shows an image search using duckduckgo's [!bangs](https://duckduckgo.com/bang).
* custom  
  simply uses the actual query URL used by the searchengine and opens it directly in browser.

Each custom search engine has a bang defined. (Starting with !).
These can be used to instantly search. (Just type "!gi foobar")

If no bang (words starting with ? or !) starts the line, the default engine will be used.
This can be configured in the config file.

#### Options
`--no-list`   - do not show surfraw's inbuild search engines<br />
`--no-custom` - do not show custom search engines
