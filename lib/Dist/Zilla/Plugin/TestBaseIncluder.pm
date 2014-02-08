package Dist::Zilla::Plugin::TestBaseIncluder;

use Moose;

extends 'Dist::Zilla::Plugin::ModuleIncluder';

has module => (
  isa => 'ArrayRef[Str]',
  traits => ['Array'],
  handles => {
    modules => 'elements',
  },
  default => sub {[qw(
    Test::Base
  )]},
);

has blacklist => (
    isa => 'ArrayRef[Str]',
    traits => ['Array'],
    handles => {
        blacklisted_modules => 'elements',
    },
    default => sub {[qw(
        XXX
    )]},
);


sub gather_files {
  my $self = shift;
  my $testbase = '../test-base-pm';
  if (
    -d "$testbase/.git"
  ) {
    eval "use lib '$testbase/lib'; 1" or die $@;
  }
  $self->SUPER::gather_files(@_);
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;

=encoding utf8

=head1 NAME

Dist::Zilla::Plugin::TestBaseIncluder - Ship your Test::Base version

=head1 SYNOPSIS

In dist.ini:

   [TestBaseIncluder]

=head1 DESCRIPTION

This module includes the version of Test::Base on your system with your module
dist.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2014. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
