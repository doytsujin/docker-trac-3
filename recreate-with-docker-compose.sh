#!/bin/bash

sudo rm -rf src/*;docker-compose stop;docker-compose rm -f;docker rmi dockertrac_trac;docker-compose up -d;docker logs -f dockertrac_trac_1
