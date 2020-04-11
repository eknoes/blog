#!/bin/bash
hugo
rsync -az public/ eknoes:/var/www/virtual/soenke/eknoes.de/
