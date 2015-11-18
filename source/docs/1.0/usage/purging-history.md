# Purging History

Flapjack by default keeps the details of all state changes for all checks around in redis forever. This will cause your redis db to keep growing and over time you may run out of memory. You can use the `purge` flapjack subcommand to clean up ancient history. It can be run for all checks, or specifically named checks.
## Purging history of all checks

`flapjack purge check_history --days DAYS`

This will remove all historical state changes more than DAYS old for all checks.

Eg:

```bash
$ flapjack purge check_history --days 30
Purged 2 historical check states over 1 checks.
```

## Purging history of a specific check

`flapjack purge check_history --days DAYS --check CHECK`

This will remove all historical state changes more than DAYS old for CHECK.

Eg:

```bash
$ flapjack purge check_history --days 0 --check foo-app-01:HTTP
Purged 2 historical check states over 1 checks.
```
