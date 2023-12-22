#!/bin/bash

for i in {1..10000}
do
   cp router.unix ./conf/router.unix.$i
done