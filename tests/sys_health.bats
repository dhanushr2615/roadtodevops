#!/usr/bin/env bats
@test "Health Script exists and is executabale" {
[ -x ./sys_health.sh ]
}

