runtime! plugin/operator/*.vim

describe '<Plug>(operator-replace)'
  before
    new
    call setline(1, 'hoge huga poyo')
  end

  after
    close!
  end

  it 'works properly when regtype is V and object is entire buffer'
    call setreg('s', 'piyo poyo', 'V')
    execute 'normal' "V\"s\<Plug>(operator-replace)"
    Expect line('$') == 1
    Expect getline(1) ==# 'piyo poyo'
  end
end
