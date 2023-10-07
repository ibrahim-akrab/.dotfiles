-- init.lua


if vim.g.vscode then

    vim.cmd[[source $HOME/.config/nvim/vscode/settings.vim]]
    -- neovim.vim should be loaded after user config to override it
    vim.cmd[[source $HOME/.config/nvim/vscode/neovim.vim]]

else

end
