#!/usr/bin/env bats
@test "Health Script exists and is executabale" {
[ -x ./adv_healthcheck.sh ]
}

