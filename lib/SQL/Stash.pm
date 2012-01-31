package SQL::Stash;
use strict;
use warnings;

use v5.6;
use Carp qw(croak);
use version v0.77;

our $VERSION = version->declare("v0.0.0");

sub new {
	my ($class, %args) = @_;
	my $self = bless({}, $class);
	$self->{'dbh'} = $args{'dbh'} or croak("DBI handle missing");
	return $self;
}

1;

__END__

=head1 NAME

SQL::Stash - A stash for SQL queries

=head1 SYNOPSIS

=head1 DESCRIPTION

L<SQL::Stash|SQL::Stash> is a simple query library for SQL statements.
SQL statements are populated at the class level. SQL::Stash objects
prepare these statements as late as possible (i.e. before they are
executed).

SQL::Stash is in concept very similar to L<Ima::DBI|Ima::DBI>, but
differs by having instance-specific database handles and statements, and
by supporting externally defined database handles.

=head1 METHODS

=head2 new

	SQL::Stash->new(%args);

Designated constructor. Instantiates a new L<SQL::Stash|SQL::Stash>
object. The C<dbh> argument, a L<DBI|DBI>-like object,  must be
provided.

	my $dbh = DBI->connect('dbi:SQLite:dbname=:memory:', '', '');
	my $stash = SQL::Stash->new('dbh' => $dbh);

=head1 SEE ALSO

L<Ima::DBI|Ima::DBI>
L<SQL::Bibliosoph|SQL::Bibliosoph>
L<SQL::Snippet|SQL::Snippet>

=head1 AUTHOR

Sebastian Nowicki <sebnow@gmail.com>

=cut

