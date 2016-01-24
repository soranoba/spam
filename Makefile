VERSION=0.0.1

all: clean compile deploy

clean:
	rm -rf _build/default/rel/spam
	rm -rf tmp/spam

compile:
	./rebar3 release
	./rebar3 tar
	mkdir -p tmp/spam/releases/${VERSION}
	mv _build/default/rel/spam/spam-${VERSION}.tar.gz tmp/spam/releases/${VERSION}/spam.tar.gz

deploy:
	tar xvf tmp/spam/releases/${VERSION}/spam.tar.gz -C tmp/spam
