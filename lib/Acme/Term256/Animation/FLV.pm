package Acme::Term256::Animation::FLV;
use strict;
use warnings;
use parent qw(Acme::Term256::Animation::Base);
use Imager;
use Term::ProgressBar;

sub run {
    my $self = shift;
# XXX ここらへんちゃんとやる
    my $data_dir = 'example/_data/';
    my $command = sprintf('ffmpeg -i %s -f image2 -r 15 %s%s.gif',$self->file, $data_dir, '%10d');
    my $ret = system($command);
    my @filenames = glob $data_dir . "*.gif";
# $ret => 0  # ok
# ffmpeg確認
# file存在確認
# data/の掃除

    my $asciis = $self->get_asciis( \@filenames );
    $self->do_animation( $asciis );
}

sub get_asciis {
    my $self = shift;
    my $filenames = shift;

    my $progress = Term::ProgressBar->new({ count => scalar @$filenames });
    my $count = 0;
    my @asciis;
    my $scale_ratio;
    for( @$filenames ) {
        my $img = Imager->new;
        my $gif = $img->read( file => $_ ) or die $img->errstr;
        unless( $scale_ratio ) {
            $scale_ratio = $self->get_scale_ratio({
                width  => $gif->getwidth(),
                height => $gif->getheight(),
            });
        }
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

Acme::Term256::Animation::FLV -

=head1 SYNOPSIS

  use Acme::Term256::Animation::FLV;

=head1 DESCRIPTION

Acme::Term256::Animation::FLV is ugokuyo

=head1 AUTHOR

dameninngenn E<lt>dameninngenn.owata {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
