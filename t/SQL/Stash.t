#!/usr/bin/perl
use strict;
use warnings;

use Test::Exception;
use Test::MockModule;
use Test::More 'tests' => 5;

BEGIN {
	use_ok('SQL::Stash') or BAIL_OUT('Unable to use SQL::Stash');
};

subtest "Given the SQL::Stash class" => sub {
	my $mock_dbi = Test::MockModule->new('DBI');
	$mock_dbi->mock('connect', sub {return bless({}, shift)});
	throws_ok(sub {SQL::Stash->new()}, qr/DBI handle missing/,
		"when the class is instantiated and a DBI handle is not provided ".
		"then an exception should be thrown");
	lives_ok(sub {SQL::Stash->new('dbh' => DBI->connect())},
		"when the class is instantiated and a DBI handle is provided ".
		"then an an instance should be created");
};

package SQL::Stash::Dummy;
use base qw(SQL::Stash);
1;

package main;

subtest "Given a new SQL::Stash instance containing queries" => sub {
	my $dbh = DBI->connect("dbi:Mock:", "", "");
	my $stash = SQL::Stash->new('dbh' => $dbh);
	$stash->stash('select_dummy', 'SELECT * FROM Dummy');
	my $sth = $stash->retrieve('select_dummy');
	ok(ref($sth) && $sth->isa('DBI::st'),
		"when a statement is retrieved from the stash ".
		"and the result is a DBI statement");
	is($sth->{'mock_statement'}, 'SELECT * FROM Dummy',
		"when a statement is popped from the stash ".
		"then the stashed SQL query is prepared");
};

subtest "Given an empty SQL::Stash instance" => sub {
	my $dbh = DBI->connect("dbi:Mock:", "", "");
	my $stash = SQL::Stash->new('dbh' => $dbh);
	my $sth = $stash->retrieve('select_dummy');
	is($sth, undef,
		"when a statement is retrieved which was not stashed ".
		"then the result is undefined");
};

subtest "Instance specific stash" => sub {
	my $dbh = DBI->connect("dbi:Mock:", "", "");
	my $stash = SQL::Stash->new('dbh' => $dbh);
	SQL::Stash->stash('select_dummy', 'SELECT * FROM Dummy');
	my $sth = $stash->retrieve('select_dummy');
	is($sth->{'mock_statement'}, 'SELECT * FROM Dummy',
		"when a statement is stashed in the class stash ".
		"then the statement can be retrieved from an instance");
	$stash->stash('select_dummy', 'SELECT col1 FROM Dummy');
	$sth = $stash->retrieve('select_dummy');
	is($sth->{'mock_statement'}, 'SELECT col1 FROM Dummy',
		"when a statement is stashed in the instance stash ".
		"then the class statement will be overwritten");
};

