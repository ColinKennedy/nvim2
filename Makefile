.PHONY: api_documentation check-stylua llscheck luacheck stylua test

# Git will error if the repository already exists. We ignore the error.
# NOTE: We still print out that we did the clone to the user so that they know.
#
ifeq ($(OS),Windows_NT)
    IGNORE_EXISTING = 2> nul
else
    IGNORE_EXISTING = 2> /dev/null || true
endif

CONFIGURATION = .luarc.json

clone_git_dependencies:
	git clone git@github.com:Bilal2453/luvit-meta.git .dependencies/luvit-meta $(IGNORE_EXISTING)

llscheck: clone_git_dependencies
	VIMRUNTIME="`nvim --clean --headless --cmd 'lua io.write(os.getenv("VIMRUNTIME"))' --cmd 'quit'`" llscheck --configpath $(CONFIGURATION) .

luacheck:
	luacheck lua plugin scripts

check-stylua:
	stylua lua plugin scripts --color always --check

stylua:
	stylua lua plugin scripts
