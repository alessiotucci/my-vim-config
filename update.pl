#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;

# Change to the directory containing your git repository
chdir '/home/atucci/my-vim-config' or die "Cannot change directory: $!";

# Perform a git pull
system('git pull') == 0 or die "Git pull failed: $?";

# Define the source and destination for the .vimrc file
my $source = '/home/atucci/my-vim-config/.vimrc';
my $destination = '/home/atucci/.vimrc';

# Copy the .vimrc file to the home directory
copy($source, $destination) or die "Copy failed: $!";

print "Successfully updated .vimrc\n";

