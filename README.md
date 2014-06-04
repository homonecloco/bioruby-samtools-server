# bio-samtools-server

[![Build Status](https://secure.travis-ci.org/homonecloco/bioruby-samtools-server.png)](http://travis-ci.org/homonecloco/bioruby-samtools-server)

This is a standalone server to query BAM files (and the corresponding reference). The server will return the content of a BAM file in the selected folder when the server is started up. The server used is sintra.

Note: this software is under active development! 

## Installation

```sh
gem install bio-samtools-server
```

## Usage

```ruby
require 'bio-samtools-server'
```

The API doc is online. For more code examples see the test files in
the source tree.

To run the server:

```
bam-server.rb  -r FOLDER_WITH_REFERENCES --bam FOLDER_WITH_BAM_FILES
```

On the web browser, the following outputs are implemented (so far). The first element in the path is the file with the reference, the second the BAM file (without extension) and the parameter "region" is used to query 


WIG TEST:
```
http://localhost:4567/test_chr.fasta/testu/wig?region=chr_1:1-100&step_size=5
```
the param step_size sets the number of positions to be averaged. See the wiggle [documentation](http://genome.ucsc.edu/goldenPath/help/wiggle.html) 

ALIGNMENT TEST
```
http://localhost:4567/test_chr.fasta/testu/alignment?region=chr_1:1-100
```
LIST
```
http://localhost:4567/test_chr.fasta/testu/list
```
Reference
```
http://localhost:4567/test_chr.fasta/testu/reference?region=chr_1:1-100
```

## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/homonecloco/bioruby-samtools-server



## Cite

If you use this software, please cite one of

* [Bio-samtools: Ruby bindings for SAMtools, a library for accessing BAM files containing high-throughput sequence alignments](http://dx.doi.org/10.1186/1751-0473-7-6) 

## Biogems.info

This Biogem is published at (http://biogems.info/index.html#bio-samtools-server)

## Copyright

Copyright (c) 2014 homonecloco. See LICENSE.txt for further details.

