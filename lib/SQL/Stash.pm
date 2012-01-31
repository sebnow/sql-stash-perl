package SQL::Stash;
use strict;
use warnings;

use v5.6;
use version v0.77;

our $VERSION = version->declare("v0.0.0");

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
differs by having instance-specific database handle, and by supporting
l<ResourcePool|ResourcePool>.

=head1 SEE ALSO

L<Ima::DBI|Ima::DBI>
L<SQL::Bibliosoph|SQL::Bibliosoph>
L<SQL::Snippet|SQL::Snippet>

=head1 AUTHOR

Sebastian Nowicki <sebnow@gmail.com>

=cut

