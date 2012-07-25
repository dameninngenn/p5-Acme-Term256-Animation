package Acme::Term256::Animation::GIF;
use strict;
use warnings;
use parent qw(Acme::Term256::Animation::Base);
use Imager;
use Term::ProgressBar;

sub run {
    my $self = shift;
    my $img = Imager->new;
    # $self->file のvalidation
    my @gif = $img->read_multi( file => $self->file ) or die $img->errstr;
    # XXX gifかどうかのチェックいれたいね

    my $asciis = $self->get_asciis( \@gif );
    $self->do_animation( $asciis );
}

sub get_asciis {
    my $self = shift;
    my $gif_ary_ref = shift;
    my $scale_ratio = $self->get_scale_ratio({
        width  => $gif_ary_ref->[0]->getwidth(),
        height => $gif_ary_ref->[0]->getheight(),
    });

    my @asciis;
    my $count = 0;
    my $progress = Term::ProgressBar->new({ count => scalar @$gif_ary_ref });
    for my $gif ( @$gif_ary_ref ) { 
        my $ascii = $self->gif2ascii( $gif, $scale_ratio );
        push( @asciis, $ascii );
        $count++;
        $progress->update($count);
    }
    return \@asciis;
}


1;
__END__

=head1 NAME

Acme::Term256::Animation::GIF -

=head1 SYNOPSIS

  use Acme::Term256::Animation::GIF;

=head1 DESCRIPTION

Acme::Term256::Animation::GIF is ugokuyo

=head1 AUTHOR

dameninngenn E<lt>dameninngenn.owata {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
