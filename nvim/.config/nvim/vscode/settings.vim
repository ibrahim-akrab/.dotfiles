function! s:vscodeCommentary(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    elseif a:0 > 1
        let [line1, line2] = [a:1, a:2]
    else
        let [line1, line2] = [line("'["), line("']")]
    endif

    call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
endfunction

function! s:switchEditor(...) abort
    let count = a:1
    let direction = a:2
    for i in range(1, count ? count : 1)
        call VSCodeCall(direction == 'next' ? 'workbench.action.nextEditorInGroup' : 'workbench.action.previousEditorInGroup')
    endfor
endfunction

function! s:maxmizeEditor() abort
    call VSCodeNotify('workbench.action.maximizeEditor')
    call VSCodeNotify('workbench.action.closePanel')
endfunction


let mapleader = " "
" Better Navigation
noremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
noremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
noremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
noremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
noremap L :call <SID>switchEditor(v:count, 'next')<CR>
noremap H :call <SID>switchEditor(v:count, 'prev')<CR>

" Actions
noremap <leader>C :call VSCodeNotify('workbench.action.closeOtherEditors')<CR>
noremap <leader>c :call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
noremap <leader>p :call VSCodeNotify('workbench.action.showCommands')<CR>
noremap <leader>s :call VSCodeNotify('workbench.action.gotoSymbol')<CR>
noremap <leader>f :call VSCodeNotify( 'workbench.action.quickOpen')<CR>
noremap <leader>o :call VSCodeNotify('workbench.view.explorer')<CR>
noremap <leader>e :call VSCodeNotify('workbench.view.explorer')<CR>
noremap <leader>n :call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>
noremap gd :call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
noremap gi :call VSCodeNotify('editor.action.goToImplementation')<CR>
noremap gr :call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap <leader>/ :call VSCodeNotify( 'editor.action.commentLine')<CR>
xnoremap <expr> <leader>/ <SID>vscodeCommentary()
noremap <C-e> :call VSCodeNotify('workbench.actions.view.toggleProblems')<CR>
noremap <C-t> :call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>
noremap <C-z> :call <SID>maxmizeEditor()<CR>
noremap <C-j> :call VSCodeNotify('workbench.action.focusPanel')<CR>
noremap gf :call VSCodeNotify('seito-openfile.openFileFromText')<CR>
noremap <Esc> :nohl<CR>


set ignorecase
set smartcase
set incsearch hl

