#!/bin/tcsh

set CORE = $PWD

cd ${CORE}/../Resources/src

set SRC = $PWD

setenv DYLD_FALLBACK_LIBRARY_PATH ${KUMA}/../../MacOS/lib

echo $DYLD_FALLBACK_LIBRARY_PATH

${SRC}/../../MacOS/rsdl -I${SRC}/../lib/ruby/1.8 -I${SRC}/../lib/ruby/1.8/i686-darwin9 -I${SRC}/../lib/ruby/site_ruby/1.8 -I${SRC}/../lib/ruby/site_ruby/1.8/i686-darwin9 main.rb

