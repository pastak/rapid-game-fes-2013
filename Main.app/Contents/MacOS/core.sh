#!/bin/bash

CORE="$(cd $(dirname $0) && pwd)"

cd $CORE/../Resources/

RUBY="$(pwd)"

cd ../../../

#export DYLD_LIBRARY_PATH=$CORE/lib
export DYLD_FALLBACK_LIBRARY_PATH=$CORE/lib

$CORE/rsdl -I$RUBY/lib/ruby/1.8 -I$RUBY/lib/ruby/1.8/i686-darwin9 -I$RUBY/lib/ruby/site_ruby/1.8 -I$RUBY/lib/ruby/site_ruby/1.8/i686-darwin9 main.rb

