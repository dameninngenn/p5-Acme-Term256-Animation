#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs;
use Acme::Term256::Animation::GIF;

my $anime = Acme::Term256::Animation::GIF->new({ file => './example/data/mai.gif', loop => 1 });
$anime->run;

