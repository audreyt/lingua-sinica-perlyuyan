#!/usr/bin/perl

use strict;
use inc::Module::Install;

all_from 'lib/Lingua/Sinica/PerlYuYan.pm';
requires 'Filter::Simple' => '0.70';

sign; WriteAll;
