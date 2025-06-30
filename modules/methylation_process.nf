process INDEX_FAST5 {
    input:
    path fast5_dir
    path fastq

    output:
    path "reads.fastq.index"

    script:
    """
    f5c index -d $fast5_dir $fastq
    """
}

process CALL_METHYLATION {
    input:
    path bam
    path ref
    path fastq
    path index

    output:
    path "result.tsv"

    script:
    """
    f5c call-methylation -b $bam -g $ref -r $fastq > result.tsv
    """
}

process METH_FREQ {
    input:
    path result

    output:
    path "freq.tsv"

    script:
    """
    f5c meth-freq -i $result > freq.tsv
    """
}

process EVENTALIGN {
    input:
    path bam
    path ref
    path fastq

    output:
    path "events.tsv"

    script:
    """
    f5c eventalign -b $bam -g $ref -r $fastq > events.tsv
    """
}
