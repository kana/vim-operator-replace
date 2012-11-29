runtime! plugin/operator/*.vim




describe 'Named key mappings'
  it 'is available in proper modes'
    let lhs = '<Plug>(operator-replace)'
    Expect maparg(lhs, 'c') ==# ''
    Expect maparg(lhs, 'i') ==# ''
    Expect maparg(lhs, 'n') =~# 'operator#replace#'
    Expect maparg(lhs, 'o') ==# 'g@'
    Expect maparg(lhs, 'v') =~# 'operator#replace#'
  end
end




describe '<Plug>(operator-replace) with block {motion}'
  " FIXME: NIY - but what result I expect for this case?
end




describe '<Plug>(operator-replace) with char {motion}'
  before
    tabnew
    let @" = 'qux'
    let @s = 'waldo'
    put ='foo bar baz'
  end

  after
    tabclose!
  end

  it 'works fine with block {register} content'
    SKIP 'FIXME: NIY - but what result I expect for this case?'
  end

  it 'works fine with char {register} content (1)'
    " {operator}{characterwise-motion} without register designation
    execute 'normal' "\<Plug>(operator-replace)e"
    Expect getline('.') ==# 'qux bar baz'
    Expect [getreg('"'), getregtype('"')] ==# ['qux', 'v']
    Expect [getreg('s'), getregtype('s')] ==# ['waldo', 'v']
  end

  it 'works fine with char {register} content (2)'
    " {characterwise-Visual}{operator} without register designation
    execute 'normal' "ve\<Plug>(operator-replace)"
    Expect getline('.') ==# 'qux bar baz'
    Expect [getreg('"'), getregtype('"')] ==# ['qux', 'v']
    Expect [getreg('s'), getregtype('s')] ==# ['waldo', 'v']
  end

  it 'works fine with char {register} content (3)'
    " {operator}{characterwise-motion} with register designation
    execute 'normal' "\"s\<Plug>(operator-replace)e"
    Expect getline('.') ==# 'waldo bar baz'
    Expect [getreg('"'), getregtype('"')] ==# ['qux', 'v']
    Expect [getreg('s'), getregtype('s')] ==# ['waldo', 'v']
  end

  it 'works fine with char {register} content (4)'
    " {characterwise-Visual}{operator} with register designation
    execute 'normal' "ve\"s\<Plug>(operator-replace)"
    Expect getline('.') ==# 'waldo bar baz'
    Expect [getreg('"'), getregtype('"')] ==# ['qux', 'v']
    Expect [getreg('s'), getregtype('s')] ==# ['waldo', 'v']
  end

  it 'works fine with char {register} content (5)'
    " {operator}{characterwise-motion} including the end of buffer
    execute 'normal' "\"s\<Plug>(operator-replace)$"
    Expect getline('.') ==# 'waldo'
    Expect [getreg('"'), getregtype('"')] ==# ['qux', 'v']
    Expect [getreg('s'), getregtype('s')] ==# ['waldo', 'v']
  end

  it 'works fine with char {register} content (6)'
    " {characterwise-Visual}{operator} including the end of buffer
    execute 'normal' "v$\"s\<Plug>(operator-replace)"
    Expect getline('.') ==# 'waldo'
    Expect [getreg('"'), getregtype('"')] ==# ['qux', 'v']
    Expect [getreg('s'), getregtype('s')] ==# ['waldo', 'v']
  end

  it 'works fine with line {register} content'
    SKIP 'FIXME: NIY - but what result I expect for this case?'
  end
end




describe '<Plug>(operator-replace) with line {motion}'
  before
    tabnew
    put ='foo foo foo'
    put ='bar bar bar'
    put ='baz baz baz'
    1 delete _
    2
    let @" = "qux\n"
    let @s = "waldo\n"
  end

  after
    tabclose!
  end

  it 'works fine with block {register} content'
    SKIP 'FIXME: NIY - but what result I expect for this case?'
  end

  it 'works fine with char {register} content'
    SKIP 'FIXME: NIY - but what result I expect for this case?'
  end

  it 'works fine with line {register} content (1)'
    " {operator}{linewise-motion} without register designation
    execute 'normal' "\<Plug>(operator-replace)\<Plug>(operator-replace)"
    Expect getline(1) ==# 'foo foo foo'
    Expect getline(2) ==# 'qux'
    Expect getline(3) ==# 'baz baz baz'
    Expect line('$') == 3
    Expect [getreg('"'), getregtype('"')] ==# ["qux\n", 'V']
    Expect [getreg('s'), getregtype('s')] ==# ["waldo\n", 'V']
  end

  it 'works fine with line {register} content (2)'
    " {linewise-Visual}{operator} without register designation
    execute 'normal' "Vw\<Plug>(operator-replace)"
    Expect getline(1) ==# 'foo foo foo'
    Expect getline(2) ==# 'qux'
    Expect getline(3) ==# 'baz baz baz'
    Expect line('$') == 3
    Expect [getreg('"'), getregtype('"')] ==# ["qux\n", 'V']
    Expect [getreg('s'), getregtype('s')] ==# ["waldo\n", 'V']
  end

  it 'works fine with line {register} content (3)'
    " {operator}{linewise-motion} with register designation
    execute 'normal' "\"s\<Plug>(operator-replace)\<Plug>(operator-replace)"
    Expect getline(1) ==# 'foo foo foo'
    Expect getline(2) ==# 'waldo'
    Expect getline(3) ==# 'baz baz baz'
    Expect line('$') == 3
    Expect [getreg('"'), getregtype('"')] ==# ["qux\n", 'V']
    Expect [getreg('s'), getregtype('s')] ==# ["waldo\n", 'V']
  end

  it 'works fine with line {register} content (4)'
    " {linewise-Visual}{operator} with register designation
    execute 'normal' "Ve\"s\<Plug>(operator-replace)"
    Expect getline(1) ==# 'foo foo foo'
    Expect getline(2) ==# 'waldo'
    Expect getline(3) ==# 'baz baz baz'
    Expect line('$') == 3
    Expect [getreg('"'), getregtype('"')] ==# ["qux\n", 'V']
    Expect [getreg('s'), getregtype('s')] ==# ["waldo\n", 'V']
  end

  it 'works fine with line {register} content (5)'
    " {operator}{linewise-motion} including the end of buffer
    execute 'normal' "\<Plug>(operator-replace)j"
    Expect getline(1) ==# 'foo foo foo'
    Expect getline(2) ==# 'qux'
    Expect line('$') == 2
    Expect [getreg('"'), getregtype('"')] ==# ["qux\n", 'V']
    Expect [getreg('s'), getregtype('s')] ==# ["waldo\n", 'V']
  end

  it 'works fine with line {register} content (6)'
    " {linewise-Visual}{operator} including the end of buffer
    execute 'normal' "Vk\<Plug>(operator-replace)"
    Expect getline(1) ==# 'qux'
    Expect getline(2) ==# 'baz baz baz'
    Expect line('$') == 2
    Expect [getreg('"'), getregtype('"')] ==# ["qux\n", 'V']
    Expect [getreg('s'), getregtype('s')] ==# ["waldo\n", 'V']
  end
end
