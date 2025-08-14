REBAR=rebar3

all: compile test

compile:
	@$(REBAR) compile

test:
	@$(REBAR) eunit

clean:
	@$(REBAR) clean

realclean: clean
	rm -rf _build
