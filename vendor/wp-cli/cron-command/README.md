wp-cli/cron-command
===================

Manage WP-Cron events and schedules.

[![Build Status](https://travis-ci.org/wp-cli/cron-command.svg?branch=master)](https://travis-ci.org/wp-cli/cron-command)

Quick links: [Using](#using) | [Installing](#installing) | [Contributing](#contributing)

## Using

This package implements the following commands:

### wp cron test

Test the WP Cron spawning system and report back its status.

~~~
wp cron test 
~~~

This command tests the spawning system by performing the following steps:

* Checks to see if the `DISABLE_WP_CRON` constant is set; errors if true
because WP-Cron is disabled.
* Checks to see if the `ALTERNATE_WP_CRON` constant is set; warns if true.
* Attempts to spawn WP-Cron over HTTP; warns if non 200 response code is
returned.

**EXAMPLES**

    # Cron test runs successfully.
    $ wp cron test
    Success: WP-Cron spawning is working as expected.



### wp cron event delete

Delete the next scheduled cron event for the given hook.

~~~
wp cron event delete <hook>
~~~

**OPTIONS**

	<hook>
		The hook name.

**EXAMPLES**

    # Delete the next scheduled cron event
    $ wp cron event delete cron_test
    Success: Deleted 2 instances of the cron event 'cron_test'.



### wp cron event list

List scheduled cron events.

~~~
wp cron event list [--fields=<fields>] [--<field>=<value>] [--field=<field>] [--format=<format>]
~~~

**OPTIONS**

	[--fields=<fields>]
		Limit the output to specific object fields.

	[--<field>=<value>]
		Filter by one or more fields.

	[--field=<field>]
		Prints the value of a single field for each event.

	[--format=<format>]
		Render output in a particular format.
		---
		default: table
		options:
		  - table
		  - csv
		  - ids
		  - json
		  - count
		  - yaml
		---

**AVAILABLE FIELDS**

These fields will be displayed by default for each cron event:
* hook
* next_run_gmt
* next_run_relative
* recurrence

These fields are optionally available:
* time
* sig
* args
* schedule
* interval
* next_run

**EXAMPLES**

    # List scheduled cron events
    $ wp cron event list
    +-------------------+---------------------+---------------------+------------+
    | hook              | next_run_gmt        | next_run_relative   | recurrence |
    +-------------------+---------------------+---------------------+------------+
    | wp_version_check  | 2016-05-31 22:15:13 | 11 hours 57 minutes | 12 hours   |
    | wp_update_plugins | 2016-05-31 22:15:13 | 11 hours 57 minutes | 12 hours   |
    | wp_update_themes  | 2016-05-31 22:15:14 | 11 hours 57 minutes | 12 hours   |
    +-------------------+---------------------+---------------------+------------+

    # List scheduled cron events in JSON
    $ wp cron event list --fields=hook,next_run --format=json
    [{"hook":"wp_version_check","next_run":"2016-05-31 10:15:13"},{"hook":"wp_update_plugins","next_run":"2016-05-31 10:15:13"},{"hook":"wp_update_themes","next_run":"2016-05-31 10:15:14"}]



### wp cron event run

Run the next scheduled cron event for the given hook.

~~~
wp cron event run [<hook>...] [--due-now] [--all]
~~~

**OPTIONS**

	[<hook>...]
		One or more hooks to run.

	[--due-now]
		Run all hooks due right now.

	[--all]
		Run all hooks.

**EXAMPLES**

    # Run all cron events due right now
    $ wp cron event run --due-now
    Success: Executed a total of 2 cron events.



### wp cron event schedule

Schedule a new cron event.

~~~
wp cron event schedule <hook> [<next-run>] [<recurrence>] [--<field>=<value>]
~~~

**OPTIONS**

	<hook>
		The hook name.

	[<next-run>]
		A Unix timestamp or an English textual datetime description compatible with `strtotime()`. Defaults to now.

	[<recurrence>]
		How often the event should recur. See `wp cron schedule list` for available schedule names. Defaults to no recurrence.

	[--<field>=<value>]
		Associative args for the event.

**EXAMPLES**

    # Schedule a new cron event
    $ wp cron event schedule cron_test
    Success: Scheduled event with hook 'cron_test' for 2016-05-31 10:19:16 GMT.

    # Schedule new cron event with hourly recurrence
    $ wp cron event schedule cron_test now hourly
    Success: Scheduled event with hook 'cron_test' for 2016-05-31 10:20:32 GMT.

    # Schedule new cron event and pass associative arguments
    $ wp cron event schedule cron_test '+1 hour' --foo=1 --bar=2
    Success: Scheduled event with hook 'cron_test' for 2016-05-31 11:21:35 GMT.



### wp cron schedule list

List available cron schedules.

~~~
wp cron schedule list [--fields=<fields>] [--field=<field>] [--format=<format>]
~~~

**OPTIONS**

	[--fields=<fields>]
		Limit the output to specific object fields.

	[--field=<field>]
		Prints the value of a single field for each schedule.

	[--format=<format>]
		Render output in a particular format.
		---
		default: table
		options:
		  - table
		  - csv
		  - ids
		  - json
		  - yaml
		---

**AVAILABLE FIELDS**

These fields will be displayed by default for each cron schedule:

* name
* display
* interval

There are no additional fields.

**EXAMPLES**

    # List available cron schedules
    $ wp cron schedule list
    +------------+-------------+----------+
    | name       | display     | interval |
    +------------+-------------+----------+
    | hourly     | Once Hourly | 3600     |
    | twicedaily | Twice Daily | 43200    |
    | daily      | Once Daily  | 86400    |
    +------------+-------------+----------+

    # List id of available cron schedule
    $ wp cron schedule list --fields=name --format=ids
    hourly twicedaily daily

## Installing

This package is included with WP-CLI itself, no additional installation necessary.

To install the latest version of this package over what's included in WP-CLI, run:

    wp package install git@github.com:wp-cli/cron-command.git

## Contributing

We appreciate you taking the initiative to contribute to this project.

Contributing isn’t limited to just code. We encourage you to contribute in the way that best fits your abilities, by writing tutorials, giving a demo at your local meetup, helping other users with their support questions, or revising our documentation.

### Reporting a bug

Think you’ve found a bug? We’d love for you to help us get it fixed.

Before you create a new issue, you should [search existing issues](https://github.com/wp-cli/cron-command/issues?q=label%3Abug%20) to see if there’s an existing resolution to it, or if it’s already been fixed in a newer version.

Once you’ve done a bit of searching and discovered there isn’t an open or fixed issue for your bug, please [create a new issue](https://github.com/wp-cli/cron-command/issues/new) with the following:

1. What you were doing (e.g. "When I run `wp post list`").
2. What you saw (e.g. "I see a fatal about a class being undefined.").
3. What you expected to see (e.g. "I expected to see the list of posts.")

Include as much detail as you can, and clear steps to reproduce if possible.

### Creating a pull request

Want to contribute a new feature? Please first [open a new issue](https://github.com/wp-cli/cron-command/issues/new) to discuss whether the feature is a good fit for the project.

Once you've decided to commit the time to seeing your pull request through, please follow our guidelines for creating a pull request to make sure it's a pleasant experience:

1. Create a feature branch for each contribution.
2. Submit your pull request early for feedback.
3. Include functional tests with your changes. [Read the WP-CLI documentation](https://wp-cli.org/docs/pull-requests/#functional-tests) for an introduction.
4. Follow the [WordPress Coding Standards](http://make.wordpress.org/core/handbook/coding-standards/).


*This README.md is generated dynamically from the project's codebase using `wp scaffold package-readme` ([doc](https://github.com/wp-cli/scaffold-package-command#wp-scaffold-package-readme)). To suggest changes, please submit a pull request against the corresponding part of the codebase.*
