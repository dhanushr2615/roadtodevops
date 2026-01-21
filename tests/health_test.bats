#!/usr/bin/env bats

@test "Health scripts runs successfully" {
 run bash health.sh
 [ "$status" -ge 0 ]
}

@test "Health log file is created" {
 run test -f /tmp/health.log
 [ "$status" -ge 0 ]
}

@test "Disk usage is logged" {
 run grep "DISK" /tmp/health.log
 ["$status" -ge 0 ]
}

@test "Service status is logged" {
 run grep "service" /tmp/health.log
 ["$status" -ge 0 ]
}

