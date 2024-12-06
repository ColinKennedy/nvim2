.PHONY: api_documentation llscheck luacheck stylua test

# Git will error if the repository already exists. We ignore the error.
# NOTE: We still print out that we did the clone to the user so that they know.
#
ifeq ($(OS),Windows_NT)
    IGNORE_EXISTING = 2> nul
else
    IGNORE_EXISTING = 2> /dev/null || true
endif

clone_git_dependencies:
	git clone git@github.com:Bilal2453/luvit-meta.git .dependencies/luvit-meta $(IGNORE_EXISTING)

api_documentation:
	nvim -u scripts/make_api_documentation/minimal_init.lua -l scripts/make_api_documentation/main.lua

llscheck: clone_git_dependencies
	VIMRUNTIME=`nlua -e 'io.write(os.getenv("VIMRUNTIME"))'` llscheck --configpath .luarc.json .

luacheck:
	luacheck lua plugin

stylua:
	stylua lua plugin
