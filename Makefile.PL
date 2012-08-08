use inc::Module::Install;
name 'Acme-Term256-Animation';
all_from 'lib/Acme/Term256/Animation.pm';

requires (
    'Class::Accessor::Fast' => 0,
    'Image::Term256Color' => 0,
    'Time::HiRes' => 0,
    'Imager' => 0,
    'Term::ProgressBar' => 0,
    'File::Path' => 0,
    'Digest::SHA1' => 0,
);

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
