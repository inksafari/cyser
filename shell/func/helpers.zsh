#!/usr/bin/env sh
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}
