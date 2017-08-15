wp-cli/scaffold-command
=======================

Generate code for post types, taxonomies, plugins, child themes, etc.

[![Build Status](https://travis-ci.org/wp-cli/scaffold-command.svg?branch=master)](https://travis-ci.org/wp-cli/scaffold-command)

Quick links: [Using](#using) | [Installing](#installing) | [Contributing](#contributing)

## Using

This package implements the following commands:

### wp scaffold

Generate code for post types, taxonomies, plugins, child themes, etc.

~~~
wp scaffold
~~~

**EXAMPLES**

    # Generate a new plugin with unit tests
    $ wp scaffold plugin sample-plugin
    Success: Created plugin files.
    Success: Created test files.

    # Generate theme based on _s
    $ wp scaffold _s sample-theme --theme_name="Sample Theme" --author="John Doe"
    Success: Created theme 'Sample Theme'.

    # Generate code for post type registration in given theme
    $ wp scaffold post-type movie --label=Movie --theme=simple-life
    Success: Created /var/www/example.com/public_html/wp-content/themes/simple-life/post-types/movie.php



### wp scaffold _s

Generate starter code for a theme based on _s.

~~~
wp scaffold _s <slug> [--activate] [--enable-network] [--theme_name=<title>] [--author=<full-name>] [--author_uri=<uri>] [--sassify] [--force]
~~~

See the [Underscores website](http://underscores.me/) for more details.

**OPTIONS**

	<slug>
		The slug for the new theme, used for prefixing functions.

	[--activate]
		Activate the newly downloaded theme.

	[--enable-network]
		Enable the newly downloaded theme for the entire network.

	[--theme_name=<title>]
		What to put in the 'Theme Name:' header in 'style.css'.

	[--author=<full-name>]
		What to put in the 'Author:' header in 'style.css'.

	[--author_uri=<uri>]
		What to put in the 'Author URI:' header in 'style.css'.

	[--sassify]
		Include stylesheets as SASS.

	[--force]
		Overwrite files that already exist.

**EXAMPLES**

    # Generate a theme with name "Sample Theme" and author "John Doe"
    $ wp scaffold _s sample-theme --theme_name="Sample Theme" --author="John Doe"
    Success: Created theme 'Sample Theme'.



### wp scaffold child-theme

Generate child theme based on an existing theme.

~~~
wp scaffold child-theme <slug> --parent_theme=<slug> [--theme_name=<title>] [--author=<full-name>] [--author_uri=<uri>] [--theme_uri=<uri>] [--activate] [--enable-network] [--force]
~~~

Creates a child theme folder with `functions.php` and `style.css` files.

**OPTIONS**

	<slug>
		The slug for the new child theme.

	--parent_theme=<slug>
		What to put in the 'Template:' header in 'style.css'.

	[--theme_name=<title>]
		What to put in the 'Theme Name:' header in 'style.css'.

	[--author=<full-name>]
		What to put in the 'Author:' header in 'style.css'.

	[--author_uri=<uri>]
		What to put in the 'Author URI:' header in 'style.css'.

	[--theme_uri=<uri>]
		What to put in the 'Theme URI:' header in 'style.css'.

	[--activate]
		Activate the newly created child theme.

	[--enable-network]
		Enable the newly created child theme for the entire network.

	[--force]
		Overwrite files that already exist.

**EXAMPLES**

    # Generate a 'sample-theme' child theme based on TwentySixteen
    $ wp scaffold child-theme sample-theme --parent_theme=twentysixteen
    Success: Created '/var/www/example.com/public_html/wp-content/themes/sample-theme'.



### wp scaffold plugin

Generate starter code for a plugin.

~~~
wp scaffold plugin <slug> [--dir=<dirname>] [--plugin_name=<title>] [--plugin_description=<description>] [--plugin_author=<author>] [--plugin_author_uri=<url>] [--plugin_uri=<url>] [--skip-tests] [--ci=<provider>] [--activate] [--activate-network] [--force]
~~~

The following files are always generated:

* `plugin-slug.php` is the main PHP plugin file.
* `readme.txt` is the readme file for the plugin.
* `package.json` needed by NPM holds various metadata relevant to the project. Packages: `grunt`, `grunt-wp-i18n` and `grunt-wp-readme-to-markdown`.
* `Gruntfile.js` is the JS file containing Grunt tasks. Tasks: `i18n` containing `addtextdomain` and `makepot`, `readme` containing `wp_readme_to_markdown`.
* `.editorconfig` is the configuration file for Editor.
* `.gitignore` tells which files (or patterns) git should ignore.
* `.distignore` tells which files and folders should be ignored in distribution.

The following files are also included unless the `--skip-tests` is used:

* `phpunit.xml.dist` is the configuration file for PHPUnit.
* `.travis.yml` is the configuration file for Travis CI. Use `--ci=<provider>` to select a different service.
* `bin/install-wp-tests.sh` configures the WordPress test suite and a test database.
* `tests/bootstrap.php` is the file that makes the current plugin active when running the test suite.
* `tests/test-sample.php` is a sample file containing test cases.
* `phpcs.ruleset.xml` is a collenction of PHP_CodeSniffer rules.

**OPTIONS**

	<slug>
		The internal name of the plugin.

	[--dir=<dirname>]
		Put the new plugin in some arbitrary directory path. Plugin directory will be path plus supplied slug.

	[--plugin_name=<title>]
		What to put in the 'Plugin Name:' header.

	[--plugin_description=<description>]
		What to put in the 'Description:' header.

	[--plugin_author=<author>]
		What to put in the 'Author:' header.

	[--plugin_author_uri=<url>]
		What to put in the 'Author URI:' header.

	[--plugin_uri=<url>]
		What to put in the 'Plugin URI:' header.

	[--skip-tests]
		Don't generate files for unit testing.

	[--ci=<provider>]
		Choose a configuration file for a continuous integration provider.
		---
		default: travis
		options:
		  - travis
		  - circle
		  - gitlab
		---

	[--activate]
		Activate the newly generated plugin.

	[--activate-network]
		Network activate the newly generated plugin.

	[--force]
		Overwrite files that already exist.

**EXAMPLES**

    $ wp scaffold plugin sample-plugin
    Success: Created plugin files.
    Success: Created test files.



### wp scaffold plugin-tests

Generate files needed for running PHPUnit tests in a plugin.

~~~
wp scaffold plugin-tests [<plugin>] [--dir=<dirname>] [--ci=<provider>] [--force]
~~~

The following files are generated by default:

* `phpunit.xml.dist` is the configuration file for PHPUnit.
* `.travis.yml` is the configuration file for Travis CI. Use `--ci=<provider>` to select a different service.
* `bin/install-wp-tests.sh` configures the WordPress test suite and a test database.
* `tests/bootstrap.php` is the file that makes the current plugin active when running the test suite.
* `tests/test-sample.php` is a sample file containing the actual tests.
* `phpcs.ruleset.xml` is a collenction of PHP_CodeSniffer rules.

Learn more from the [plugin unit tests documentation](http://wp-cli.org/docs/plugin-unit-tests/).

**ENVIRONMENT**

The `tests/bootstrap.php` file looks for the WP_TESTS_DIR environment
variable.

**OPTIONS**

	[<plugin>]
		The name of the plugin to generate test files for.

	[--dir=<dirname>]
		Generate test files for a non-standard plugin path. If no plugin slug is specified, the directory name is used.

	[--ci=<provider>]
		Choose a configuration file for a continuous integration provider.
		---
		default: travis
		options:
		  - travis
		  - circle
		  - gitlab
		---

	[--force]
		Overwrite files that already exist.

**EXAMPLES**

    # Generate unit test files for plugin 'sample-plugin'.
    $ wp scaffold plugin-tests sample-plugin
    Success: Created test files.



### wp scaffold post-type

Generate PHP code for registering a custom post type.

~~~
wp scaffold post-type <slug> [--label=<label>] [--textdomain=<textdomain>] [--dashicon=<dashicon>] [--theme] [--plugin=<plugin>] [--raw] [--force]
~~~

**OPTIONS**

	<slug>
		The internal name of the post type.

	[--label=<label>]
		The text used to translate the update messages.

	[--textdomain=<textdomain>]
		The textdomain to use for the labels.

	[--dashicon=<dashicon>]
		The dashicon to use in the menu.

	[--theme]
		Create a file in the active theme directory, instead of sending to
		STDOUT. Specify a theme with `--theme=<theme>` to have the file placed in that theme.

	[--plugin=<plugin>]
		Create a file in the given plugin's directory, instead of sending to STDOUT.

	[--raw]
		Just generate the `register_post_type()` call and nothing else.

	[--force]
		Overwrite files that already exist.

**EXAMPLES**

    # Generate a 'movie' post type for the 'simple-life' theme
    $ wp scaffold post-type movie --label=Movie --theme=simple-life
    Success: Created '/var/www/example.com/public_html/wp-content/themes/simple-life/post-types/movie.php'.



### wp scaffold taxonomy

Generate PHP code for registering a custom taxonomy.

~~~
wp scaffold taxonomy <slug> [--post_types=<post-types>] [--label=<label>] [--textdomain=<textdomain>] [--theme] [--plugin=<plugin>] [--raw] [--force]
~~~

**OPTIONS**

	<slug>
		The internal name of the taxonomy.

	[--post_types=<post-types>]
		Post types to register for use with the taxonomy.

	[--label=<label>]
		The text used to translate the update messages.

	[--textdomain=<textdomain>]
		The textdomain to use for the labels.

	[--theme]
		Create a file in the active theme directory, instead of sending to
		STDOUT. Specify a theme with `--theme=<theme>` to have the file placed in that theme.

	[--plugin=<plugin>]
		Create a file in the given plugin's directory, instead of sending to STDOUT.

	[--raw]
		Just generate the `register_taxonomy()` call and nothing else.

	[--force]
		Overwrite files that already exist.

**EXAMPLES**

    # Generate PHP code for registering a custom taxonomy and save in a file
    $ wp scaffold taxonomy venue --post_types=event,presentation > taxonomy.php



### wp scaffold theme-tests

Generate files needed for running PHPUnit tests in a theme.

~~~
wp scaffold theme-tests [<theme>] [--dir=<dirname>] [--ci=<provider>] [--force]
~~~

The following files are generated by default:

* `phpunit.xml.dist` is the configuration file for PHPUnit.
* `.travis.yml` is the configuration file for Travis CI. Use `--ci=<provider>` to select a different service.
* `bin/install-wp-tests.sh` configures the WordPress test suite and a test database.
* `tests/bootstrap.php` is the file that makes the current theme active when running the test suite.
* `tests/test-sample.php` is a sample file containing the actual tests.
* `phpcs.ruleset.xml` is a collenction of PHP_CodeSniffer rules.

Learn more from the [plugin unit tests documentation](http://wp-cli.org/docs/plugin-unit-tests/).

**ENVIRONMENT**

The `tests/bootstrap.php` file looks for the WP_TESTS_DIR environment
variable.

**OPTIONS**

	[<theme>]
		The name of the theme to generate test files for.

	[--dir=<dirname>]
		Generate test files for a non-standard theme path. If no theme slug is specified, the directory name is used.

	[--ci=<provider>]
		Choose a configuration file for a continuous integration provider.
		---
		default: travis
		options:
		  - travis
		  - circle
		  - gitlab
		---

	[--force]
		Overwrite files that already exist.

**EXAMPLES**

    # Generate unit test files for theme 'twentysixteenchild'.
    $ wp scaffold theme-tests twentysixteenchild
    Success: Created test files.

## Installing

This package is included with WP-CLI itself, no additional installation necessary.

To install the latest version of this package over what's included in WP-CLI, run:

    wp package install git@github.com:wp-cli/scaffold-command.git

## Contributing

We appreciate you taking the initiative to contribute to this project.

Contributing isn’t limited to just code. We encourage you to contribute in the way that best fits your abilities, by writing tutorials, giving a demo at your local meetup, helping other users with their support questions, or revising our documentation.

### Reporting a bug

Think you’ve found a bug? We’d love for you to help us get it fixed.

Before you create a new issue, you should [search existing issues](https://github.com/wp-cli/scaffold-command/issues?q=label%3Abug%20) to see if there’s an existing resolution to it, or if it’s already been fixed in a newer version.

Once you’ve done a bit of searching and discovered there isn’t an open or fixed issue for your bug, please [create a new issue](https://github.com/wp-cli/scaffold-command/issues/new) with the following:

1. What you were doing (e.g. "When I run `wp post list`").
2. What you saw (e.g. "I see a fatal about a class being undefined.").
3. What you expected to see (e.g. "I expected to see the list of posts.")

Include as much detail as you can, and clear steps to reproduce if possible.

### Creating a pull request

Want to contribute a new feature? Please first [open a new issue](https://github.com/wp-cli/scaffold-command/issues/new) to discuss whether the feature is a good fit for the project.

Once you've decided to commit the time to seeing your pull request through, please follow our guidelines for creating a pull request to make sure it's a pleasant experience:

1. Create a feature branch for each contribution.
2. Submit your pull request early for feedback.
3. Include functional tests with your changes. [Read the WP-CLI documentation](https://wp-cli.org/docs/pull-requests/#functional-tests) for an introduction.
4. Follow the [WordPress Coding Standards](http://make.wordpress.org/core/handbook/coding-standards/).


*This README.md is generated dynamically from the project's codebase using `wp scaffold package-readme` ([doc](https://github.com/wp-cli/scaffold-package-command#wp-scaffold-package-readme)). To suggest changes, please submit a pull request against the corresponding part of the codebase.*
