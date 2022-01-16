runtime! plugin/operator/*.vim

describe '<Plug>(operator-replace)'
  before
    new

    function! b:.go(virtualedit)
      let original_virtualedit = &g:virtualedit
      let &g:virtualedit = a:virtualedit

      put ='abcd'
      let @" = 'xyz'
      execute 'normal' "viw\<Plug>(operator-replace)e"
      Expect getline('.') ==# 'xyz'

      let &g:virtualedit = original_virtualedit
    endfunction
  end

  after
    close!
  end

  it 'works properly with &virtualedit == ""'
    call b:.go('')
  end

  it 'works properly with &virtualedit == "block"'
    call b:.go('block')
  end

  it 'works properly with &virtualedit == "insert"'
    call b:.go('insert')
  end

  it 'works properly with &virtualedit == "all"'
    call b:.go('all')
  end

  it 'works properly with &virtualedit == "onemore"'
    call b:.go('onemore')
  end
end

