include { INDEX_FAST5; CALL_METHYLATION; METH_FREQ; EVENTALIGN } from '../modules/methylation_process.nf'

workflow hurdle_nanomethvar_methylation {
    take:
    fast5
    fastq
    bam
    ref

    main:
    INDEX_FAST5(fast5, fastq)
    CALL_METHYLATION(bam, ref, fastq, INDEX_FAST5.out)
    METH_FREQ(CALL_METHYLATION.out)
    EVENTALIGN(bam, ref, fastq)

    emit:
    tuple(CALL_METHYLATION.out, METH_FREQ.out, EVENTALIGN.out)

}
