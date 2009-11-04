#!/usr/bin/perl
use inc::Module::Install;

author undef;
license 'CC0';

all_from 'lib/Lingua/Sinica/PerlYuYan.pm';
readme_from 'lib/Lingua/Sinica/PerlYuYan.pm';

requires qw( Filter::Simple::Compile 0.02 );

WriteAll;
