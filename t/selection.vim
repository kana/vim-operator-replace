runtime! plugin/operator/*.vim

describe '<Plug>(operator-replace)'
  before
    new

    function! b:.go(selection)
      let original_selection = &g:selection
      let &g:selection = a:selection

      put ='abcd'
      let @" = 'xyz'
      execute 'normal' "viw\<Plug>(operator-replace)e"
      Expect getline('.') ==# 'xyz'

      let &g:selection = original_selection
    endfunction
  end

  after
    close!
  end

  it 'works properly with &selection == "inclusive"'
    call b:.go('inclusive')
  end

  it 'works properly with &selection == "exclusive"'
    call b:.go('exclusive')
  end
end
