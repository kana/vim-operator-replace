runtime! plugin/operator/*.vim
runtime! plugin/textobj/*.vim

describe '<Plug>(operator-replace)'
  before
    new
    0 put ='  foo bar baz  '
    let @" = '"""'
    let @a = 'aaa'
    map <buffer> _  <Plug>(operator-replace)
  end

  after
    close!
  end

  context 'with a built-in text object'
    it 'uses a given register'
      Expect getline('.') ==# '  foo bar baz  '
      normal! fa
      normal "a_iw
      Expect getline('.') ==# '  foo aaa baz  '
    end
  end

  context 'with a custom text object'
    it 'uses a given register'
      Expect getline('.') ==# '  foo bar baz  '
      normal "a_il
      Expect getline('.') ==# '  aaa  '
    end
  end
end
