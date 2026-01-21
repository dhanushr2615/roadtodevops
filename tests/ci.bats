#!/usr/bin/env bats
@test "Health check ok" {
 run bash health.sh
 [ "$status" -eq 0 ]
}

