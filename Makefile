VERSION=0.0.2

all: compile

clean:
	rm -rf _build/default/rel/spam
	rm -rf tmp/spam

compile:
	./rebar3 release
	./rebar3 appup generate -p tmp/spam
	./gen_relup.erl
	./rebar3 tar
	mkdir -p tmp/spam/releases/${VERSION}
	mv _build/default/rel/spam/spam-${VERSION}.tar.gz tmp/spam/releases/${VERSION}/spam.tar.gz

deploy:
	tar xvf tmp/spam/releases/${VERSION}/spam.tar.gz -C tmp/spam
