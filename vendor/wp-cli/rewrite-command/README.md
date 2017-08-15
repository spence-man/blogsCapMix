wp-cli/rewrite-command
======================

Manage rewrite rules.

[![Build Status](https://travis-ci.org/wp-cli/rewrite-command.svg?branch=master)](https://travis-ci.org/wp-cli/rewrite-command)

Quick links: [Using](#using) | [Installing](#installing) | [Contributing](#contributing)

## Using

This package implements the following commands:

### wp rewrite flush

Flush rewrite rules.

~~~
wp rewrite flush [--hard]
~~~

Resets WordPress' rewrite rules based on registered post types, etc.

To regenerate a .htaccess file with WP-CLI, you'll need to add the mod_rewrite module
to your wp-cli.yml or config.yml. For example:

```
apache_modules:
  - mod_rewrite
```

**OPTIONS**

	[--hard]
		Perform a hard flush - update `.htaccess` rules as well as rewrite rules in database. Works only on single site installs.

**EXAMPLES**

    $ wp rewrite flush
    Success: Rewrite rules flushed.



### wp rewrite list

Get a list of the current rewrite rules.

~~~
wp rewrite list [--match=<url>] [--source=<source>] [--fields=<fields>] [--format=<format>]
~~~

**OPTIONS**

	[--match=<url>]
		Show rewrite rules matching a particular URL.

	[--source=<source>]
		Show rewrite rules from a particular source.

	[--fields=<fields>]
		Limit the output to specific fields. Defaults to match,query,source.

	[--format=<format>]
		Render output in a particular format.
		---
		default: table
		options:
		  - table
		  - csv
		  - json
		  - count
		  - yaml
		---

**EXAMPLES**

    $ wp rewrite list --format=csv
    match,query,source
    ^wp-json/?$,index.php?rest_route=/,other
    ^wp-json/(.*)?,index.php?rest_route=/$matches[1],other
    category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$,index.php?category_name=$matches[1]&feed=$matches[2],category
    category/(.+?)/(feed|rdf|rss|rss2|atom)/?$,index.php?category_name=$matches[1]&feed=$matches[2],category
    category/(.+?)/embed/?$,index.php?category_name=$matches[1]&embed=true,category



### wp rewrite structure

Update the permalink structure.

~~~
wp rewrite structure <permastruct> [--category-base=<base>] [--tag-base=<base>] [--hard]
~~~

Sets the post permalink structure to the specified pattern.

To regenerate a .htaccess file with WP-CLI, you'll need to add
the mod_rewrite module to your [WP-CLI config](http://wp-cli.org/config/).
For example:

```
apache_modules:
  - mod_rewrite
```

**OPTIONS**

	<permastruct>
		The new permalink structure to apply.

	[--category-base=<base>]
		Set the base for category permalinks, i.e. '/category/'.

	[--tag-base=<base>]
		Set the base for tag permalinks, i.e. '/tag/'.

	[--hard]
		Perform a hard flush - update `.htaccess` rules as well as rewrite rules in database.

**EXAMPLES**

    $ wp rewrite structure '/%year%/%monthnum%/%postname%'
    Success: Rewrite structure set.

## Installing

This package is included with WP-CLI itself, no additional installation necessary.

To install the latest version of this package over what's included in WP-CLI, run:

    wp package install git@github.com:wp-cli/rewrite-command.git

## Contributing

We appreciate you taking the initiative to contribute to this project.

Contributing isn’t limited to just code. We encourage you to contribute in the way that best fits your abilities, by writing tutorials, giving a demo at your local meetup, helping other users with their support questions, or revising our documentation.

### Reporting a bug

Think you’ve found a bug? We’d love for you to help us get it fixed.

Before you create a new issue, you should [search existing issues](https://github.com/wp-cli/rewrite-command/issues?q=label%3Abug%20) to see if there’s an existing resolution to it, or if it’s already been fixed in a newer version.

Once you’ve done a bit of searching and discovered there isn’t an open or fixed issue for your bug, please [create a new issue](https://github.com/wp-cli/rewrite-command/issues/new) with the following:

1. What you were doing (e.g. "When I run `wp post list`").
2. What you saw (e.g. "I see a fatal about a class being undefined.").
3. What you expected to see (e.g. "I expected to see the list of posts.")

Include as much detail as you can, and clear steps to reproduce if possible.

### Creating a pull request

Want to contribute a new feature? Please first [open a new issue](https://github.com/wp-cli/rewrite-command/issues/new) to discuss whether the feature is a good fit for the project.

Once you've decided to commit the time to seeing your pull request through, please follow our guidelines for creating a pull request to make sure it's a pleasant experience:

1. Create a feature branch for each contribution.
2. Submit your pull request early for feedback.
3. Include functional tests with your changes. [Read the WP-CLI documentation](https://wp-cli.org/docs/pull-requests/#functional-tests) for an introduction.
4. Follow the [WordPress Coding Standards](http://make.wordpress.org/core/handbook/coding-standards/).


*This README.md is generated dynamically from the project's codebase using `wp scaffold package-readme` ([doc](https://github.com/wp-cli/scaffold-package-command#wp-scaffold-package-readme)). To suggest changes, please submit a pull request against the corresponding part of the codebase.*
