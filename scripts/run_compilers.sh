#!/bin/sh

watch -n 5  \
      "node_modules/coffee-script/bin/coffee -c -o output/javascripts src/coffee/ && \
       node_modules/jade/bin/jade --out output/ -P src/jade/index.jade && \
       node_modules/less/bin/lessc src/less/app.less output/stylesheets/app.css"
