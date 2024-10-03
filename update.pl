#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;
use File::HomeDir;

# Change to the directory containing your git repository
#chdir '/home/atucci/my-vim-config' or die "Cannot change directory: $!";

# Perform a git pull
system('git pull') == 0 or die "Git pull failed: $?";

# Get the home directory of the current user
my $home_dir = File::HomeDir->my_home;

# Define the source and destination for the .vimrc file
#my $source = '/home/atucci/my-vim-config/.vimrc';
my $source = '.vimrc';
my $destination = "$home_dir/.vimrc";

# Copy the .vimrc file to the home directory
copy($source, $destination) or die "Copy failed: $!";

print "Successfully updated .vimrc\n";

