# counted.kak
Alternative key counts for Kakoune.

## Installation
`counted.kak` depends on `pykak`.  If using `plug.kak`:
```
plug "tomKPZ/pykak"
plug "tomKPZ/counted.kak"
```

## Configuration
To set up recommended keybindings:
```
counted-motion-add-mappings
counted-keep-sel-add-mappings
counted-insert-add-mappings
```

### Vim-style motion counts
In Vim, `5w` operates on 5 words, but in Kakoune it selects the 5th word.  To use Vim-style motions in Kakoune, use `counted-motion-add-mappings [keys]`.  If `keys` defaults to `behjklwx` if not provided.

### Alternative keep/remove selection
In Kakoune, `5<space>` is equivalent to `5)<space>`, so I don't find it as useful.  With alternative keep/remove selections, `5<space>` will keep every 5th selection, and `5<a-space>` will drop every 5th selection.  To use alternative keep/remove selections, use `counted-keep-sel-add-mappings [keep-sel-key] [remove-sel-key]`.  If `keep-sel-key` is not provided, it defaults to `<space>`.  If `remove-sel-key` is not provided, it defaults to `<a-space>`.

### Counted insert
In Kakoune, `5i` is equivalent to `i`.  With counted inserts, `5i` will begin 5 parallel inserts.  To use counted inserts, use `counted-insert-add-mappings [keys]`.  If `keys` is not provided, it defaults to `iaIA`.
