#!/bin/bash
ls
top=uart
fn=$top.v
cmd="curl http://bashupload.com/$fn --data-binary @$fn"
echo $cmd
eval $cmd
