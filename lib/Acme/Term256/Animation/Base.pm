package Acme::Term256::Animation::Base;
use strict;
use warnings;
use parent qw(Class::Accessor::Fast);
use Image::Term256Color;
use Time::HiRes qw( usleep );
use Digest::SHA1;

__PACKAGE__->mk_accessors(qw(file loop));

sub new {
    my $class = shift;
    my $args = shift;
    $args->{loop} = 0 unless $args->{loop} == 1;
    die 'require file name!' unless $args->{file};
    die 'target file does not exist!!' unless -e $args->{file};
    return $class->SUPER::new( $args );
}

sub get_hexdigest {
    my $self = shift;
    open my $fh, '<', $self->file or die "$self->file can't read!!";
    my $sha1 = Digest::SHA1->new;
    $sha1->addfile($fh);
    my $hexdigest = $sha1->hexdigest;
    close($fh);
    return $hexdigest;
}

sub get_scale_ratio {
    my $self = shift;
    my $args = shift || die;
    my $term_width = `tput cols`;
    my $term_height = `tput lines`;
    my $scale_height = $args->{height}/$term_height;
    my $scale_width = $args->{width}/$term_width;
    my $scale_ratio = $scale_height > $scale_width ? 1/$scale_height : 1/$scale_width;
    return $scale_ratio;
}

sub do_animation {
    my $self = shift;
    my $asciis = shift;

    # Clear the screen
    print "\033[2J";

    while(1) {
        for( @$asciis ) {
            print "\033[0;0H";
            print $_;
            usleep(66666);
        }
        last unless $self->loop;
    }
}

sub gif2ascii {
    my $self = shift;
    my $gif = shift;
    my $scale_ratio = shift;
    my $data;
    $gif->write(data => \$data, type => 'gif');
    my $ascii = Image::Term256Color::convert( $data, { scale_ratio => $scale_ratio } );
    return $ascii;
}

sub get_asciis {
    my $self = shift;
    die 'this method is abstract method!!';
}


sub run {
    my $self = shift;
    die 'this method is abstract method!!';
}


1;
__END__

=head1 NAME

Acme::Term256::Animation::Base -

=head1 AUTHOR

dameninngenn E<lt>dameninngenn.owata {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
