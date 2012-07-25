#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs;
use Acme::Term256::Animation::FLV;

my $anime = Acme::Term256::Animation::FLV->new({ file => './example/data/badapple.flv', loop => 1 });
$anime->run;

