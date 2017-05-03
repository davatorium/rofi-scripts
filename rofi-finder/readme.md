# Rofi finder

### Usage
If you put ```finder.sh``` under ```~/.local/share/rofi/finder.sh``` then:

```bash
rofi  -show find -modi find:~/.local/share/rofi/finder.sh
```
### Features
Type your search query to find files.

To seach again type ```!<search_query>```

To seach parent directories type ```?<search_query>```

You can print this help by typing ```!!```

### Screenshots

Type your search query to find files and press enter:

![Rofi Finder 1](rofi-finder-1.png)

The search result will be displayed in the screen:

![Rofi Finder 2](rofi-finder-2.png)

You can filter the results by typing in the search box:

![Rofi Finder 3](rofi-finder-3.png)

If you want to find a folder containing a file you can type ```?<search_query>```

![Rofi Finder 4](rofi-finder-4.png)

If you see ```??``` at the end of the result line you can press enter to open the file containing that file.

![Rofi Finder 5](rofi-finder-5.png)
