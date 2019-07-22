#!/usr/bin/env bash

CURDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
. $CURDIR/../shell_config.sh

$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t1"
$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t2"
$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t3"
$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t4"
$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t5"
$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t6"

$CLICKHOUSE_CLIENT -q "CREATE TABLE t1 AS remote('127.0.0.1', system.one)"
$CLICKHOUSE_CLIENT -q "SELECT count() FROM t1"

$CLICKHOUSE_CLIENT -q "CREATE TABLE t2 AS remote('127.0.0.1', system.numbers)"
$CLICKHOUSE_CLIENT -q "SELECT * FROM t2 LIMIT 18"

$CLICKHOUSE_CLIENT -q "CREATE TABLE t3 AS remote('127.0.0.1', numbers(100))"
$CLICKHOUSE_CLIENT -q "SELECT * FROM t3 where number > 17 and number < 25"

$CLICKHOUSE_CLIENT -q "CREATE TABLE t4 AS numbers(100)"
$CLICKHOUSE_CLIENT -q "SELECT count() FROM t4 where number > 74 "

#Syntax Errors
$CLICKHOUSE_CLIENT -q "CREATE TABLE t5 (d UInt68) AS numbers(10) -- { clientError 62 }"
$CLICKHOUSE_CLIENT -q "CREATE TABLE t6 (d UInt68) Engine = TinyLog AS numbers(10) -- { clientError 62 }"

$CLICKHOUSE_CLIENT -q "DROP TABLE t1"
$CLICKHOUSE_CLIENT -q "DROP TABLE t2"
$CLICKHOUSE_CLIENT -q "DROP TABLE t3"
$CLICKHOUSE_CLIENT -q "DROP TABLE t4"
$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t5"
$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS t6"

