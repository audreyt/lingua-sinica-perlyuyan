#!/usr/bin/perl
# $File: //member/autrijus/Lingua-Sinica-PerlYuYan/Makefile.PL $ $Author: autrijus $
# $Revision: #2 $ $Change: 706 $ $DateTime: 2002/08/18 03:49:00 $

require 5.005;

use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR		=> 'Autrijus Tang (autrijus@autrijus.org)',
    ABSTRACT		=> 'Write Perl in Chinese',
    NAME		=> 'Lingua::Sinica::PerlYuYan',
    VERSION_FROM	=> 'PerlYuYan.pm', 
    DISTNAME		=> 'Lingua-Sinica-PerlYuYan',
    BINARY_LOCATION	=> 'x86/Lingua-Sinica-PerlYuYan.tar.gz',

    PREREQ_PM       => {
	'Filter::Simple'	=> '0.70',
    },

    dist		=> {
        COMPRESS	=> 'gzip -9',
        SUFFIX		=> '.gz',
    },
);

