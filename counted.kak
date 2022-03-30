python %{
    global counted_motion, counted_keep_sel, counted_insert
    global counted_motion_add_mappings
    global counted_keep_sel_add_mappings
    global counted_insert_add_mappings

    def counted_motion(args):
        count = int(val('count'))
        keys = args[0]
        if count > 1:
            keys += '%d%s' % ((count - 1), args[1])
        keval('exec ' + keys)

    def counted_keep_sel(args):
        count = int(val('count'))
        sels = valq('selections_desc')
        mode = int(args[0])
        if count > 1:
            sels = [sel for (i, sel) in enumerate(sels)
                    if (i % count == 0) == mode]
            keval('select ' + quote(sels))
        else:
            keval('exec ' + ('<space>' if mode else '<a-space>'))

    def counted_insert(args):
        count = int(val('count'))
        dup = '%d+' % count if count > 1 else ''
        keval('exec -with-hooks %s%s' % (dup, args[0]))

    def counted_motion_add_mappings(args):
        keys = args[0] if args else 'behjklwx'
        keval('\n'.join([
            'map global normal %s ": counted-motion %s %s<ret>"'
                % (k, k, k.upper())
            for k in keys
        ]))

    def counted_keep_sel_add_mappings(args):
        if not args: args = ['<space>', '<a-space>']
        if len(args) == 1: args.append('<a-space>')
        keval('''
            map global normal %s ': counted-keep-sel 1<ret>'
            map global normal %s ': counted-keep-sel 0<ret>'
        ''' % tuple(args))

    def counted_insert_add_mappings(args):
        keys = args[0] if args else 'iaIA'
        keval('\n'.join([
            'map global normal %s ": counted-insert %s<ret>"' % (k, k)
            for k in keys
        ]))
}

def counted-motion -params 2 %{ py %arg{@} %{ counted_motion(args) } }
def counted-keep-sel -params 1 %{ py %arg{@} %{ counted_keep_sel(args) } }
def counted-insert -params 1 %{ py %arg{@} %{ counted_insert(args) } }

def counted-motion-add-mappings -params 0..1 %{
    py %arg{@} %{ counted_motion_add_mappings(args) }
}
def counted-keep-sel-add-mappings -params 0..2 %{
    py %arg{@} %{ counted_keep_sel_add_mappings(args) }
}
def counted-insert-add-mappings -params 0..1 %{
    py %arg{@} %{ counted_insert_add_mappings(args) }
}
